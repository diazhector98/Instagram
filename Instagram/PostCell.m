//
//  PostCell.m
//  Instagram
//
//  Created by Hector Diaz on 7/9/18.
//  Copyright © 2018 Hector Diaz. All rights reserved.
//

#import "PostCell.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (IBAction)didTapLike:(id)sender {
    
    
    if(self.hasBeenLiked) {
        
        [self.likeButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        
        self.hasBeenLiked = NO;

    } else {
        
        self.hasBeenLiked = YES;
        
        [self.likeButton setImage:[UIImage imageNamed:@"likeRed"] forState:UIControlStateNormal];

    }
    
    
}



@end
