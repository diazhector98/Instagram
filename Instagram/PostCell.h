//
//  PostCell.h
//  Instagram
//
//  Created by Hector Diaz on 7/9/18.
//  Copyright © 2018 Hector Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@protocol PostCellDelegate;

@interface PostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *postImageView;

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UILabel *captionLabel;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

@property (strong, nonatomic) Post *post;

@property (nonatomic, weak) id<PostCellDelegate> delegate;

@property (nonatomic) BOOL hasBeenLiked;

@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@end

@protocol PostCellDelegate

-(void) postCell: (PostCell *) cell didTap: (Post *) post;

@end

