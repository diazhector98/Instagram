//
//  Post.h
//  Instagram
//
//  Created by Hector Diaz on 7/9/18.
//  Copyright © 2018 Hector Diaz. All rights reserved.
//

#import "PFObject.h"
#import "Parse.h"
#import <CoreLocation/CoreLocation.h>

@interface Post : PFObject <PFSubclassing>

@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFUser *author;

@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) PFFile *image;
@property (nonatomic, strong) NSNumber *likeCount;
@property (nonatomic, strong) NSNumber *commentCount;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDate *date;

@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withLongitude: (double) longitude withLatitude: (double) latitude withCompletion: (PFBooleanResultBlock  _Nullable)completion;

+ (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image;

@end
