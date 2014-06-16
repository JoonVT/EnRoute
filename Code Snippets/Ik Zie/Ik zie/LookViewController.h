//
//  LookViewController.h
//  Ik zie, Ik zie
//
//  Created by Niels Boey on 12/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
#import "LookView.h"
#import "RecordViewController.h"

@interface LookViewController : UIViewController <MCSessionDelegate, MCBrowserViewControllerDelegate, AVAudioPlayerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic,strong) LookView *view;

@property (nonatomic,strong) MCBrowserViewController *browserVC;
@property (nonatomic,strong) MCPeerID *advertiserID;
@property (nonatomic,strong) MCSession *session;
@property (nonatomic,strong) MCAdvertiserAssistant *assistant;

@property (nonatomic,strong) NSURL *mediaURL;

@property (nonatomic,strong) RecordViewController *recordVC;

@property (nonatomic,strong) AVAudioSession *audioSession;
@property (nonatomic,strong) AVAudioPlayer *player;

@property (nonatomic) BOOL playingaudio;

@property (nonatomic,strong) CLLocationManager *locationManager;;

@end
