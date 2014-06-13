//
//  RecorderViewController.m
//  Recorder
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
    [self.view.send addTarget:self action:@selector(upload:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.play addTarget:self action:@selector(playAudio:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)upload:(id)sender {
    [self uploadFile:self.recordedAudioURL];
}

-(void)uploadFile:(NSURL *)fileurl {
    NSString *onlineURL = @"http://student.howest.be/niels.boey/20132014/MAIV/ENROUTE/api/files";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
#warning update parameters met GroupID, ClassID en MediaID
    NSDictionary *parameters = @{@"groupid": @"1", @"classid": @"1", @"mediaid": @"1"};
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:onlineURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:fileurl name:@"file" error:nil];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error debugDescription]);
        NSLog(@"Error: %@", [error localizedDescription]);
    }];

}
    

-(void)playAudio:(id)sender {
    if(self.playingaudio == NO){
        [self.player play];
        self.view.playlabel.text = @"PAUZEREN";
        [self.view.play setImage:[UIImage imageNamed:@"pausebutton"] forState:UIControlStateNormal];
        self.playingaudio = YES;
    }else {
        [self.player pause];
        self.view.playlabel.text = @"AFSPELEN";
        [self.view.play setImage:[UIImage imageNamed:@"playbutton"] forState:UIControlStateNormal];
        self.playingaudio = NO;
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self.player stop];
    self.view.playlabel.text = @"AFSPELEN";
    [self.view.play setImage:[UIImage imageNamed:@"playbutton"] forState:UIControlStateNormal];
    self.playingaudio = NO;
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
        self.view.play.hidden = NO;
        self.view.playlabel.hidden = NO;
        
        [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.4 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            self.view.record.frame = CGRectMake((self.view.frame.size.width - self.view.recButton.size.width )/ 4 - 10 , 416, self.view.recButton.size.width, self.view.recButton.size.height);
            
            self.view.label.frame = CGRectMake(0, self.view.record.frame.size.height + self.view.record.frame.origin.y - 5, self.view.frame.size.width / 2, 50);
            
            
            self.view.play.frame = CGRectMake(((self.view.frame.size.width - self.view.playicon.size.width )/ 4)*3 + 10 , 416, self.view.playicon.size.width, self.view.playicon.size.height);
            
            self.view.playlabel.frame = CGRectMake(self.view.frame.size.width / 2, self.view.play.frame.size.height + self.view.play.frame.origin.y - 5, self.view.frame.size.width / 2, 50);
            
        }completion:nil];
        
        self.seconds = 0;
        
        [self.timer invalidate];
    }
}

@end
