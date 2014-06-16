//
//  RecorderView.h
//  Ik zie, Ik zie
//
//  Created by Niels Boey on 12/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordView : UIView

@property (nonatomic,strong) UIButton *send;
@property (nonatomic,strong) UIButton *record;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UILabel *timer;

@property (nonatomic,strong) UILabel *title;

@property (nonatomic,strong) UIImageView *microphone;

@end
