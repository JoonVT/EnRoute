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

- (id)initWithAssignment:(Assignment *)assignment
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        
        self.assignment = assignment;
        
        UIView *btnDoneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
        
        UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeSystem];
        btnDone.frame = CGRectMake(0, 0, 50, 30);
        btnDone.titleLabel.textColor = [UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1];
        btnDone.titleLabel.font = [UIFont fontWithName:@"Hallosans" size:20.0f];
        [btnDone addTarget:self action:@selector(backTapped:) forControlEvents:UIControlEventTouchUpInside];
        [btnDone setTitle:@"Klaar" forState:UIControlStateNormal];
        [btnDoneView addSubview:btnDone];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btnDoneView];
    }
    return self;
}

- (void)backTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{}];
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
    [self.view.play addTarget:self action:@selector(playAudio:) forControlEvents:UIControlEventTouchUpInside];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [self.locationManager startUpdatingLocation];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIFont fontWithName:@"Hallosans" size:20.0f],NSFontAttributeName,
                                                          nil] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)upload:(id)sender
{
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.frame = CGRectMake(0, 0, 25, 25);
    [activityView startAnimating];
    [activityView sizeToFit];
    [activityView setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:activityView];
    
    [self uploadFile:self.recordedAudioURL];
}

-(void)uploadFile:(NSURL *)fileurl
{
    NSString *onlineURL = @"http://student.howest.be/niels.boey/20132014/MAIV/ENROUTE/api/files";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *group = [[NSUserDefaults standardUserDefaults] objectForKey:@"group"];

    NSDictionary *parameters = @{
                                 @"groupid": [group objectForKey:@"id"],
                                 @"classid": [group objectForKey:@"classid"],
                                 @"mediaid": @"2",
                                 @"assignmentid": [NSString stringWithFormat:@"%i", self.assignment.identifier],
                                 @"latitude": [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.latitude],
                                 @"longitude": [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.longitude]
                                 };
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:onlineURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:fileurl name:@"file" error:nil];
    }
    success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"Success: %@", responseObject);
        
        UIView *btnFakeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
        
        UIButton *btnFake = [UIButton buttonWithType:UIButtonTypeSystem];
        btnFake.frame = CGRectMake(0, 0, 70, 30);
        btnFake.titleLabel.textColor = [UIColor colorWithRed:0.33 green:0.79 blue:0.63 alpha:1];
        btnFake.titleLabel.font = [UIFont fontWithName:@"Hallosans" size:20.0f];
        [btnFake setTitle:@"Geüpload" forState:UIControlStateNormal];
        [btnFakeView addSubview:btnFake];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btnFakeView];
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"Error: %@", [error debugDescription]);
        NSLog(@"Error: %@", [error localizedDescription]);
        
        UIAlertView *alertError = [[UIAlertView alloc] initWithTitle:@"Oei, oei" message:@"Er is iets foutgelopen…\nheb je wel internet?" delegate:self cancelButtonTitle:@"Ok, niet erg" otherButtonTitles:nil];
        [alertError show];
    }];

}
    

-(void)playAudio:(id)sender {
    [self.audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    NSError *audioError;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.recordedAudioURL error:&audioError];
    self.player.delegate = self;

    
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
    
    if(self.playingaudio == YES){
        [self.player pause];
        self.view.playlabel.text = @"AFSPELEN";
        [self.view.play setImage:[UIImage imageNamed:@"playbutton"] forState:UIControlStateNormal];
        self.playingaudio = NO;
    }
    
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
        
        self.view.play.hidden = NO;
        self.view.playlabel.hidden = NO;
        
        [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.4 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            self.view.record.frame = CGRectMake((self.view.frame.size.width - self.view.recButton.size.width )/ 4 - 10 , 416, self.view.recButton.size.width, self.view.recButton.size.height);
            
            self.view.label.frame = CGRectMake(0, self.view.record.frame.size.height + self.view.record.frame.origin.y - 5, self.view.frame.size.width / 2, 50);
            
            
            self.view.play.frame = CGRectMake(((self.view.frame.size.width - self.view.playicon.size.width )/ 4)*3 + 10 , 416, self.view.playicon.size.width, self.view.playicon.size.height);
            
            self.view.playlabel.frame = CGRectMake(self.view.frame.size.width / 2, self.view.play.frame.size.height + self.view.play.frame.origin.y - 5, self.view.frame.size.width / 2, 50);
            
        }completion:nil];
        
        UIView *btnSaveView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
        
        UIButton *btnSave = [UIButton buttonWithType:UIButtonTypeSystem];
        btnSave.frame = CGRectMake(0, 0, 70, 30);
        btnSave.titleLabel.textColor = [UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1];
        btnSave.titleLabel.font = [UIFont fontWithName:@"Hallosans" size:20.0f];
        [btnSave addTarget:self action:@selector(upload:) forControlEvents:UIControlEventTouchUpInside];
        [btnSave setTitle:@"Opslaan" forState:UIControlStateNormal];
        [btnSaveView addSubview:btnSave];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btnSaveView];
        
        self.seconds = 0;
        
        [self.timer invalidate];
    }
}

@end
