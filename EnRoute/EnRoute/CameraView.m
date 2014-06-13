//
//  UploadView.m
//  API-test
//
//  Created by Niels Boey on 02/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import "CameraView.h"

@implementation CameraView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor whiteColor];

        
   /*     self.field = [[UITextField alloc] initWithFrame:CGRectMake(25, 100, self.frame.size.width - 50, 30)];
        self.field.backgroundColor = [UIColor blackColor];
        self.field.tintColor = [UIColor whiteColor];
        self.field.textColor = [UIColor whiteColor];
        [self addSubview:self.field];*/
        
       /* self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, self.frame.size.width, self.frame.size.height - 200)];
        [self addSubview:self.picker];*/
        
        
        self.videoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.videoButton setTitle:@"Film" forState:UIControlStateNormal];
        self.videoButton.frame = CGRectMake(0, self.frame.size.height - 189, self.frame.size.width / 2, 189);
        self.videoButton.backgroundColor = [UIColor colorWithRed:0.27 green:0.27 blue:0.27 alpha:1];
        self.videoButton.tintColor = [UIColor whiteColor];
        [self addSubview:self.videoButton];
        
        
        self.pictureButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.pictureButton setTitle:@"Foto" forState:UIControlStateNormal];
        self.pictureButton.frame = CGRectMake(self.frame.size.width / 2, self.frame.size.height - 189, self.frame.size.width / 2, 189);
        self.pictureButton.backgroundColor = [UIColor colorWithRed:0.29 green:0.29 blue:0.29 alpha:1];
        self.pictureButton.tintColor = [UIColor whiteColor];
        [self addSubview:self.pictureButton];

        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - self.frame.size.width - 189,self.frame.size.width,self.frame.size.width)];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.backgroundColor = [UIColor blackColor];
        
        
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
