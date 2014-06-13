//
//  AppDelegate.h
//  Recorder
//
//  Created by Niels Boey on 12/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecorderViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) RecorderViewController *recordVC;

@end
