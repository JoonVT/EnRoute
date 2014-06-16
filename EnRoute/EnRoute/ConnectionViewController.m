//
//  ConnectionViewController.m
//  MultiConnection
//
//  Created by Niels Boey on 03/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import "ConnectionViewController.h"

@interface ConnectionViewController ()

@end

@implementation ConnectionViewController

- (id)initWithAssignment:(Assignment *)assignment
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        
        self.assignment = assignment;
        
        self.title = @"Connecteer";
        
        CGFloat topRed = [[assignment.topColor objectForKey:@"red"] floatValue];
        CGFloat topGreen = [[assignment.topColor objectForKey:@"green"] floatValue];
        CGFloat topBlue = [[assignment.topColor objectForKey:@"blue"] floatValue];
        CGFloat topAlpha = [[assignment.topColor objectForKey:@"alpha"] floatValue];
        
        CGFloat bottomRed = [[assignment.bottomColor objectForKey:@"red"] floatValue];
        CGFloat bottomGreen = [[assignment.bottomColor objectForKey:@"green"] floatValue];
        CGFloat bottomBlue = [[assignment.bottomColor objectForKey:@"blue"] floatValue];
        CGFloat bottomAlpha = [[assignment.bottomColor objectForKey:@"alpha"] floatValue];
        
        UIColor *topColor = [UIColor colorWithRed:topRed green:topGreen blue:topBlue alpha:topAlpha];
        UIColor *bottomColor = [UIColor colorWithRed:bottomRed green:bottomGreen blue:bottomBlue alpha:bottomAlpha];
        
        CGRect bounds = [[UIScreen mainScreen] bounds];
        
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = bounds;
        gradient.colors = [NSArray arrayWithObjects:(id)[topColor CGColor], (id)[bottomColor CGColor], nil];
        [self.view.layer insertSublayer:gradient atIndex:0];
        
        UIView *btnDoneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
        
        UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeSystem];
        btnDone.frame = CGRectMake(0, 0, 50, 30);
        btnDone.titleLabel.textColor = [UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1];
        btnDone.titleLabel.font = [UIFont fontWithName:@"Hallosans" size:20.0f];
        [btnDone addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [btnDone setTitle:@"Klaar" forState:UIControlStateNormal];
        [btnDoneView addSubview:btnDone];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btnDoneView];
    }
    return self;
}

- (void)loadView {
    
    CGRect sizeofScreen = [[UIScreen mainScreen] bounds];
    self.view = [[ConnectionView alloc] initWithFrame:sizeofScreen];
}

-(void)dismiss
{
    [self.session disconnect];
    
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view.connectButton addTarget:self action:@selector(connectToDevice:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.cameraButton addTarget:self action:@selector(sendTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.flashButton addTarget:self action:@selector(turnFlashOn) forControlEvents:UIControlEventTouchUpInside];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIFont fontWithName:@"Hallosans" size:20.0f],NSFontAttributeName,
                                                          nil] forState:UIControlStateNormal];
}


-(void)connectToDevice:(id)sender {
    [self setUpMultipeer];
}

-(void)viewDidAppear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)setUpMultipeer {

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

-(void)manageDevices {
    [self presentViewController:self.browserVC animated:YES completion:nil];
}

- (void)receiveMessage:(NSString *)message fromPeer:(MCPeerID *)peer{
    
    if([message  isEqual: @"flash"]){
        [self turnFlashOn];
    }

}

- (void)sendTapped:(id)sender {
    NSString *message = @"flash";
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    NSArray *peers = [self.session connectedPeers];
    
    for(MCPeerID *user in peers){
        NSLog(@"%@",user.displayName);
    }
    
    NSDictionary *dict = @{@"datatype":@"text"};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"message_sent" object:self userInfo:dict];
    
    [self.session sendData:data toPeers:[self.session connectedPeers] withMode:MCSessionSendDataUnreliable error:&error];
    [self showCamera];
}

-(void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController {
     NSLog(@"cancel tapped");
    [self.browserVC dismissViewControllerAnimated:YES completion:nil];
}

-(void)browserViewControllerDidFinish:(MCBrowserViewController *)browserVC {
     NSLog(@"done tapped");
    [self showConnections:browserVC.session.connectedPeers];
    
    self.view.connectButton.hidden = YES;
    self.view.cameraButton.hidden = NO;
    
	[self.browserVC dismissViewControllerAnimated:YES completion:nil];
}

-(void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state {
    NSLog(@"state changed");
    if(state == MCSessionStateConnected){
        NSLog(@"Connected");
    }else{
        NSLog(@"Not connected");
    }
}

-(void)showConnections:(NSArray *)connected {
    NSLog(@"%@", connected);
    
    NSMutableString *text = [NSMutableString stringWithFormat:@"Connected to:"];
    
    for(MCPeerID *user in connected){
        NSLog(@"%@",user.displayName);
        [text appendFormat:@" %@",user.displayName];
    }
}

-(void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID {
    
     NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
     dispatch_async(dispatch_get_main_queue(),^{
         [self receiveMessage:message fromPeer:peerID];
     });
}

-(void)messageType:(id)sender {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"message_sent" object:nil];
}

-(void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID{
    
}

-(void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress {
    
}

-(void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error {
    
}

-(void)turnFlashOn
{
    self.view.cameraButton.hidden = YES;
    self.view.flashButton.hidden = NO;
    
    AVCaptureDevice * captDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if ([captDevice hasFlash]&&[captDevice hasTorch])
    {
        if (captDevice.torchMode == AVCaptureTorchModeOff)
        {
            [captDevice lockForConfiguration:nil];
            [captDevice setTorchMode:AVCaptureTorchModeOn];
            [captDevice unlockForConfiguration];
        }
        else
        {
            [captDevice lockForConfiguration:nil];
            [captDevice setTorchMode:AVCaptureTorchModeOff];
            [captDevice unlockForConfiguration];
        }
    }
}

-(void)showCamera
{
    CameraViewController *cameraVC = [[CameraViewController alloc] initWithAssignment:self.assignment];
    UINavigationController *navController =  [[UINavigationController alloc] initWithRootViewController:cameraVC];
    navController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1],NSForegroundColorAttributeName,[UIFont fontWithName:@"Hallosans-black" size:20.0],NSFontAttributeName,nil];
    [self presentViewController:navController animated:YES completion:^{}];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismiss) name:@"closed" object:nil];
}

@end
