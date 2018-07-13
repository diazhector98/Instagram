//
//  User.h
//  Instagram
//
//  Created by Hector Diaz on 7/11/18.
//  Copyright © 2018 Hector Diaz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PFObject.h"
#import "Parse.h"

@interface User : PFObject <PFSubclassing>


@property (nonatomic, strong) NSString *userId;

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *bio;

@property (nonatomic, strong) PFFile *profileImage;

@property (nonatomic, strong) NSNumber *postCount;
@property (nonatomic, strong) NSNumber *followersCount;
@property (nonatomic, strong) NSNumber *followingCount;

+ (void) postUser: ( UIImage * _Nullable )image withUsername: ( NSString * _Nullable )username withUserId: ( NSString * _Nullable )userId withBio: (NSString * _Nullable) bio withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end
