//
//  BokehView.h
//  En Route
//
//  Created by Joon Van Thuyne on 16/06/14.
//  Copyright (c) 2014 JoonVT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BokehView : UIView

@property (nonatomic,strong) UIButton *cameraButton;
@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) UIView *topView;

@property (nonatomic,strong) UIView *circleView;
@property (nonatomic,strong) UIButton *uploadButton;
@property (nonatomic,strong) UIImageView *bottomView;

-(void)drawCircle:(CGRect)frame andColor:(UIColor *)color;
-(void)addInterface;

@end
