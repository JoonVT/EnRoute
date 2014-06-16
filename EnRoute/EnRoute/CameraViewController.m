//
//  UploadViewController.m
//  API-test
//
//  Created by Niels Boey on 02/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

- (id)initWithAssignment:(Assignment *)assignment
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        self.assignment = assignment;
        
        self.title = @"Camera";
        
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

- (void)loadView
{    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    self.view = [[CameraView alloc] initWithFrame:bounds];
    
    CGFloat topRed = [[self.assignment.topColor objectForKey:@"red"] floatValue];
    CGFloat topGreen = [[self.assignment.topColor objectForKey:@"green"] floatValue];
    CGFloat topBlue = [[self.assignment.topColor objectForKey:@"blue"] floatValue];
    CGFloat topAlpha = [[self.assignment.topColor objectForKey:@"alpha"] floatValue];
    
    CGFloat bottomRed = [[self.assignment.bottomColor objectForKey:@"red"] floatValue];
    CGFloat bottomGreen = [[self.assignment.bottomColor objectForKey:@"green"] floatValue];
    CGFloat bottomBlue = [[self.assignment.bottomColor objectForKey:@"blue"] floatValue];
    CGFloat bottomAlpha = [[self.assignment.bottomColor objectForKey:@"alpha"] floatValue];
    
    UIColor *topColor = [UIColor colorWithRed:topRed green:topGreen blue:topBlue alpha:topAlpha];
    UIColor *bottomColor = [UIColor colorWithRed:bottomRed green:bottomGreen blue:bottomBlue alpha:bottomAlpha];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[topColor CGColor], (id)[bottomColor CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view.pictureButton addTarget:self action:@selector(takePicture:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.videoButton addTarget:self action:@selector(takeVideo:) forControlEvents:UIControlEventTouchUpInside];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [self.locationManager startUpdatingLocation];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIFont fontWithName:@"Hallosans" size:20.0f],NSFontAttributeName,
                                                          nil] forState:UIControlStateNormal];
}

