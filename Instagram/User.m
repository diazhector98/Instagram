//
//  User.m
//  Instagram
//
//  Created by Hector Diaz on 7/11/18.
//  Copyright © 2018 Hector Diaz. All rights reserved.
//

#import "User.h"

@implementation User

@dynamic username;
@dynamic userId;
@dynamic bio;
@dynamic profileImage;
@dynamic followersCount;
@dynamic followingCount;
@dynamic postCount;

+ (nonnull NSString *)parseClassName {
    return @"InstagramUser";
}

+ (void) postUser: ( UIImage * _Nullable )image withUsername: ( NSString * _Nullable )username withUserId: ( NSString * _Nullable )userId withBio: (NSString * _Nullable) bio withCompletion: (PFBooleanResultBlock  _Nullable)completion{
    
    User *newUser = [User new];
    
    newUser.profileImage = [self getPFFileFromImage:image];
    
    newUser.userId = userId;
    
    newUser.username = username;
    
    newUser.followingCount = 0;
    
    newUser.followersCount = 0;
    
    newUser.postCount = 0;
    
    newUser.bio = bio;
    
    [newUser saveInBackgroundWithBlock:completion];
    
    
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
