//
//  LoginView.m
//  ViewMoved
//
//  Created by Niels Boey on 05/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1];
        [self createAnimation];
        
    }
    return self;
}

-(void)createAnimation {
    
     NSArray *imageNames = @[@"loadscreen_00", @"loadscreen_01", @"loadscreen_02", @"loadscreen_01"];
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 0; i < imageNames.count; i++) {
        [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
    }
    
    self.animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.animationImageView.animationImages = images;
    self.animationImageView.animationDuration = 1.1;
    
    [self addSubview:self.animationImageView];
}

@end
