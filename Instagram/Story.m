//
//  Story.m
//  Instagram
//
//  Created by Hector Diaz on 7/13/18.
//  Copyright © 2018 Hector Diaz. All rights reserved.
//

#import "Story.h"

@implementation Story

@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic image;
@dynamic date;


+ (nonnull NSString *)parseClassName {
    return @"Story";
}

+ (void) postStory: ( UIImage * _Nullable )image withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Story *story = [Story new];
    
    story.image = [self getPFFileFromImage:image];
    
    story.author = [PFUser currentUser];
    
    story.date = [NSDate date];
    
    [story saveInBackgroundWithBlock: completion];
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
