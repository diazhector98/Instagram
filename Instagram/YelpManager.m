//
//  YelpManager.m
//  TestYelpAPI
//
//  Created by Hannah Hsu & Hector Diaz on 7/12/18.
//  Copyright © 2018 Hannah Hsu. All rights reserved.
//

#import "YelpManager.h"

/*
 Client ID
 My-u0b-xeFD3zRNnFgrTSA
 
 API Key
 twGNW7wA2e3-suEKeND9MKXRf_kyK0t7xJ5P-9vpNuUizaTTG6KN1WOUIYWeYw0EGDDCpHt4AqI862iz3noXhwC7SJYKyuivB4wAp_zKb_4Od7o2xColAUjYiLVGW3Yx
 
 */

@implementation YelpManager


- (void)getEventCategories:(void(^)(NSDictionary *categories, NSError *error))completion {
    
    NSURL *url = [NSURL URLWithString:@"https://api.yelp.com/v3/events?categories=music&limit=10"];
    
    //NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSString *headerValue=@"Bearer twGNW7wA2e3-suEKeND9MKXRf_kyK0t7xJ5P-9vpNuUizaTTG6KN1WOUIYWeYw0EGDDCpHt4AqI862iz3noXhwC7SJYKyuivB4wAp_zKb_4Od7o2xColAUjYiLVGW3Yx";
    
    [request setValue:headerValue forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error != nil) {
            
            completion(nil, error);
            
        }
        else {
            
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            completion(dataDictionary, nil);
            
        }
        
    }];
    [task resume];
    
}

- (void)getEventsWithLatitude: (NSString *) latitude withLongitude:(NSString *) longitude withCompletion:(void(^)(NSDictionary *categories, NSError *error))completion {
    
    NSString *baseUrlString = @"https://api.yelp.com/v3/events?limit=";
    
    NSString *urlString = [NSString stringWithFormat:@"%@&latitude=%@&longitude=%@", baseUrlString, latitude, longitude];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSString *headerValue=@"Bearer twGNW7wA2e3-suEKeND9MKXRf_kyK0t7xJ5P-9vpNuUizaTTG6KN1WOUIYWeYw0EGDDCpHt4AqI862iz3noXhwC7SJYKyuivB4wAp_zKb_4Od7o2xColAUjYiLVGW3Yx";
    
    [request setValue:headerValue forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error != nil) {
            
            completion(nil, error);
            
        }
        else {
            
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            completion(dataDictionary, nil);
            
        }
        
    }];
    [task resume];
    
    
    
}

@end
