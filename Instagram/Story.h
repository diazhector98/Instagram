//
//  Story.h
//  Instagram
//
//  Created by Hector Diaz on 7/13/18.
//  Copyright © 2018 Hector Diaz. All rights reserved.
//

#import "PFObject.h"
#import "Parse.h"

@interface Story : PFObject <PFSubclassing>

@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFUser *author;

@property (nonatomic, strong) PFFile *image;
@property (nonatomic, strong) NSDate *date;

+ (void) postStory: ( UIImage * _Nullable )image withCompletion: (PFBooleanResultBlock  _Nullable)completion;

+ (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image;

@end