-(void)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [UIImagePickerController new];
 
    if( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ){
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:^{
        if(self.moviePlayer.view){
            [self.moviePlayer stop];
        }
    }];
    
    self.mediaType = 1;
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if(self.moviePlayer.view){
        [self.moviePlayer play];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)takeVideo:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.videoMaximumDuration = 20.0;
    
    picker.videoQuality = UIImagePickerControllerQualityTypeIFrame1280x720;
    picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    
    if( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ){
       picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:picker animated:YES completion:^{
        if(self.moviePlayer.view){
            [self.moviePlayer stop];
        }
    }];
    
    self.mediaType = 3;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *photo = info[UIImagePickerControllerEditedImage];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        if(self.moviePlayer.view){
            [self.moviePlayer stop];
            [self.moviePlayer.view removeFromSuperview];
        }
        if(self.view.imageView){
            [self.view.imageView removeFromSuperview];
        }
       
       NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
        
        if ([mediaType isEqualToString:@"public.movie"]){
            self.mediaURL = [info objectForKey:UIImagePickerControllerMediaURL];
            self.mediaData = [NSData dataWithContentsOfURL:self.mediaURL];
            
            // output file
            NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            NSString *outputPath = [documents stringByAppendingPathComponent:@"video.mp4"];
            if ([[NSFileManager defaultManager] fileExistsAtPath:outputPath])
                [[NSFileManager defaultManager] removeItemAtPath:outputPath error:nil];
            
            // input file
            AVAsset *asset = [AVAsset assetWithURL:self.mediaURL];
            AVMutableComposition *composition = [AVMutableComposition composition];
            [composition  addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
            
            // input clip
            AVAssetTrack *clipVideoTrack = [[asset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
            
            // make it square
            AVMutableVideoComposition* videoComposition = [AVMutableVideoComposition videoComposition];
            videoComposition.renderSize = CGSizeMake(clipVideoTrack.naturalSize.height, clipVideoTrack.naturalSize.height);
            videoComposition.frameDuration = CMTimeMake(1, 30);
            
            AVMutableVideoCompositionInstruction *instruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
            instruction.timeRange = CMTimeRangeMake(kCMTimeZero, CMTimeMakeWithSeconds(60, 30));
            
            // rotate to portrait
            AVMutableVideoCompositionLayerInstruction *transformer = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:clipVideoTrack];
            CGAffineTransform transformOne = CGAffineTransformMakeTranslation(clipVideoTrack.naturalSize.height, -(clipVideoTrack.naturalSize.width - clipVideoTrack.naturalSize.height) / 2);
            CGAffineTransform transformTwo = CGAffineTransformRotate(transformOne, M_PI_2);
            
            CGAffineTransform finalTransform = transformTwo;
            [transformer setTransform:finalTransform atTime:kCMTimeZero];
            instruction.layerInstructions = [NSArray arrayWithObject:transformer];
            videoComposition.instructions = [NSArray arrayWithObject: instruction];
            
            // export
            self.exporter = [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetMediumQuality] ;
            self.exporter.videoComposition = videoComposition;
            self.exporter.outputURL=[NSURL fileURLWithPath:outputPath];
            self.exporter.outputFileType=AVFileTypeMPEG4;
            
            UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            activityView.frame = CGRectMake(0, 0, 25, 25);
            [activityView startAnimating];
            [activityView sizeToFit];
            [activityView setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin)];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:activityView];
            
            [self.exporter exportAsynchronouslyWithCompletionHandler:^
            {
                NSLog(@"Exporting done!");
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    UIView *btnSaveView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
                    
                    UIButton *btnSave = [UIButton buttonWithType:UIButtonTypeSystem];
                    btnSave.frame = CGRectMake(0, 0, 70, 30);
                    btnSave.titleLabel.textColor = [UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1];
                    btnSave.titleLabel.font = [UIFont fontWithName:@"Hallosans" size:20.0f];
                    [btnSave addTarget:self action:@selector(upload:) forControlEvents:UIControlEventTouchUpInside];
                    [btnSave setTitle:@"Opslaan" forState:UIControlStateNormal];
                    [btnSaveView addSubview:btnSave];
                    
                    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btnSaveView];
                    
                    self.mediaURL = self.exporter.outputURL;
                });
            }];
            
            self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:self.mediaURL];
            self.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
            [self.moviePlayer.view setFrame:self.view.imageView.frame];
            
            [self.moviePlayer setScalingMode:MPMovieScalingModeAspectFill];
            [self.moviePlayer setControlStyle:MPMovieControlStyleDefault];
            self.moviePlayer.repeatMode = MPMovieRepeatModeOne;
            
            [self.view addSubview:self.moviePlayer.view];
            [self.moviePlayer play];
            
        }else {
            self.view.imageView.image = photo;
            [self.view addSubview:self.view.imageView];
        
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"img.jpg"];
            
            NSData *photoData = UIImageJPEGRepresentation(photo, .6);
            [photoData writeToFile:filePath atomically:YES];
            
            self.mediaURL = [NSURL fileURLWithPath:filePath];
            
            UIView *btnSaveView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
            
            UIButton *btnSave = [UIButton buttonWithType:UIButtonTypeSystem];
            btnSave.frame = CGRectMake(0, 0, 70, 30);
            btnSave.titleLabel.textColor = [UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1];
            btnSave.titleLabel.font = [UIFont fontWithName:@"Hallosans" size:20.0f];
            [btnSave addTarget:self action:@selector(upload:) forControlEvents:UIControlEventTouchUpInside];
            [btnSave setTitle:@"Opslaan" forState:UIControlStateNormal];
            [btnSaveView addSubview:btnSave];
            
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btnSaveView];
        }
    }];
}

-(void)upload:(id)sender
{
    [self uploadFile:self.mediaURL];
}

-(void)uploadFile:(NSURL *)fileurl
{
    NSLog(@"Uploading");
    
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.frame = CGRectMake(0, 0, 25, 25);
    [activityView startAnimating];
    [activityView sizeToFit];
    [activityView setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:activityView];
    
    NSString *onlineURL = @"http://student.howest.be/niels.boey/20132014/MAIV/ENROUTE/api/files";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *group = [[NSUserDefaults standardUserDefaults] objectForKey:@"group"];
    
    NSDictionary *parameters = @{
                                 @"groupid": [group objectForKey:@"id"],
                                 @"classid": [group objectForKey:@"classid"],
                                 @"mediaid": [NSString stringWithFormat:@"%i", self.mediaType],
                                 @"assignmentid": [NSString stringWithFormat:@"%i", self.assignment.identifier],
                                 @"latitude": [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.latitude],
                                 @"longitude": [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.longitude]
                                 };
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
