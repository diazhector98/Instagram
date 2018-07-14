//
//  StoriesViewController.h
//  Instagram
//
//  Created by Hector Diaz on 7/13/18.
//  Copyright © 2018 Hector Diaz. All rights reserved.
//

#import "ViewController.h"

@interface StoriesViewController : ViewController

@property (strong, nonatomic) NSArray *stories;
@property (nonatomic) int currentStory;
@property (nonatomic) double secondsInStory;
@property (strong, nonatomic) NSTimer *timer;

@property (weak, nonatomic) IBOutlet UIImageView *storyImageView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;



@end
