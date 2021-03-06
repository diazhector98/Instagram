//
//  Post.m
//  Instagram
//
//  Created by Hector Diaz on 7/9/18.
//  Copyright © 2018 Hector Diaz. All rights reserved.
//

#import "Post.h"
#import "Parse.h"
#import <CoreLocation/CoreLocation.h>

@implementation Post

@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic caption;
@dynamic image;
@dynamic likeCount;
@dynamic commentCount;
@dynamic name;
@dynamic date;
@dynamic latitude;
@dynamic longitude;

+ (nonnull NSString *)parseClassName {
    return @"Post";
}

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withLongitude: (double) longitude withLatitude: (double) latitude withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Post *newPost = [Post new];
    
    newPost.image = [self getPFFileFromImage:image];
    
    newPost.author = [PFUser currentUser];
    
    newPost.name = newPost.author.username;
    
    newPost.date = [NSDate date];
    
    newPost.caption = caption;
    
    newPost.likeCount = @(0);
    
    newPost.commentCount = @(0);
    
    newPost.latitude = latitude;
    
    newPost.longitude = longitude;
    
    [newPost saveInBackgroundWithBlock: completion];
}

+ (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image {
    
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFile fileWithName:@"image.png" data:imageData];
}


@end
