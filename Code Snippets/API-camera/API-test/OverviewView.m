//
//  OverviewView.m
//  API-test
//
//  Created by Niels Boey on 10/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import "OverviewView.h"

@implementation OverviewView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.pictureButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.pictureButton setTitle:@"Start" forState:UIControlStateNormal];
        self.pictureButton.frame = CGRectMake((self.frame.size.width - 100) / 2, (self.frame.size.height - 100) / 2 , 100, 100);
        self.pictureButton.backgroundColor = [UIColor blackColor];
        self.pictureButton.tintColor = [UIColor whiteColor];
        [self addSubview:self.pictureButton];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, self.frame.size.width, 50)];
        self.label.text = @"maak een video/foto";
        self.label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.label];
        
        
        
    }
    return self;
}

-(void)uploadFile {
    
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
