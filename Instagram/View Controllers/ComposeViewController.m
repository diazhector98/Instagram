//
//  ComposeViewController.m
//  Instagram
//
//  Created by Hector Diaz on 7/9/18.
//  Copyright © 2018 Hector Diaz. All rights reserved.
//

#import "ComposeViewController.h"
#import "Post.h"
#import "MBProgressHUD.h"
#import <CoreLocation/CoreLocation.h>

@interface ComposeViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, MKMapViewDelegate>

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    [self.locationManager requestWhenInUseAuthorization];
        
    self.mapView.delegate = self;
    
    UILongPressGestureRecognizer *gestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    
    [self.mapView addGestureRecognizer:gestureRecognizer];
    
    NSArray *annotations = [self.mapView annotations];
    
    [self.mapView showAnnotations:annotations animated:YES];
    
//    Set scrollview size
    
    CGFloat maxHeight = self.mapView.frame.origin.y + self.mapView.frame.size.height + 30;
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, maxHeight);
    
}

-(void)handleLongPressGesture:(UIGestureRecognizer*)sender {
    // This is important if you only want to receive one tap and hold event
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        [self.mapView removeGestureRecognizer:sender];
        
        
    }
    else
    {
        // Here we get the CGPoint for the touch and convert it to latitude and longitude coordinates to display on the map
        CGPoint point = [sender locationInView:self.mapView];
        
        CLLocationCoordinate2D locCoord = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
        
        MKPointAnnotation *annotation = [MKPointAnnotation new];
        
        annotation.coordinate = locCoord;
        
        annotation.title = self.captionTextView.text;
        
        [self.mapView addAnnotation:annotation];
        
        self.longitude = locCoord.longitude;
        self.latitude = locCoord.latitude;
        
        
        
        NSLog(@"Lat: %f Lon: %f", locCoord.latitude, locCoord.longitude);
        // Then all you have to do is create the annotation and add it to the map
        
        
    }
}

- (IBAction)didPressVIew:(id)sender {
    
    [self.view endEditing:YES];
}


- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views {
    
    NSLog(@"Annotation added");
    
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
//    NSArray *annotations = [mapView annotations];
//    
//    [mapView showAnnotations:annotations animated:YES];
//    
//    NSLog(@"Updated location");
    
    
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    NSLog(@"Did sselect annotationview");
    
}


-(void) placeMapViewOnCurrentLocation {
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
    
    if (annotationView == nil) {
        
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
        
        annotationView.canShowCallout = true;
        
        annotationView.leftCalloutAccessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50.0, 50.0)];
    }
    
    UIImageView *imageView = (UIImageView*)annotationView.leftCalloutAccessoryView;
    
    imageView.image = self.photoImageView.image;
    
    return annotationView;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didPressedImageview:(id)sender {
    
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    
    imagePickerVC.delegate = self;
    
    imagePickerVC.allowsEditing = YES;
    
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Select Source" message:@"From where do you want your image?" preferredStyle: UIAlertControllerStyleActionSheet];
    
    UIAlertAction *galleryAction = [UIAlertAction actionWithTitle:@"Gallery" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:imagePickerVC animated:YES completion:nil];

        
    }];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:imagePickerVC animated:YES completion:nil];
        
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    [alert addAction: galleryAction];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {

        [alert addAction:cameraAction];
        
        [alert addAction:cancelAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    } else {
        
        [self presentViewController:imagePickerVC animated:YES completion:nil];
        
    }
    
}

- (IBAction)didPressShare:(id)sender {
    
    UIImage *image = self.photoImageView.image;
    
    NSString *caption = self.captionTextView.text;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    [Post postUserImage:image withCaption:caption withLongitude:self.longitude withLatitude:self.latitude withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        
        if(error != nil){
            
            NSLog(@"%@", error.localizedDescription);
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        } else {
            
            NSLog(@"Image uploaded successfully!");
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
        
    }];
   
}





-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
        
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    self.photoImageView.image = editedImage;
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)didPressCancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
