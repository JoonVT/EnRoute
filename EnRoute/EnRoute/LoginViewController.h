//
//  LoginViewController.h
//  En Route
//
//  Created by Joon Van Thuyne on 03/06/14.
//  Copyright (c) 2014 JoonVT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import "LoginView.h"

@interface LoginViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, retain)  NSMutableArray *classData;

@property (strong, nonatomic) LoginView *view;

@end
