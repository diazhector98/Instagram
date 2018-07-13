//
//  DetailViewController.m
//  Instagram
//
//  Created by Hector Diaz on 7/9/18.
//  Copyright © 2018 Hector Diaz. All rights reserved.
//

#import "DetailViewController.h"
#import "DateTools.h"
#import "YelpManager.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"%@", self.post);
    
    [self changeUI];
    
}

-(void) changeUI {
    
//    Change labels
    self.captionLabel.text = self.post.caption;
    
    PFUser *user = self.post.author;
    
//    Change Image
    
    NSString *name = @"User";
    
    if(self.post.name) {
        
        name = self.post.name;
        
    }
    
    self.usernameLabel.text = name;
    
    PFFile *imageFile = self.post.image;
    
    [imageFile getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        
        if(data) {
            
            self.postImageView.image = [UIImage imageWithData:data];
            
        }
        
    }];
    
    if(self.post.date) {
        
        NSString *dateString = [self.post.date descriptionWithLocale:[NSLocale currentLocale]];
        
        self.timestampLabel.text = self.post.date.shortTimeAgoSinceNow;
        
    }
    
//    Get events
    
    
    if(self.post.longitude && self.post.latitude) {
        
        NSString *latitude = [NSString stringWithFormat:@"%f", self.post.latitude];
        
        NSString *longitude = [NSString stringWithFormat:@"%f", self.post.longitude];
        
        YelpManager *yelpManager = [YelpManager new];
        
        [yelpManager getEventsWithLatitude:latitude withLongitude:longitude withCompletion:^(NSDictionary *dictionary, NSError *error) {
           
            if(error != nil) {
                
                NSLog(@"Error with api call");
                
                
            } else {
                
                NSArray *array = dictionary[@"events"];
                if(array.count > 0){
                    NSDictionary *event = array[0];
                
                    NSString *eventName = event[@"name"];
                
                    self.eventLabel.text = eventName;
                }
                else{
                    self.eventLabel.text = @"No events here.";
                }
                                
            }
            
        }];

    }
    
    
    
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
