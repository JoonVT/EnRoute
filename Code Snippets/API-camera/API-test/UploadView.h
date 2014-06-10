//
//  UploadView.h
//  API-test
//
//  Created by Niels Boey on 02/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadView : UIView <UIPickerViewDelegate>

@property (nonatomic,strong) UITextField *field;
@property (nonatomic,strong) UIPickerView *picker;

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) UIButton *pictureButton;
@property (nonatomic,strong) UIButton *videoButton;

@end
