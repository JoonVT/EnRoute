//
//  AppDelegate.h
//  MultiConnection
//
//  Created by Niels Boey on 03/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) ConnectionViewController *connectionVC;

@end
