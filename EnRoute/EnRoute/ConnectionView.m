//
//  ConnectionView.m
//  MultiConnection
//
//  Created by Niels Boey on 03/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import "ConnectionView.h"

@implementation ConnectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
        
        NSAttributedString *txtConnect = [[NSAttributedString alloc] initWithString:@"ZOEK ANDEREN" attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Hallosans-Black" size:22], NSForegroundColorAttributeName : [UIColor colorWithRed:0.76 green:0.62 blue:0.18 alpha:1], NSKernAttributeName : @(1.0f)}];
        
        self.connectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.connectButton.frame = CGRectMake(50, (self.frame.size.height-45)/2, self.frame.size.width - 100, 45);
        [self.connectButton setAttributedTitle:txtConnect forState:UIControlStateNormal];
        [self.connectButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        [self.connectButton setBackgroundImage:[UIImage imageNamed:@"button_pressed"] forState:UIControlStateHighlighted];
        
        [self addSubview:self.connectButton];
        
        NSAttributedString *txtCamera = [[NSAttributedString alloc] initWithString:@"IK BEN CAMERAMAN" attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Hallosans-Black" size:22], NSForegroundColorAttributeName : [UIColor colorWithRed:0.76 green:0.62 blue:0.18 alpha:1], NSKernAttributeName : @(1.0f)}];
        
        self.cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cameraButton.frame = CGRectMake(50, (self.frame.size.height-45)/2, self.frame.size.width - 100, 45);
        [self.cameraButton setAttributedTitle:txtCamera forState:UIControlStateNormal];
        [self.cameraButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        [self.cameraButton setBackgroundImage:[UIImage imageNamed:@"button_pressed"] forState:UIControlStateHighlighted];
        self.cameraButton.hidden = YES;
        [self addSubview:self.cameraButton];
        
        NSAttributedString *txtFlash = [[NSAttributedString alloc] initWithString:@"FLITS AAN/UIT" attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Hallosans-Black" size:22], NSForegroundColorAttributeName : [UIColor colorWithRed:0.76 green:0.62 blue:0.18 alpha:1], NSKernAttributeName : @(1.0f)}];
        
        self.flashButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.flashButton.frame = CGRectMake(50, (self.frame.size.height-45)/2, self.frame.size.width - 100, 45);
        [self.flashButton setAttributedTitle:txtFlash forState:UIControlStateNormal];
        [self.flashButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        [self.flashButton setBackgroundImage:[UIImage imageNamed:@"button_pressed"] forState:UIControlStateHighlighted];
        self.flashButton.hidden = YES;
        [self addSubview:self.flashButton];
    }
    return self;
}


@end
