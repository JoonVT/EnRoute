//
//  MainViewController.h
//  GyroTest
//
//  Created by Joon Van Thuyne on 04/06/14.
//  Copyright (c) 2014 JoonVT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import "MainView.h"

@interface MainViewController : UIViewController

@property (strong, nonatomic) MainView *view;

@property (strong, nonatomic) CMMotionManager *motionManager;

@property (nonatomic) CGRect bounds;
@property (strong, nonatomic) UIView *rect;

@end
