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
        self.backgroundColor = [UIColor colorWithRed:0.23 green:0.22 blue:0.22 alpha:1];
        
        
#warning YELLOW CONNECT BUTTON
        self.connectButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.connectButton setTitle:@"Connect to devices" forState:UIControlStateNormal];
        self.connectButton.frame = CGRectMake(80.0, self.frame.size.height / 2, 160.0, 40.0);
        [self addSubview:self.connectButton];
        
#warning YELLOW "IK BEN CAMERAMAN" BUTTON
        self.cameraButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.cameraButton setTitle:@"Ik ben Cameraman" forState:UIControlStateNormal];
        self.cameraButton.frame = CGRectMake(80.0, self.frame.size.height / 2 + 50, 160.0, 40.0);
        self.cameraButton.hidden = YES;
        [self addSubview:self.cameraButton];
    }
    return self;
}


@end
