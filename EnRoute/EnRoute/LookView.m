//
//  LookView.m
//  Ik zie, Ik zie
//
//  Created by Niels Boey on 12/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import "LookView.h"

@implementation LookView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
        
        [self createStartUI];
        [self createConnectedUI];
        [self createPlayUI];
        [self createPhotoUI];
        [self createEndUI];
        [self createAnimation];
    }
    return self;
}

-(void)createStartUI
{
    self.connected = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, self.frame.size.width, 30)];
    self.connected.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
    self.connected.textAlignment = NSTextAlignmentCenter;
    self.connected.font = [UIFont fontWithName:@"Hallosans-Black" size:18];
    self.connected.text = @"Verbind met een ander toestel";
    [self addSubview:self.connected];
    
    NSAttributedString *txtConnect = [[NSAttributedString alloc] initWithString:@"ZOEK ANDEREN" attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Hallosans-Black" size:22], NSForegroundColorAttributeName : [UIColor colorWithRed:0.76 green:0.62 blue:0.18 alpha:1], NSKernAttributeName : @(1.0f)}];
    
    self.connectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.connectButton.frame = CGRectMake(50, (self.frame.size.height-45)/2, self.frame.size.width - 100, 45);
    [self.connectButton setAttributedTitle:txtConnect forState:UIControlStateNormal];
    [self.connectButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [self.connectButton setBackgroundImage:[UIImage imageNamed:@"button_pressed"] forState:UIControlStateHighlighted];

    [self addSubview:self.connectButton];
}

-(void)createConnectedUI
{
    NSAttributedString *txtSpeaker = [[NSAttributedString alloc] initWithString:@"IK ZIE IETS" attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Hallosans-Black" size:22], NSForegroundColorAttributeName : [UIColor colorWithRed:0.76 green:0.62 blue:0.18 alpha:1], NSKernAttributeName : @(1.0f)}];
    
    self.speakerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.speakerButton.frame = CGRectMake(50, (self.frame.size.height-45)/2, self.frame.size.width - 100, 45);
    [self.speakerButton setAttributedTitle:txtSpeaker forState:UIControlStateNormal];
    [self.speakerButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [self.speakerButton setBackgroundImage:[UIImage imageNamed:@"button_pressed"] forState:UIControlStateHighlighted];
    self.speakerButton.hidden = YES;
    [self addSubview:self.speakerButton];
}

-(void)createPlayUI {
    UIImage *playicon = [UIImage imageNamed:@"playbutton"];
    self.play = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.play setImage:playicon forState:UIControlStateNormal];
    self.play.frame = CGRectMake((self.frame.size.width - playicon.size.width)/2, 150, playicon.size.width, playicon.size.height);
    self.play.hidden = YES;
    [self addSubview:self.play];
    
    self.playlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.play.frame.size.height + self.play.frame.origin.y+5, self.frame.size.width, 30)];
    self.playlabel.font = [UIFont fontWithName:@"Hallosans-Black" size:18];
    self.playlabel.textAlignment = NSTextAlignmentCenter;
    self.playlabel.text = @"AFSPELEN";
    self.playlabel.hidden = YES;
    self.playlabel.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
    [self addSubview:self.playlabel];
    
    NSAttributedString *txtCamera = [[NSAttributedString alloc] initWithString:@"IK ZIE HET!" attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Hallosans-Black" size:22], NSForegroundColorAttributeName : [UIColor colorWithRed:0.76 green:0.62 blue:0.18 alpha:1], NSKernAttributeName : @(1.0f)}];
    
    self.cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cameraButton.frame = CGRectMake(50, (self.frame.size.height-45)/2, self.frame.size.width - 100, 45);
    [self.cameraButton setAttributedTitle:txtCamera forState:UIControlStateNormal];
    [self.cameraButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [self.cameraButton setBackgroundImage:[UIImage imageNamed:@"button_pressed"] forState:UIControlStateHighlighted];
    self.cameraButton.hidden = YES;
    [self addSubview:self.cameraButton];
}

-(void)createPhotoUI
{
    self.photoview = [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.frame.size.height-self.frame.size.width)/2, self.frame.size.width, self.frame.size.width)];
    self.photoview.contentMode = UIViewContentModeScaleToFill;
    self.photoview.backgroundColor = [UIColor blackColor];
    
    NSAttributedString *txtSend = [[NSAttributedString alloc] initWithString:@"VERSTUUR" attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Hallosans-Black" size:22], NSForegroundColorAttributeName : [UIColor colorWithRed:0.76 green:0.62 blue:0.18 alpha:1], NSKernAttributeName : @(1.0f)}];
    
    self.sendPhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendPhotoButton.frame = CGRectMake(50, self.frame.size.height-65, self.frame.size.width - 100, 45);
    [self.sendPhotoButton setAttributedTitle:txtSend forState:UIControlStateNormal];
    [self.sendPhotoButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [self.sendPhotoButton setBackgroundImage:[UIImage imageNamed:@"button_pressed"] forState:UIControlStateHighlighted];
    self.sendPhotoButton.hidden = YES;
    [self addSubview:self.sendPhotoButton];
}

-(void)createEndUI
{
    UIImage *righticon = [UIImage imageNamed:@"rightbutton"];
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightButton setImage:righticon forState:UIControlStateNormal];
    self.rightButton.frame = CGRectMake(51, self.frame.size.height-65, righticon.size.width, righticon.size.height);
    self.rightButton.hidden = YES;
    [self addSubview:self.rightButton];
    
    UIImage *wrongicon = [UIImage imageNamed:@"wrongbutton"];
    self.wrongButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.wrongButton setImage:wrongicon forState:UIControlStateNormal];
    self.wrongButton.frame = CGRectMake(162.5,  self.frame.size.height-65, wrongicon.size.width, wrongicon.size.height);
    self.wrongButton.hidden = YES;
    [self addSubview:self.wrongButton];
    
    NSAttributedString *txtUpload = [[NSAttributedString alloc] initWithString:@"UPLOAD" attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Hallosans-Black" size:22], NSForegroundColorAttributeName : [UIColor colorWithRed:0.76 green:0.62 blue:0.18 alpha:1], NSKernAttributeName : @(1.0f)}];
    
    self.uploadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.uploadButton.frame = CGRectMake(50, self.frame.size.height-65, self.frame.size.width - 100, 45);
    [self.uploadButton setAttributedTitle:txtUpload forState:UIControlStateNormal];
    [self.uploadButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [self.uploadButton setBackgroundImage:[UIImage imageNamed:@"button_pressed"] forState:UIControlStateHighlighted];
    self.uploadButton.hidden = YES;
    [self addSubview:self.uploadButton];
}

-(void)createAnimation
{
    UIImage *image = [UIImage imageNamed:@"00"];

    NSArray *imageNames = @[@"00", @"01", @"02",@"03",@"02",@"01"];
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 0; i < imageNames.count; i++) {
        [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
    }
    
    self.animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - image.size.width) / 2, (self.frame.size.height - image.size.height)/2, image.size.width, image.size.height)];
    self.animationImageView.animationImages = images;
    self.animationImageView.animationDuration = 1.4;
    
    [self addSubview:self.animationImageView];
    [self.animationImageView startAnimating];
    self.animationImageView.hidden = YES;
}

@end
