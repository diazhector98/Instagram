//
//  ProfileViewController.m
//  Instagram
//
//  Created by Hector Diaz on 7/11/18.
//  Copyright © 2018 Hector Diaz. All rights reserved.
//

#import "ProfileViewController.h"
#import "PictureCollectionViewCell.h"
#import "Parse.h"
#import "Post.h"

@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *imagesCollectionView;
@property (strong, nonatomic) NSArray *posts;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UIButton *editProfileButton;

@property (weak, nonatomic) IBOutlet UILabel *postsLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;


@property (weak, nonatomic) IBOutlet UILabel *bioLabel;

@end

@implementation ProfileViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    [self handleUserInfo];
    
    [self handleImages];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    Button
    
    [self.editProfileButton.layer setBorderColor:[[UIColor blackColor] CGColor] ];
    
    [self.editProfileButton.layer setBorderWidth:2.0];
    
    self.editProfileButton.layer.cornerRadius = 5;
    
    
//    Profile Image
    self.profileImageView.layer.masksToBounds = YES;
    
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    
//    Collection View
    self.imagesCollectionView.delegate = self;
    
    self.imagesCollectionView.dataSource = self;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.imagesCollectionView.collectionViewLayout;
    
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 4;
    
    CGFloat insetTop = 2;
    
    CGFloat insetLeft = 2;
    
    CGFloat insetRight = 2;
    
    CGFloat insetBottom = 2;
    
    layout.sectionInset =  UIEdgeInsetsMake(insetTop, insetLeft, insetBottom, insetRight);
    
    CGFloat imagesPerLine = 3;
    
    CGFloat width = (self.imagesCollectionView.frame.size.width - 6 * imagesPerLine) / imagesPerLine;
    
    CGFloat height = width;
    
    layout.itemSize = CGSizeMake(width, height);

}

-(void) handleUserInfo {
    
    PFUser *user = [PFUser currentUser];
    
    NSString *username = user.username;
    
    self.usernameLabel.text = username;
    
    //    Bio
    
    NSString *bio = [user valueForKey:@"bio"];
    
    if(bio) {
        
        self.bioLabel.text = bio;
        
    }
    
    [self.bioLabel sizeToFit];
    
    //    Profile Image
    PFFile *imageFile = [user valueForKey:@"profilePicture"];
    
    [imageFile getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        
        if(data) {
            
            NSLog(@"Data recieved for image");
            
            self.profileImageView.image = [UIImage imageWithData:data];
            
        }
        
    }];
    
    
    
}

-(void) handleImages {
    
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    
    [query orderByDescending:@"createdAt"];
    
    PFUser *user = [PFUser currentUser];
    
    [query whereKey:@"name" equalTo: user.username];
    
    query.limit = 20;
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        
        if (posts != nil) {
            
            self.posts = posts;
            
            self.postsLabel.text = [NSString stringWithFormat:@"%lu", posts.count ];
            
            [self.imagesCollectionView reloadData];
            
        } else {
            
            NSLog(@"%@", error.localizedDescription);
            
            
        }
    }];
    
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.posts.count;
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pictureCell" forIndexPath:indexPath];
    
    Post *post = self.posts[indexPath.row];
    
    PFFile *imageFile = post.image;
    
    [imageFile getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        
        if(data) {
            
            cell.pictureImageView.image = [UIImage imageWithData:data];
            
        }
        
    }];
    
    return cell;
    
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
