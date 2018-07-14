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
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval: 0.01 target:self selector:@selector(storyTimer) userInfo:nil repeats:YES];
    [self setupStories];
    
}

-(void) setupStories {
    
    NSLog(@"%lu", self.stories.count);
    
    if(self.stories.count == 0) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        
    } else {
        
        [self setImage:0];

    }
    
}

-(void) storyTimer {
    
    self.secondsInStory += 0.01;
    
    double totalSeconds = 4.0;
    
    if(self.secondsInStory >= totalSeconds) {
        
        self.currentStory += 1;
        
        [self setImage:self.currentStory];
        
        self.secondsInStory = 0;
        
    }
    
    [self.progressBar setProgress: self.secondsInStory / totalSeconds];
    
}

-(void) setImage: (int) index {
    
    if(index == self.stories.count) {
        
        NSLog(@"end of stories");
        
        [self.timer invalidate];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else {
        
        Story *firstStory = self.stories[index];
        
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
    
    
    self.currentStory += 1;
    
    NSLog(@"%i", self.currentStory);
    
    self.secondsInStory = 0;
    
    [self setImage:self.currentStory];
    
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
