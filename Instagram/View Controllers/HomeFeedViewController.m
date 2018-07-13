//
//  HomeFeedViewController.m
//  Instagram
//
//  Created by Hector Diaz on 7/9/18.
//  Copyright © 2018 Hector Diaz. All rights reserved.
//

#import "HomeFeedViewController.h"
#import "Parse.h"
#import "PostCell.h"
#import "Post.h"
#import "DetailViewController.h"
#import "DateTools.h"


@interface HomeFeedViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation HomeFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    self.postsTableView.rowHeight = 555;
    
    self.postsTableView.dataSource = self;
    
    self.postsTableView.delegate = self;
    
    [self.refreshControl addTarget:self action:@selector(getPostsFromParse) forControlEvents:UIControlEventValueChanged];
    
    [self.postsTableView insertSubview:self.refreshControl atIndex:0];

    [self getPostsFromParse];
    
}

-(void) getPostsFromParse {
    
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    
    [query orderByDescending:@"createdAt"];
    
    query.limit = 20;
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        
        if (posts != nil) {
            // do something with the array of object returned by the call
            
            self.posts = posts;
            
            [self.postsTableView reloadData];
            
            [self.refreshControl endRefreshing];
        
        } else {
            
            NSLog(@"%@", error.localizedDescription);
            
            [self.refreshControl endRefreshing];

        
        }
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.posts.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"postCell" forIndexPath:indexPath];

    Post *post = self.posts[indexPath.row];
    
    PFFile *imageFile = post.image;
    
    [imageFile getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        
        if(data) {
            
            cell.postImageView.image = [UIImage imageWithData:data];
            
        }
        
    }];
    
    //    Change labels
    
    [cell.captionLabel sizeToFit];
    
    cell.captionLabel.text = post.caption;
    
    if(post.name) {
        
        cell.usernameLabel.text = post.name;
        
    }
    
    if(post.date) {
        
        NSString *dateString = [post.date descriptionWithLocale:[NSLocale currentLocale]];
        
        cell.timestampLabel.text = post.date.shortTimeAgoSinceNow;
        
    }
    
    if(post.longitude && post.latitude) {
        
        cell.locationLabel.text = [NSString stringWithFormat:@"%f , %f", post.latitude, post.longitude];
        
    }
        
    cell.post = post;
    
    return cell;
    
}


- (IBAction)didPressLogout:(id)sender {
    
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"postDetailSegue"]){
        
        DetailViewController *viewController = [segue destinationViewController];
        
        PostCell *postCell = (PostCell *) sender;
        
        Post *post = postCell.post;
                
        viewController.post = post;
        
    }
}


@end
