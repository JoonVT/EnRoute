//
//  AssignmentView.m
//  En Route
//
//  Created by Joon Van Thuyne on 05/06/14.
//  Copyright (c) 2014 JoonVT. All rights reserved.
//

#import "AssignmentView.h"

@implementation AssignmentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.btnTest1 = [UIButton buttonWithType:UIButtonTypeSystem];
        self.btnTest1.frame = CGRectMake(20, 100, frame.size.width - 40, 40);
        self.btnTest1.tintColor = [UIColor whiteColor];
        self.btnTest1.backgroundColor = [UIColor blackColor];
        [self.btnTest1 setTitle:@"Test Button" forState:UIControlStateNormal];
        
        [self addSubview:self.btnTest1];
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
