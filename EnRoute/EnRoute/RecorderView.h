//
//  RecorderView.h
//  Recorder
//
//  Created by Niels Boey on 12/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecorderView : UIView


@property (nonatomic,strong) UIButton *upload;


@property (nonatomic,strong) UIButton *send;
@property (nonatomic,strong) UIButton *record;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UILabel *timer;

@property (nonatomic,strong) UIImageView *microphone;

@property (nonatomic,strong) UIButton *play;
@property (nonatomic,strong) UILabel *playlabel;

@property (nonatomic,strong) UIImage *recButton;
@property (nonatomic,strong) UIImage *playicon;

@end
