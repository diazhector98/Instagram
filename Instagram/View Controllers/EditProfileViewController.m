//
//  EditProfileViewController.m
//  Instagram
//
//  Created by Hector Diaz on 7/11/18.
//  Copyright © 2018 Hector Diaz. All rights reserved.
//

#import "EditProfileViewController.h"
#import "Parse.h"

@interface EditProfileViewController () <UIImagePickerControllerDelegate>

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    Get bio and name
    
    PFUser *user = [PFUser currentUser];
    
    self.nameTextField.text = user.username;
    
    if([user valueForKey:@"bio"]){
        
        self.bioTextField.text = [user valueForKey:@"bio"];
        
    }
    
//    Image
    
    PFFile *imageFile = [user valueForKey:@"profilePicture"];
    
    [imageFile getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        
        if(data) {
                        
            self.profileImageView.image = [UIImage imageWithData:data];
            
        }
        
    }];
    
    self.profileImageView.layer.masksToBounds = YES;
    
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didPressChangeProfilePhoto:(id)sender {

    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    
    imagePickerVC.delegate = self;
    
    imagePickerVC.allowsEditing = YES;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        
    } else {
        
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        
    }
    [self presentViewController:imagePickerVC animated:YES completion:nil];
    

}


-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    self.profileImageView.image = editedImage;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (IBAction)didTapView:(id)sender {
    
    [self.view endEditing:YES];
    
}


- (IBAction)didPressDone:(id)sender {
    
    PFUser *user = [PFUser currentUser];
    
    UIImage *image = self.profileImageView.image;
    
    PFFile *file = [self getPFFileFromImage:image];
    
    [user setValue:file forKey:@"profilePicture"];
    
    NSString *bio = self.bioTextField.text;
    
    [user setValue:bio forKey:@"bio"];
    
    [user saveInBackground];

}


- (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image {
    
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFile fileWithName:@"image.png" data:imageData];
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
