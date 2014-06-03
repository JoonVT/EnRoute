//
//  LoginView.m
//  En Route
//
//  Created by Joon Van Thuyne on 03/06/14.
//  Copyright (c) 2014 JoonVT. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor grayColor];
        
        self.txtUsername = [[UITextField alloc] init];
        self.txtUsername.placeholder = @"username";
        self.txtUsername.frame = CGRectMake(20, 115, frame.size.width - 40, 40);
        self.txtUsername.backgroundColor = [UIColor whiteColor];
        self.txtUsername.textColor = [UIColor colorWithRed:0.33 green:0.67 blue:0.93 alpha:1];
        self.txtUsername.textAlignment = NSTextAlignmentCenter;
        
        self.txtPassword = [[UITextField alloc] init];
        self.txtPassword.placeholder = @"password";
        self.txtPassword.frame = CGRectMake(20, self.txtUsername.frame.origin.y + self.txtUsername.frame.size.height + 5, frame.size.width - 40, 40);
        self.txtPassword.secureTextEntry = YES;
        self.txtPassword.backgroundColor = [UIColor whiteColor];
        self.txtPassword.textColor = [UIColor colorWithRed:0.33 green:0.67 blue:0.93 alpha:1];
        self.txtPassword.textAlignment = NSTextAlignmentCenter;
        
        self.btnLogin = [UIButton buttonWithType:UIButtonTypeSystem];
        self.btnLogin.frame = CGRectMake(20, self.txtPassword.frame.origin.y + self.txtPassword.frame.size.height + 5, frame.size.width - 40, 40);
        self.btnLogin.tintColor = [UIColor whiteColor];
        [self.btnLogin setTitle:@"Login" forState:UIControlStateNormal];
        
        [self addSubview:self.txtUsername];
        [self addSubview:self.txtPassword];
        [self addSubview:self.btnLogin];
    }
    return self;
}

- (void)showErrorMessage {
    [UIView animateWithDuration:.2 animations:^{
        self.txtUsername.backgroundColor = [UIColor colorWithRed:1 green:0.47 blue:0.44 alpha:1];
        self.txtPassword.backgroundColor = [UIColor colorWithRed:1 green:0.47 blue:0.44 alpha:1];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.2 delay:.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.txtUsername.backgroundColor = [UIColor whiteColor];
            self.txtPassword.backgroundColor = [UIColor whiteColor];
        } completion:^(BOOL finished) {}];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
