//
//  YelpManager.h
//  Instagram
//
//  Created by Hector Diaz on 7/12/18.
//  Copyright © 2018 Hector Diaz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YelpManager : NSObject

- (void)getEventsWithLatitude: (NSString *) latitude withLongitude:(NSString *) longitude withCompletion:(void(^)(NSDictionary *categories, NSError *error))completion;

- (void)getEventCategories:(void(^)(NSDictionary *categories, NSError *error))completion;

@end
