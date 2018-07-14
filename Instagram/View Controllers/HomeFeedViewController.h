//
//  HomeFeedViewController.h
//  Instagram
//
//  Created by Hector Diaz on 7/9/18.
//  Copyright © 2018 Hector Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@interface HomeFeedViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *postsTableView;

@property (weak, nonatomic) IBOutlet UIImageView *globalStoryImage;

@property (strong, nonatomic) NSArray *posts;

@property (strong, nonatomic) NSArray *stories;

@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end
