//
//  BokehViewController.h
//  En Route
//
//  Created by Joon Van Thuyne on 16/06/14.
//  Copyright (c) 2014 JoonVT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
#import "BokehView.h"
#import "Assignment.h"

@interface BokehViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate>

@property (nonatomic,strong) BokehView *view;

@property (nonatomic,strong) CLLocationManager *locationManager;

@property (nonatomic) float center;
@property (nonatomic) float centerY;

@property (nonatomic) float prepoint;

@property (nonatomic,strong) NSURL *mediaURL;

@property (strong, nonatomic) Assignment *assignment;

- (id)initWithAssignment:(Assignment *)assignment;

@end
