//
//  UploadViewController.h
//  API-test
//
//  Created by Niels Boey on 02/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CoreLocation/CoreLocation.h>
#import "CameraView.h"
#import "Assignment.h"

@interface CameraViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic,strong)  CameraView *view;

@property (nonatomic,strong) NSURL *mediaURL;
@property (nonatomic,strong) NSData *mediaData;
@property (nonatomic) int mediaType;

@property (nonatomic,strong) AVPlayer *player;
@property (nonatomic,strong) MPMoviePlayerController *moviePlayer;
@property (nonatomic,strong) AVAssetExportSession *exporter;
@property (nonatomic,strong) CLLocationManager *locationManager;

@property (strong, nonatomic) Assignment *assignment;

- (id)initWithAssignment:(Assignment *)assignment;

@end
