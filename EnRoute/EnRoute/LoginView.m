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
        
        self.backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login"]];
        
        NSAttributedString *txtTitle = [[NSAttributedString alloc] initWithString:@"GENT VERLICHT" attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Hallosans-Black" size:30], NSForegroundColorAttributeName : [UIColor colorWithRed:0.58 green:0.86 blue:0.8 alpha:1], NSKernAttributeName : @(1.0f)}];
        
        NSAttributedString *txtSubTitle = [[NSAttributedString alloc] initWithString:@"Kies je groep" attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Hallosans" size:20], NSForegroundColorAttributeName : [UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1], NSKernAttributeName : @(1.0f)}];
        
        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 300, self.frame.size.width - 30, 25)];
        self.lblTitle.attributedText = txtTitle;
        self.lblTitle.textAlignment = NSTextAlignmentCenter;
        self.lblTitle.alpha = 0;
        
        self.lblSubTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, self.lblTitle.frame.origin.y + self.lblTitle.frame.size.height + 5, self.frame.size.width - 30, 25)];
        self.lblSubTitle.attributedText = txtSubTitle;
        self.lblSubTitle.textAlignment = NSTextAlignmentCenter;
        self.lblSubTitle.alpha = 0;
        
        self.loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.loading.center = CGPointMake(frame.size.width/2, frame.size.height-140);
        self.loading.alpha = 0;
        
        self.classSelect = [[UIPickerView alloc] init];
        self.classSelect.frame = CGRectMake(50, self.lblSubTitle.frame.origin.y + self.lblSubTitle.frame.size.height, frame.size.width - 100, 162);
        self.classSelect.showsSelectionIndicator = YES;
        self.classSelect.alpha = 0;
        
        CGAffineTransform t0 = CGAffineTransformMakeTranslation (0, self.classSelect.bounds.size.height/2);
        CGAffineTransform s0 = CGAffineTransformMakeScale       (0.85, 0.85);
        CGAffineTransform t1 = CGAffineTransformMakeTranslation (0, -self.classSelect.bounds.size.height/2);
        self.classSelect.transform = CGAffineTransformConcat    (t0, CGAffineTransformConcat(s0, t1));
        
        self.btnStart = [UIButton buttonWithType:UIButtonTypeSystem];
        self.btnStart.frame = CGRectMake(100, self.classSelect.frame.origin.y + self.classSelect.frame.size.height + 5, frame.size.width - 200, 45);
        [self.btnStart setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        [self.btnStart setBackgroundImage:[UIImage imageNamed:@"button_pressed"] forState:UIControlStateHighlighted];
        self.btnStart.alpha = 0;
        
        self.welcome = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"welcome"]];
        self.welcome.center = CGPointMake(frame.size.width/2, frame.origin.y-90);
        
        [self addSubview:self.backImage];
        [self addSubview:self.lblTitle];
        [self addSubview:self.lblSubTitle];
        [self addSubview:self.loading];
        [self addSubview:self.btnStart];
        [self addSubview:self.welcome];
    }
    return self;
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
