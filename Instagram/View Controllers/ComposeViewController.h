//
//  ComposeViewController.h
//  Instagram
//
//  Created by Hector Diaz on 7/9/18.
//  Copyright © 2018 Hector Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"
#import <CoreLocation/CoreLocation.h>


@interface ComposeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UITextView *captionTextView;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (assign, nonatomic) double latitude;
@property (assign, nonatomic) double longitude;


@end
