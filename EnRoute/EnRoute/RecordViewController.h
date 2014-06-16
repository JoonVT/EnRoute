//
//  RecorderViewController.h
//  Ik zie, Ik zie
//
//  Created by Niels Boey on 12/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "RecordView.h"

@interface RecordViewController : UIViewController <AVAudioPlayerDelegate, AVAudioRecorderDelegate>

@property (nonatomic,strong) RecordView *view;

@property (nonatomic,strong) AVAudioSession *audioSession;
@property (nonatomic,strong) AVAudioRecorder *recorder;
@property (nonatomic,strong) AVAudioPlayer *player;
@property (nonatomic,strong) NSURL *recordedAudioURL;
@property (nonatomic) BOOL isRecording;

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) NSString *time;
@property (nonatomic) int seconds;

@end
