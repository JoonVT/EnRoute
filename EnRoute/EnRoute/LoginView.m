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
        
        self.classSelect = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 100, 0, 0)];
        self.classSelect.showsSelectionIndicator = YES;
        
        self.btnLogin = [UIButton buttonWithType:UIButtonTypeSystem];
        self.btnLogin.frame = CGRectMake(20, self.classSelect.frame.origin.y + self.classSelect.frame.size.height + 5, frame.size.width - 40, 40);
        self.btnLogin.tintColor = [UIColor whiteColor];
        [self.btnLogin setTitle:@"Login" forState:UIControlStateNormal];
        
        [self addSubview:self.classSelect];
        [self addSubview:self.btnLogin];
    }
    return self;
}

- (void)showErrorMessage {
    [UIView animateWithDuration:.2 animations:^{
        //self.txtUsername.backgroundColor = [UIColor colorWithRed:1 green:0.47 blue:0.44 alpha:1];
        //self.txtPassword.backgroundColor = [UIColor colorWithRed:1 green:0.47 blue:0.44 alpha:1];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.2 delay:.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
            //self.txtUsername.backgroundColor = [UIColor whiteColor];
            //self.txtPassword.backgroundColor = [UIColor whiteColor];
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
