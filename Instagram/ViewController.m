//
//  ViewController.m
//  Instagram
//
//  Created by Hector Diaz on 7/9/18.
//  Copyright © 2018 Hector Diaz. All rights reserved.
//

#import "ViewController.h"
#import "Parse.h"
#import "Post.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registerUser {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameTextField.text;
    
    newUser.password = self.passwordTextField.text;
    
    UIImage *image = [UIImage imageNamed:@"image_placeholder"];
    
    PFFile *file = [self getPFFileFromImage:image];
    
    [newUser setValue:file forKey:@"profilePicture"];
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        
        if (error != nil) {
            
            NSLog(@"Error: %@", error.localizedDescription);
            
        } else {
            
            NSLog(@"User registered successfully");
            
            [self performSegueWithIdentifier:@"homeFeedSegue" sender:self];
            
            
            // manually segue to logged in view
        }
    }];
    
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

-(void) loginUser {
    
    NSString *username = self.usernameTextField.text;
    
    NSString *password = self.passwordTextField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        
        if (error != nil) {
            
            NSLog(@"User log in failed: %@", error.localizedDescription);
            
        } else {
            
            NSLog(@"User logged in successfully");
            
            [self performSegueWithIdentifier:@"homeFeedSegue" sender:self];

            // display view controller that needs to shown after successful login
        }
    }];
    
}

- (IBAction)didPressLogin:(id)sender {
    
    
    [self loginUser];
    
}

- (IBAction)didPressView:(id)sender {
    
    [self.view endEditing:YES];
}


- (IBAction)didPressSignUp:(id)sender {
    
    [self registerUser];
    
}


@end
