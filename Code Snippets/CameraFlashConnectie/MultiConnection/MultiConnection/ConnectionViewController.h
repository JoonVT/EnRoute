//
//  ConnectionViewController.h
//  MultiConnection
//
//  Created by Niels Boey on 03/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "ConnectionView.h"

@interface ConnectionViewController : UIViewController <MCSessionDelegate, MCBrowserViewControllerDelegate>

@property (nonatomic,strong) ConnectionView *view;
@property (nonatomic,strong) MCBrowserViewController *browserVC;
@property (nonatomic,strong) MCPeerID *advertiserID;
@property (nonatomic,strong) MCSession *session;
@property (nonatomic,strong) MCAdvertiserAssistant *assistant;

@end