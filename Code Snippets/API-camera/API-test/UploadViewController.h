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
#import "UploadView.h"

@interface UploadViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic,strong)  UploadView *view;

@property (nonatomic,strong) NSURL *mediaURL;
@property (nonatomic,strong) NSData *mediaData;

@property (nonatomic,strong) AVPlayer *player;
@property (nonatomic,strong) MPMoviePlayerController *moviePlayer;
@property (nonatomic,strong) AVAssetExportSession *exporter;

@end
