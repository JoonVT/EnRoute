//
//  LookViewController.m
//  Ik zie, Ik zie
//
//  Created by Niels Boey on 12/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import "LookViewController.h"

@interface LookViewController ()

@end

@implementation LookViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Connecteer";
    }
    return self;
}

- (void)loadView {
    CGRect sizeofScreen = [[UIScreen mainScreen] bounds];
    self.view = [[LookView alloc] initWithFrame:sizeofScreen];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view.connectButton addTarget:self action:@selector(connect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.speakerButton addTarget:self action:@selector(speaker:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.manageButton addTarget:self action:@selector(watchConnections) forControlEvents:UIControlEventTouchUpInside];
    [self.view.cameraButton addTarget:self action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
    [self.view.sendPhotoButton addTarget:self action:@selector(sendPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.rightButton addTarget:self action:@selector(rightAnswer:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.wrongButton addTarget:self action:@selector(wrongAnswer:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.uploadButton addTarget:self action:@selector(upload:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.uploadButton addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [self.locationManager startUpdatingLocation];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendOutAudio:) name:@"sendaudio" object:nil];
}

-(void)dismiss:(id)sender {
#warning DISMISS VIEW
    NSLog(@"DISMISS VIEW CONTROLLER");
}

-(void)upload:(id)sender {
    NSURL *fileurl = self.mediaURL;
   [self uploadFile:fileurl];
}

-(void)wrongAnswer:(id)sender {
    NSString *message = @"wrong";
    
    self.view.rightButton.hidden = YES;
    self.view.wrongButton.hidden = YES;
    self.view.photoview.hidden = YES;
    self.view.animationImageView.hidden = NO;
    
    MCPeerID *peer = self.session.connectedPeers[0];
    self.view.connected.text = [NSString stringWithFormat:@"Wacht op %@...",peer.displayName];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:message];
    
    dispatch_async(dispatch_get_main_queue(),^{
        NSError *error;
        [self.session sendData:data toPeers:[self.session connectedPeers] withMode:MCSessionSendDataReliable error:&error];
    });
}

-(void)rightAnswer:(id)sender {
    self.view.rightButton.hidden = YES;
    self.view.wrongButton.hidden = YES;
    
    self.view.connected.text = @"Voltooid!";
    self.view.connected.textColor = [UIColor colorWithRed:0.18 green:0.65 blue:0.42 alpha:1];
    self.view.connected.font = [UIFont fontWithName:@"Hallosans-Black" size:22];
    self.view.uploadButton.hidden = YES;
    self.view.photoview.hidden = YES;
    self.view.dismissButton.hidden = NO;
    
    self.view.connected.text = @"De andere groep was juist!";
    
    NSString *message = @"right";
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:message];

    dispatch_async(dispatch_get_main_queue(),^{
        NSError *error;
        [self.session sendData:data toPeers:[self.session connectedPeers] withMode:MCSessionSendDataReliable error:&error];
    });
}


-(void)connect:(id)sender {
    self.advertiserID = [[MCPeerID alloc] initWithDisplayName:[UIDevice currentDevice].name];
    
    self.session = [[MCSession alloc] initWithPeer:self.advertiserID];
    self.session.delegate = self;
    
    NSString *serviceType = @"browsing";
    
    self.browserVC = [[MCBrowserViewController alloc] initWithServiceType:serviceType session:self.session];
    self.browserVC.delegate = self;
    
    self.assistant = [[MCAdvertiserAssistant alloc] initWithServiceType:serviceType discoveryInfo:nil session:self.session];
    
    [self.assistant start];
    
    [self presentViewController:self.browserVC animated:YES completion:nil];
}


/* DELEGATE METHODS */
-(void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state {
    if(state == MCSessionStateConnected){
        NSLog(@"Connected");
    }else{
        NSLog(@"Not connected");
    }
}

-(void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID {
    dispatch_async(dispatch_get_main_queue(),^{
        [self receiveMessage:data fromPeer:peerID];
    });
}

- (void)receiveMessage:(NSData *)data fromPeer:(MCPeerID *)peer{
    
    NSData *receivedObject = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    self.view.animationImageView.hidden = YES;
    
    if ([receivedObject isKindOfClass:[NSString class]]) {
        if([receivedObject  isEqual: @"speakerset"]){
            self.view.speakerButton.hidden = YES;
            NSString *cameratext = [NSString stringWithFormat:@"Wacht op %@...",peer.displayName];
            self.view.animationImageView.hidden = NO;
            self.view.connected.text = cameratext;
        }else if([receivedObject isEqual:@"right"]){
            self.view.connected.text = @"Juist!";
            self.view.connected.textColor = [UIColor colorWithRed:0.18 green:0.65 blue:0.42 alpha:1];
            self.view.connected.font = [UIFont fontWithName:@"Hallosans-Black" size:22];
            self.view.sendPhotoButton.hidden = YES;
            self.view.uploadButton.hidden = NO;
            self.view.photoview.hidden = NO;
        }else if([receivedObject isEqual:@"wrong"]){
            self.view.photoview.hidden = YES;
            self.view.cameraButton.hidden = NO;
            self.view.connected.text = @"Verkeerd, probeer opnieuw";
            self.view.sendPhotoButton.hidden = YES;
        }
    }
}

-(void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID {
}

-(void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error {
    
    dispatch_async(dispatch_get_main_queue(),^{
        
        if (error){
            NSLog(@"Error when receiving file! %@", error);
        }else{
             self.view.animationImageView.hidden = YES;
            
            if([resourceName isEqual:@"audio"]){
                [self setupAudio:localURL];
                self.view.cameraButton.hidden = NO;
            }else {
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:localURL]];
                
                self.view.photoview.image = image;
                [self.view addSubview:self.view.photoview];
                self.view.rightButton.hidden = NO;
                self.view.wrongButton.hidden = NO;
                self.view.photoview.hidden = NO;
                self.view.connected.text = @"Is dit wat je zag?";
                self.mediaURL = localURL;
            }
           
        }
    });
    
}

-(void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress {

    dispatch_async(dispatch_get_main_queue(),^{
        self.view.connected.text = @"Bestand aan het downloaden...";
    });
    
}

-(void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController {
    [self showConnections:self.browserVC.session.connectedPeers];
    
    self.view.connectButton.hidden = YES;
    self.view.manageButton.hidden = NO;
    self.view.speakerButton.hidden = NO;
    
    [self.browserVC dismissViewControllerAnimated:YES completion:nil];
}

-(void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController {
    [self.browserVC dismissViewControllerAnimated:YES completion:nil];
}

/* EXTRA */
-(void)watchConnections {
    [self presentViewController:self.browserVC animated:YES completion:nil];
}

-(void)showConnections:(NSArray *)connected {
    
    NSMutableString *text;
    
    if(connected.count == 1){
        text = [NSMutableString stringWithFormat:@"Verbonden met %lu toestel",(unsigned long)connected.count];
    }else {
        text = [NSMutableString stringWithFormat:@"Verbonden met %lu toestellen",(unsigned long)connected.count];
    }
    
    self.view.connected.text = text;
}


-(void)takePicture {
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    
    if( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else {
         imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    [self presentViewController:imagePicker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    if (image != nil)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:@"image.png" ];
        NSData* data = UIImagePNGRepresentation(image);
        [data writeToFile:path atomically:YES];
    }

    [self dismissViewControllerAnimated:YES completion:^{
        self.view.photoview.image = image;
        [self.view addSubview:self.view.photoview];
        self.view.sendPhotoButton.hidden = NO;
        self.view.photoview.hidden = NO;

        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"img.jpg"];
        
        NSData *photoData = UIImageJPEGRepresentation(image, .6);
        [photoData writeToFile:filePath atomically:YES];
        
        self.mediaURL = [NSURL fileURLWithPath:filePath];
        
        self.view.connected.text = @"Is dit wat de andere groep zag?";
        self.view.play.hidden = YES;
        self.view.cameraButton.hidden = YES;
        self.view.playlabel.hidden = YES;
        
        self.mediaURL = [NSURL fileURLWithPath:filePath];

    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)speaker:(id)sender {
    NSString *message = @"speakerset";
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:message];
    
    dispatch_async(dispatch_get_main_queue(),^{
        NSError *error;
        [self.session sendData:data toPeers:[self.session connectedPeers] withMode:MCSessionSendDataReliable error:&error];
    });
   
    self.recordVC = [[RecordViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:self.recorderVC animated:YES];

}

-(void)sendOutAudio:(NSNotification *)notification {
    [self.navigationController popViewControllerAnimated:self.recorderVC];
    
    MCPeerID *peer = self.session.connectedPeers[0];
    
     NSString *waittext = [NSString stringWithFormat:@"Wacht op %@...",peer.displayName];
    
    self.view.speakerButton.hidden = YES;
    self.view.animationImageView.hidden = NO;
    self.view.connected.text = waittext;
    
    NSURL *audiourl = [notification.userInfo objectForKey:@"audiourl"];
    [self send:audiourl];
}

-(void)send:(NSURL *)audiourl {
    
    NSArray *peers = [self.session connectedPeers];
    
    for(int i = 0; i < peers.count; i++){
        MCPeerID *peer = peers[i];
        
        [self.session sendResourceAtURL:audiourl withName:@"audio" toPeer:peer withCompletionHandler:^(NSError *error) {
            if (error) {
                NSLog(@"Error sending audio! %@", error);
            }
        }];
    }
 
}

-(void)setupAudio:(NSURL *)audiourl {
    self.view.connected.text = @"Audio ontvangen";
    self.view.play.hidden = NO;
    self.view.playlabel.hidden = NO;
    
    self.audioSession = [AVAudioSession sharedInstance];
    [self.audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    NSError *audioError;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:audiourl error:&audioError];
    self.player.delegate = self;
    
    [self.view.play addTarget:self action:@selector(playAudio:) forControlEvents:UIControlEventTouchUpInside];
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

-(void)sendPhoto:(id)sender {
    NSArray *peers = [self.session connectedPeers];
    
    for(int i = 0; i < peers.count; i++){
        MCPeerID *peer = peers[i];
        
        [self.session sendResourceAtURL:self.mediaURL withName:@"image" toPeer:peer withCompletionHandler:^(NSError *error) {
            if (error) {
                NSLog(@"Error sending image! %@", error);
            }
        }];
        
        self.view.photoview.hidden = YES;
        self.view.connected.text = @"Wacht om te kijken of je juist bent";
        self.view.sendPhotoButton.hidden = YES;
        self.view.animationImageView.hidden = NO;
    }
 
}

-(void)uploadFile:(NSURL *)fileurl {
    self.view.connected.text = @"Aan het uploaden...";
    
    NSString *onlineURL = @"http://student.howest.be/niels.boey/20132014/MAIV/ENROUTE/api/files";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
#warning update parameters
    NSDictionary *parameters = @{@"groupid": @"1", @"classid": @"1", @"mediaid": @"1", @"assignmentid": @"1", @"latitude": @"0", @"longitude": @"0"};
    
   // manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:onlineURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:fileurl name:@"file" error:nil];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
        self.view.connected.text = @"Geüpload";
#warning succes en error massage bij uploaden
        self.view.uploadButton.hidden = YES;
        self.view.photoview.hidden = YES;
        self.view.dismissButton.hidden = NO;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error debugDescription]);
        NSLog(@"Error: %@", [error localizedDescription]);
        self.view.connected.text = @"Uploaden mislukt";
    }];
}

@end