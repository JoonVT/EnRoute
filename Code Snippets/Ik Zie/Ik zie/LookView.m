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

-(void)createStartUI {
    self.connected = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, self.frame.size.width, 30)];
    self.connected.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
    self.connected.textAlignment = NSTextAlignmentCenter;
    self.connected.font = [UIFont fontWithName:@"Hallosans-Black" size:18];
    self.connected.text = @"Verbind met een ander toestel";
    [self addSubview:self.connected];
    
#warning ADD YELLOW START BUTTON
    self.connectButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.connectButton.frame = CGRectMake((self.frame.size.width - (self.frame.size.width / 2)) / 2, (self.frame.size.height - 50)/2, self.frame.size.width / 2, 50);
    self.connectButton.titleLabel.text = @"VERBIND";
    [self.connectButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [self.connectButton setBackgroundImage:[UIImage imageNamed:@"button_pressed"] forState:UIControlStateHighlighted];

    [self addSubview:self.connectButton];
}

-(void)createConnectedUI {
    self.manageButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.manageButton setTitle:@"Bekijk verbindingen" forState:UIControlStateNormal];
    self.manageButton.frame = CGRectMake(0,  self.frame.size.height - 40, self.frame.size.width, 40);
    self.manageButton.tintColor = [UIColor whiteColor];
    self.connected.font = [UIFont fontWithName:@"Hallosans-Black" size:18];
    self.manageButton.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
    self.manageButton.hidden = YES;
    [self addSubview:self.manageButton];

#warning ADD YELLOW START BUTTON
    self.speakerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.speakerButton setTitle:@"Ik ga spreken" forState:UIControlStateNormal];
    self.speakerButton.frame = CGRectMake(0,  (self.frame.size.height - 50)/2, self.frame.size.width, 50);
    self.speakerButton.tintColor = [UIColor blackColor];
    self.speakerButton.backgroundColor = [UIColor yellowColor];
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
    
#warning ADD YELLOW START BUTTON
    self.cameraButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.cameraButton setTitle:@"Neem een foto" forState:UIControlStateNormal];
    self.cameraButton.frame = CGRectMake(0,  (self.frame.size.height - 50)/2, self.frame.size.width, 50);
    self.cameraButton.tintColor = [UIColor blackColor];
    self.cameraButton.backgroundColor = [UIColor yellowColor];
    self.cameraButton.hidden = YES;
    [self addSubview:self.cameraButton];
}

-(void)createPhotoUI {
    self.photoview = [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.frame.size.height-self.frame.size.width)/2, self.frame.size.width, self.frame.size.width)];
    self.photoview.contentMode = UIViewContentModeScaleToFill;
    self.photoview.backgroundColor = [UIColor blackColor];

#warning ADD YELLOW START BUTTON
    self.sendPhotoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.sendPhotoButton  setTitle:@"Stuur deze foto" forState:UIControlStateNormal];
    self.sendPhotoButton.frame = CGRectMake(0, self.photoview.frame.size.height + self.photoview.frame.origin.y, self.frame.size.width, 50);
    self.sendPhotoButton.backgroundColor = [UIColor yellowColor];
    self.wrongButton.titleLabel.font = [UIFont fontWithName:@"Hallosans-Black" size:24];
    self.sendPhotoButton.tintColor = [UIColor blackColor];
    self.sendPhotoButton.hidden = YES;
    [self addSubview:self.sendPhotoButton];
}

-(void)createEndUI {
    UIImage *righticon = [UIImage imageNamed:@"rightbutton"];
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightButton setImage:righticon forState:UIControlStateNormal];
    self.rightButton.frame = CGRectMake(51, self.photoview.frame.size.height + self.photoview.frame.origin.y + 10, righticon.size.width, righticon.size.height);
    self.rightButton.hidden = YES;
    [self addSubview:self.rightButton];
    
    UIImage *wrongicon = [UIImage imageNamed:@"wrongbutton"];
    self.wrongButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.wrongButton setImage:wrongicon forState:UIControlStateNormal];
    self.wrongButton.frame = CGRectMake(162.5,  self.photoview.frame.size.height + self.photoview.frame.origin.y + 10, wrongicon.size.width, wrongicon.size.height);
    self.wrongButton.hidden = YES;
    [self addSubview:self.wrongButton];
    
#warning ADD YELLOW START BUTTON
    self.dismissButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.dismissButton setTitle:@"EINDIG DEZE OPDRACHT" forState:UIControlStateNormal];
    self.dismissButton.frame = CGRectMake(0,  (self.frame.size.height - 50)/2, self.frame.size.width, 50);
    self.dismissButton.tintColor = [UIColor blackColor];
    self.dismissButton.backgroundColor = [UIColor yellowColor];
    self.dismissButton.hidden = YES;
    [self addSubview:self.dismissButton];
    
#warning ADD YELLOW START BUTTON
    self.uploadButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.uploadButton setTitle:@"upload" forState:UIControlStateNormal];
    self.uploadButton.frame = CGRectMake(0, self.frame.size.height - 110, self.frame.size.width, 50);
    self.uploadButton.tintColor = [UIColor blackColor];
    self.uploadButton.backgroundColor = [UIColor yellowColor];
    self.uploadButton.hidden = YES;
    [self addSubview:self.uploadButton];

}

-(void)createAnimation {
    
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
