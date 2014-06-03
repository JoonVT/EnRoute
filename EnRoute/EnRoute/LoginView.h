//
//  LoginView.h
//  En Route
//
//  Created by Joon Van Thuyne on 03/06/14.
//  Copyright (c) 2014 JoonVT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView

@property (strong, nonatomic) UIPickerView *classSelect;
@property (strong, nonatomic) UIButton *btnLogin;

-(void)showErrorMessage;

@end
