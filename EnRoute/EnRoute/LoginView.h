//
//  LoginView.h
//  En Route
//
//  Created by Joon Van Thuyne on 03/06/14.
//  Copyright (c) 2014 JoonVT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView

@property (strong, nonatomic) UIImageView *backImage;
@property (strong, nonatomic) UIImageView *welcome;
@property (strong, nonatomic) UILabel *lblTitle;
@property (strong, nonatomic) UILabel *lblSubTitle;
@property (strong, nonatomic) UIActivityIndicatorView *loading;
@property (strong, nonatomic) UIPickerView *classSelect;
@property (strong, nonatomic) UIButton *btnStart;

@end
