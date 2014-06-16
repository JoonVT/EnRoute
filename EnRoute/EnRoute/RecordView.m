//
//  RecorderView.m
//  Ik zie, Ik zie
//
//  Created by Niels Boey on 12/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import "RecordView.h"

@implementation RecordView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
        
        UIImage *recButton = [UIImage imageNamed:@"recordbutton"];
        self.record = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.record setImage:recButton forState:UIControlStateNormal];
        self.record.frame = CGRectMake((self.frame.size.width - recButton.size.width) / 2, 417, recButton.size.width, recButton.size.height);
        [self addSubview:self.record];
    
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, self.frame.size.width, 30)];
        self.title.text = @"Ik zie, ik zie ...";
        self.title.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.font = [UIFont fontWithName:@"Hallosans-Black" size:18];
        [self addSubview:self.title];

        NSAttributedString *txtSend = [[NSAttributedString alloc] initWithString:@"VERSTUUR" attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Hallosans-Black" size:22], NSForegroundColorAttributeName : [UIColor colorWithRed:0.76 green:0.62 blue:0.18 alpha:1], NSKernAttributeName : @(1.0f)}];
        
        self.send = [UIButton buttonWithType:UIButtonTypeCustom];
        self.send.frame = CGRectMake(50, self.frame.size.height-65, self.frame.size.width - 100, 45);
        [self.send setAttributedTitle:txtSend forState:UIControlStateNormal];
        [self.send setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        [self.send setBackgroundImage:[UIImage imageNamed:@"button_pressed"] forState:UIControlStateHighlighted];
        self.send.hidden = YES;
        [self addSubview:self.send];
        
        
        self.timer = [[UILabel alloc] initWithFrame:CGRectMake(0, 370, self.frame.size.width, 50)];
        self.timer.text = @"00:00";
        self.timer.font = [UIFont fontWithName:@"Hallosans-Black" size:18];
        self.timer.textAlignment = NSTextAlignmentCenter;
        self.timer.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
        [self addSubview:self.timer];
        
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 450, self.frame.size.width, 50)];
        self.label.text = @"OPNEMEN";
        self.label.font = [UIFont fontWithName:@"Hallosans-Black" size:20];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
        [self addSubview:self.label];
        
        
        UIImage *mic = [UIImage imageNamed:@"mic"];
        self.microphone = [[UIImageView alloc] initWithImage:mic];
        self.microphone.frame = CGRectMake((self.frame.size.width - mic.size.width) / 2, 130, mic.size.width, mic.size.height);
        [self addSubview:self.microphone];
    }
    return self;
}

@end
