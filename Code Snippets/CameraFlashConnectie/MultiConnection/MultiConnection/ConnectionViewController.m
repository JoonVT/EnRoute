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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)loadView {
    
    CGRect sizeofScreen = [[UIScreen mainScreen] bounds];
    self.view = [[ConnectionView alloc] initWithFrame:sizeofScreen];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view.connectButton addTarget:self action:@selector(connectToDevice:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.cameraButton addTarget:self action:@selector(sendTapped:) forControlEvents:UIControlEventTouchUpInside];
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

-(void)turnFlashOn {
    NSLog(@"TURN FLASH ON");
#warning code om flash op aan te zetten
}

-(void)showCamera {
    NSLog(@"TURN CAMERA ON");
#warning code om camera te tonen
}

@end
