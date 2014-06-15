//
//  LocationViewController.h
//  LocationMap
//
//  Created by Niels Boey on 13/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AFNetworking/AFNetworking.h>
#import "LocationView.h"
#import "Assignment.h"
#import "AssignmentsFactory.h"

@interface LocationViewController : UIViewController

@property (nonatomic,strong) LocationView *view;

@property (nonatomic,strong) NSDictionary *assignments;


@property (nonatomic,strong) NSMutableArray *locations;

@end
