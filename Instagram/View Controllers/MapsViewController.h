//
//  MapsViewController.h
//  Instagram
//
//  Created by Hector Diaz on 7/12/18.
//  Copyright © 2018 Hector Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"
#import <CoreLocation/CoreLocation.h>


@interface MapsViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) NSArray *posts;


@end
