//
//  MainViewController.h
//  EnRoute
//
//  Created by Joon Van Thuyne on 28/05/14.
//  Copyright (c) 2014 JoonVT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioUnit/AudioUnit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "LoginViewController.h"
#import "MainView.h"
#import "Assignment.h"
#import "AssignmentFactory.h"
#import "AssignmentToolsViewController.h"

@interface MainViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) LoginViewController *loginVC;
@property (strong, nonatomic) MainView *view;

@property (nonatomic,strong) NSMutableArray *assignments;

@property (nonatomic) int darkPercentage;

@end
