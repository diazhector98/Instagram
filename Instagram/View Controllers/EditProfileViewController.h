//
//  EditProfileViewController.h
//  Instagram
//
//  Created by Hector Diaz on 7/11/18.
//  Copyright © 2018 Hector Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *bioTextField;

@end
