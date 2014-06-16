//
//  BokehView.m
//  En Route
//
//  Created by Joon Van Thuyne on 16/06/14.
//  Copyright (c) 2014 JoonVT. All rights reserved.
//

#import "BokehView.h"

@implementation BokehView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        NSAttributedString *txtCamera = [[NSAttributedString alloc] initWithString:@"NEEM EEN FOTO" attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Hallosans-Black" size:22], NSForegroundColorAttributeName : [UIColor colorWithRed:0.76 green:0.62 blue:0.18 alpha:1], NSKernAttributeName : @(1.0f)}];
       
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.backgroundColor = [UIColor blackColor];
        
        self.cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cameraButton.frame = CGRectMake(50, (self.frame.size.height-45)/2, self.frame.size.width - 100, 45);
        [self.cameraButton setAttributedTitle:txtCamera forState:UIControlStateNormal];
        [self.cameraButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        [self.cameraButton setBackgroundImage:[UIImage imageNamed:@"button_pressed"] forState:UIControlStateHighlighted];
        [self addSubview:self.cameraButton];
    }
    return self;
}

-(void)drawCircle:(CGRect)frame andColor:(UIColor *)color {
    
    self.circleView = [[UIView alloc] initWithFrame:frame];
    self.circleView.alpha = 0.5;
    self.circleView.layer.cornerRadius = 20;
    self.circleView.backgroundColor = color;
    [self.topView addSubview:self.circleView];
    
}

-(void)addInterface {
    self.topView = [[UIView alloc] initWithFrame:self.imageView.frame];
    self.topView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7];
    [self addSubview:self.topView];
    
    self.bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.imageView.frame.size.height + self.imageView.frame.origin.y, self.frame.size.width, self.frame.size.width)];
    self.bottomView.backgroundColor = [UIColor blackColor];
    [self addSubview:self.bottomView];
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
