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
#import "AudioController.h"

@interface MainViewController : UIViewController

@property (strong, nonatomic) LoginViewController *loginVC;
@property (strong, nonatomic) MainView *view;

@end
