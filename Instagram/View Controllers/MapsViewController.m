//
//  MapsViewController.m
//  Instagram
//
//  Created by Hector Diaz on 7/12/18.
//  Copyright © 2018 Hector Diaz. All rights reserved.
//

#import "MapsViewController.h"
#import "Parse.h"
#import "Post.h"

@interface MapsViewController () <MKMapViewDelegate>

@end

@implementation MapsViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    [self fetchPosts];
        
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mapView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) fetchPosts {
    
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    
    [query orderByDescending:@"createdAt"];
    
    PFUser *user = [PFUser currentUser];
    
    [query whereKey:@"name" equalTo: user.username];
    
    query.limit = 20;
    
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        
        if (posts != nil) {
            // do something with the array of object returned by the call
            
            self.posts = posts;
            
            [self populateMap];
            
            
        } else {
            
            NSLog(@"%@", error.localizedDescription);
            
            
        }
    }];
    
    
}

-(void) populateMap {
    
    for(Post *post in self.posts){
        
        double latitude = post.latitude;
        
        double longitude = post.longitude;
        
        NSLog(@"%f , %f", latitude, longitude);
        
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        
        MKPointAnnotation *annotation = [MKPointAnnotation new];
        
        annotation.coordinate = coordinate;
        
        annotation.title = post.caption;
        
        [self.mapView addAnnotation:annotation];

        
    }
    
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views {
    NSLog(@"Annotation added");
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
    
    if (annotationView == nil) {
        
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
        
        NSLog(@"%f %f", annotationView.frame.size.height, annotationView.frame.size.width);
        
        annotationView.canShowCallout = true;
        
        
        annotationView.leftCalloutAccessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50, 150.0)];
    }
    
    UIImageView *imageView = (UIImageView*)annotationView.leftCalloutAccessoryView;
    
//    Go through every post in the array and compare coordinates
    
    for(Post *post in self.posts) {
        
        double latitude = post.latitude;
        
        double longitude = post.longitude;
        
        double latitudeAnnotation = annotation.coordinate.latitude;
        
        double longitudeAnnotation = annotation.coordinate.longitude;
        
        if(latitude == latitudeAnnotation && longitude == longitudeAnnotation) {
            
            PFFile *imageFile = post.image;

            [imageFile getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
                
                if(data) {
                    
                    imageView.image = [UIImage imageWithData:data];

                }
                
            }];
            
        }
        
    }
    
    
    return annotationView;
    
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
