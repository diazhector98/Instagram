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
#import "Story.h"
#import "StoriesViewController.h"


@interface HomeFeedViewController () <UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource>

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
    
    [self getStoriesFromParse];
    
}

-(void) getPostsFromParse {
    
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
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

-(void) getStoriesFromParse {
    
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Story"];
    
    [query orderByDescending:@"createdAt"];
    
    [query includeKey:@"author"];

    query.limit = 20;
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *stories, NSError *error) {
        
        if (stories != nil) {
            // do something with the array of object returned by the call
            
            self.stories = stories;
            
            
        } else {
            
            NSLog(@"%@", error.localizedDescription);
            
            [self.refreshControl endRefreshing];
            
            
        }
    }];
    
    
}


- (IBAction)didTapGlobalStory:(id)sender {
    
    NSLog(@"Global story tapped");
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Global Story" message:@"Choose Action" preferredStyle: UIAlertControllerStyleActionSheet];
    
    UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"Add" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self selectImageForStories];
    
    }];
    
    UIAlertAction *viewAction = [UIAlertAction actionWithTitle:@"View" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self performSegueWithIdentifier:@"storiesSegue" sender:self];
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style: UIAlertActionStyleDefault handler: nil];
    
    [alert addAction: addAction];
    
    [alert addAction:viewAction];
    
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];

    
    
}

-(void) selectImageForStories {
    
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    
    imagePickerVC.delegate = self;
    
    imagePickerVC.allowsEditing = YES;
    
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Select Source" message:@"From where do you want your image?" preferredStyle: UIAlertControllerStyleActionSheet];
    
    UIAlertAction *galleryAction = [UIAlertAction actionWithTitle:@"Gallery" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:imagePickerVC animated:YES completion:nil];
        
        
    }];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        imagePickerVC.cameraViewTransform = CGAffineTransformMakeScale(1.0, 1.03);
        
        [self presentViewController:imagePickerVC animated:YES completion:nil];
        
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    [alert addAction: galleryAction];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        [alert addAction:cameraAction];
        
        [alert addAction:cancelAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    } else {
        
        [self presentViewController:imagePickerVC animated:YES completion:nil];
        
    }
    
    
}


-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    NSLog(@"Finished picking picture");
    
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    [self addStoryToParse:editedImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];

    
}

-(void) addStoryToParse: (UIImage *) image {
    
    [Story postStory:image withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        
        
        if(error != nil) {
            
            NSLog(@"Error uploading: %@", error.description);
            
        } else {
            
            NSLog(@"Story uploaded successfully");
            
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
    
//    Change images (post and profile picture)
    
    PFFile *imageFile = post.image;
    
    [imageFile getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        
        if(data) {
            
            cell.postImageView.image = [UIImage imageWithData:data];
            
        }
        
    }];
    
    PFUser *user = post.author;
    
    PFFile *profileImageFile = [user valueForKey:@"profilePicture"];
    
    //    Profile Image
    
    [profileImageFile getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        
        if(data) {
            
            NSLog(@"Data recieved for image");
            
            cell.profileImageView.image = [UIImage imageWithData:data];
            
        }
        
    }];
    
    
    
    
    //    Change labels
    
    [cell.captionLabel sizeToFit];
    
    cell.captionLabel.text = post.caption;
    
    if(post.name) {
        
        cell.usernameLabel.text = post.name;
        
    }
    
    if(post.date) {
                
        cell.timestampLabel.text = post.date.shortTimeAgoSinceNow;
        
    }
    
    if(post.longitude && post.latitude) {
        
        cell.locationLabel.text = [NSString stringWithFormat:@"%f , %f", post.latitude, post.longitude];
        
    }
        
    cell.post = post;
    
    [cell.locationLabel sizeToFit];
    [cell.captionLabel sizeToFit];
    [cell.timestampLabel sizeToFit];
    [cell.usernameLabel sizeToFit];
    
    cell.profileImageView.layer.masksToBounds = YES;
    
    cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.size.width / 2;
    
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
        
    } else if([segue.identifier isEqualToString:@"storiesSegue"]){
        
        StoriesViewController *viewController = [segue destinationViewController];
        
        viewController.stories = self.stories;
        
        NSLog(@"Stories!!");
        
    }
}


@end
