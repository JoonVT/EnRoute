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
        
        self.videoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.videoButton.frame = CGRectMake(0, self.frame.size.height - 189, self.frame.size.width / 2, 189);
        [self.videoButton setImage:[UIImage imageNamed:@"button_movie"] forState:UIControlStateNormal];
        [self.videoButton setImage:[UIImage imageNamed:@"button_movie_pressed"] forState:UIControlStateHighlighted];
        [self addSubview:self.videoButton];
        
        self.pictureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.pictureButton.frame = CGRectMake(self.frame.size.width / 2, self.frame.size.height - 189, self.frame.size.width / 2, 189);
        [self.pictureButton setImage:[UIImage imageNamed:@"button_photo"] forState:UIControlStateNormal];
        [self.pictureButton setImage:[UIImage imageNamed:@"button_photo_pressed"] forState:UIControlStateHighlighted];
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
