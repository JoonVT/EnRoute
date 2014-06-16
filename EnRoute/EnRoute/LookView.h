//
//  LookView.h
//  Ik zie, Ik zie
//
//  Created by Niels Boey on 12/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LookView : UIView

@property (nonatomic,strong) UILabel *connected;

@property (nonatomic,strong) UIButton *connectButton;
@property (nonatomic,strong) UIButton *cameraButton;

@property (nonatomic,strong) UIButton *sendPhotoButton;

@property (nonatomic,strong) UIButton *play;
@property (nonatomic,strong) UILabel *playlabel;
@property (nonatomic,strong) UIButton *speakerButton;

@property (nonatomic,strong) UIImageView *photoview;
@property (nonatomic,strong) UIButton *uploadButton;

@property (nonatomic,strong) UIButton *rightButton;
@property (nonatomic,strong) UIButton *wrongButton;

@property (nonatomic,strong) UIImageView *animationImageView;

@end
