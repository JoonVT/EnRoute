//
//  UploadViewController.m
//  API-test
//
//  Created by Niels Boey on 02/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import "UploadViewController.h"

@interface UploadViewController ()

@end

@implementation UploadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Camera";
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(upload:)];
    }
    return self;
}

- (void)loadView {
    
    CGRect sizeofScreen = [[UIScreen mainScreen] bounds];
    self.view = [[UploadView alloc] initWithFrame:sizeofScreen];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view.pictureButton addTarget:self action:@selector(takePicture:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.videoButton addTarget:self action:@selector(takeVideo:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:^{
        if(self.moviePlayer.view){
            [self.moviePlayer stop];
        }
    }];
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
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.videoQuality = UIImagePickerControllerQualityTypeIFrame1280x720;
    picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    
    [self presentViewController:picker animated:YES completion:^{
        if(self.moviePlayer.view){
            [self.moviePlayer stop];
        }
    }];
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
            
            [self.exporter exportAsynchronouslyWithCompletionHandler:^(void){
                NSLog(@"Exporting done!");
                self.mediaURL = self.exporter.outputURL;
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
        }
        
    }];
}

-(void)upload:(id)sender {
    NSLog(@"Upload tapped");

    NSString *onlineURL = @"http://student.howest.be/niels.boey/20132014/MAIV/ENROUTE/api/files";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
#warning update parameters met GroupID, ClassID en MediaID
    NSDictionary *parameters = @{@"groupid": @"1", @"classid": @"1", @"mediaid": @"1"};
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

    [manager POST:onlineURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:self.mediaURL name:@"file" error:nil];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
        UIAlertView *alertSuccess = [[UIAlertView alloc] initWithTitle:@"Super" message:@"Je foto/video is geupload." delegate:self cancelButtonTitle:@"Joepie!" otherButtonTitles:nil];
        [alertSuccess show];
#warning toon aan dat gegevens geupload zijn (remove alert)
#warning bij return true = Upload gelukt / false = mislukt
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error debugDescription]);
        NSLog(@"Error: %@", [error localizedDescription]);
        UIAlertView *alertSuccess = [[UIAlertView alloc] initWithTitle:@"Oei" message:@"Je foto/video kon niet geupload worden op de moment." delegate:self cancelButtonTitle:@"Oh nee" otherButtonTitles:nil];
        [alertSuccess show];
#warning toon aan dat gegevens NIET geupload zijn (remove alert)
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
