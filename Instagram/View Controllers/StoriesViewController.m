//
//  StoriesViewController.m
//  Instagram
//
//  Created by Hector Diaz on 7/13/18.
//  Copyright © 2018 Hector Diaz. All rights reserved.
//

#import "StoriesViewController.h"
#import "Story.h"

@interface StoriesViewController ()

@end

@implementation StoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupStories];
    
}

-(void) setupStories {
    
    NSLog(@"%lu", self.stories.count);
    
    if(self.stories.count == 0) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        
    } else {
        
        self.currentStory = 0;
        
        Story *firstStory = self.stories[0];
        
        PFFile *imageFile = firstStory.image;
        
        [imageFile getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
            
            if(data) {
                
                UIImage *image = [UIImage imageWithData:data];
                
                self.storyImageView.image = image;
                
            } else {
                
                NSLog(@"Error converting image");
                
            }
            
        }];

    }
    
}

- (IBAction)didPressImage:(id)sender {
    
    
    if(self.currentStory == self.stories.count - 1) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else {
        
        self.currentStory += 1;
        
        Story *firstStory = self.stories[self.currentStory];
        
        PFFile *imageFile = firstStory.image;
        
        [imageFile getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
            
            if(data) {
                
                UIImage *image = [UIImage imageWithData:data];
                
                self.storyImageView.image = image;
                
            } else {
                
                NSLog(@"Error converting image");
                
            }
            
        }];
        
        
    }
    
}


- (IBAction)didPressX:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
