//
//  RecorderViewController.m
//  Ik zie, Ik zie
//
//  Created by Niels Boey on 12/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import "RecorderViewController.h"

@interface RecorderViewController ()

@end

@implementation RecorderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)loadView {
    
    CGRect sizeofScreen = [[UIScreen mainScreen] bounds];
    self.view = [[RecorderView alloc] initWithFrame:sizeofScreen];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.audioSession = [AVAudioSession sharedInstance];

    [self.view.record addTarget:self action:@selector(record:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.send addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)send:(id)sender {
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:self.recordedAudioURL forKey:@"audiourl"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sendaudio" object:nil userInfo:userInfo];
    
}

-(void)timerUpdate {
    self.seconds++;
    
    if(self.seconds < 10){
         self.time = [NSString stringWithFormat:@"00:0%d",self.seconds];
    }else if(self.seconds > 9) {
        self.time = [NSString stringWithFormat:@"00:%d",self.seconds];
    }else if(self.seconds > 59) {
        self.time = [NSString stringWithFormat:@"01:0%d",self.seconds];
    }else if(self.seconds > 69) {
        self.time = [NSString stringWithFormat:@"01:%d",self.seconds];
    }
    
    self.view.timer.text = self.time;
}


-(void)record:(id)sender {

    if(self.isRecording == NO){
        self.view.label.text = @"STOP";
        
        self.view.timer.text = @"00:00";
        [self.view.record setImage:[UIImage imageNamed:@"stopbutton"] forState:UIControlStateNormal];
        
        [self.audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
        
        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *filePath = [[path objectAtIndex:0] stringByAppendingPathComponent:@"audio.m4a"];
        self.recordedAudioURL = [NSURL fileURLWithPath:filePath];
        
        NSData *audioData = [NSData dataWithContentsOfURL:self.recordedAudioURL];
        [audioData writeToFile:filePath atomically:YES];
        
        NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
        [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
        [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
        [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
        
        NSError *error;
        self.recorder = [[AVAudioRecorder alloc] initWithURL:[self recordedAudioURL] settings:recordSetting error:&error];
        [self.recorder prepareToRecord];
        
        [self.recorder recordForDuration:60];
        self.isRecording = YES;
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerUpdate) userInfo:nil repeats:YES];
    }else {
        [self.recorder stop];
        self.isRecording = NO;
        self.view.label.text = @"OPNEMEN";
        
        [self.view.record setImage:[UIImage imageNamed:@"recordbutton"] forState:UIControlStateNormal];
        
        self.view.send.hidden = NO;
        
        self.seconds = 0;
        
        [self.timer invalidate];
    }
}

@end
