//
//  RecorderView.m
//  Recorder
//
//  Created by Niels Boey on 12/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import "RecorderView.h"

@implementation RecorderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
        
        self.recButton = [UIImage imageNamed:@"recordbutton"];
        self.record = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.record setImage:self.recButton forState:UIControlStateNormal];
        self.record.frame = CGRectMake((self.frame.size.width - self.recButton.size.width) / 2, 416, self.recButton.size.width, self.recButton.size.height);
        [self addSubview:self.record];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - (self.frame.size.width / 2)) / 2, self.record.frame.size.height + self.record.frame.origin.y - 5, self.frame.size.width / 2, 50)];
        self.label.text = @"OPNEMEN";
        self.label.font = [UIFont fontWithName:@"Hallosans-Black" size:20];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
        [self addSubview:self.label];
        
         
        
        self.playicon = [UIImage imageNamed:@"playbutton"];
        self.play = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.play setImage:self.playicon forState:UIControlStateNormal];
        self.play.frame = CGRectMake((((self.frame.size.width - self.playicon.size.width )/ 4)*3)*2 + 10 , 416, self.playicon.size.width, self.playicon.size.height);
        self.play.hidden = YES;
       [self addSubview:self.play];
        
        self.playlabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width, self.play.frame.size.height + self.play.frame.origin.y - 5, self.frame.size.width / 2, 50)];
        self.playlabel.font = [UIFont fontWithName:@"Hallosans-Black" size:18];
        self.playlabel.textAlignment = NSTextAlignmentCenter;
        self.playlabel.text = @"AFSPELEN";
        self.playlabel.hidden = YES;
        self.playlabel.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
       [self addSubview:self.playlabel];

        
        self.timer = [[UILabel alloc] initWithFrame:CGRectMake(0, 370, self.frame.size.width, 50)];
        self.timer.text = @"00:00";
        self.timer.font = [UIFont fontWithName:@"Hallosans-Black" size:18];
        self.timer.textAlignment = NSTextAlignmentCenter;
        self.timer.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
        [self addSubview:self.timer];
    
        
        UIImage *mic = [UIImage imageNamed:@"mic"];
        self.microphone = [[UIImageView alloc] initWithImage:mic];
        self.microphone.frame = CGRectMake((self.frame.size.width - mic.size.width) / 2, 130, mic.size.width, mic.size.height);
        [self addSubview:self.microphone];        
        
    }
    return self;
}

@end
