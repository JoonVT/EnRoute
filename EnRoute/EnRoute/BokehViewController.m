//
//  BokehViewController.m
//  En Route
//
//  Created by Joon Van Thuyne on 16/06/14.
//  Copyright (c) 2014 JoonVT. All rights reserved.
//

#import "BokehViewController.h"

@interface BokehViewController ()

@end

@implementation BokehViewController

- (id)initWithAssignment:(Assignment *)assignment
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        self.assignment = assignment;
        
        self.title = @"Bokeh";
        
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
        [btnDone addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
        [btnDone setTitle:@"Klaar" forState:UIControlStateNormal];
        [btnDoneView addSubview:btnDone];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btnDoneView];
    }
    return self;
}

- (void)loadView
{
    CGRect sizeofScreen = [[UIScreen mainScreen] bounds];
    self.view = [[BokehView alloc] initWithFrame:sizeofScreen];
}

-(void)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view.cameraButton addTarget:self action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [self.locationManager startUpdatingLocation];
 
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingHeading];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIFont fontWithName:@"Hallosans" size:20.0f],NSFontAttributeName,
                                                          nil] forState:UIControlStateNormal];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    
    CGFloat xx = (CGFloat) (arc4random() % (int) self.view.bounds.size.width);
    CGFloat yy = (CGFloat) (arc4random() % (int) self.view.bounds.size.height);
    
    CGRect frame = CGRectMake(xx, yy, 40, 40);
    UIColor *colorC = [UIColor colorWithRed:0.98 green:0.91 blue:0.35 alpha:.8];
    
    if(self.prepoint > 5 + newHeading.magneticHeading){
        [self.view drawCircle:frame andColor:colorC];
    }else if( self.prepoint < 5 - newHeading.magneticHeading){
        [self.view drawCircle:frame andColor:colorC];
    }
    
    self.prepoint = newHeading.magneticHeading;
}

-(void)snap:(id)sender {
    float width = self.view.topView.frame.size.width;
    
    CGSize size = CGSizeMake(width, width);
    
    UIGraphicsBeginImageContext( size );
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"img.jpg"];
    
    NSData *photoData = UIImageJPEGRepresentation(viewImage, .6);
    [photoData writeToFile:filePath atomically:YES];
    
    self.mediaURL = [NSURL fileURLWithPath:filePath];
    
    [self upload];
}

-(void)upload
{
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.frame = CGRectMake(0, 0, 25, 25);
    [activityView startAnimating];
    [activityView sizeToFit];
    [activityView setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:activityView];
    
    NSURL *fileurl = self.mediaURL;
    [self uploadFile:fileurl];
}

-(void)uploadFile:(NSURL *)fileurl
{
    NSString *onlineURL = @"http://student.howest.be/niels.boey/20132014/MAIV/ENROUTE/api/files";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *group = [[NSUserDefaults standardUserDefaults] objectForKey:@"group"];
    
    NSDictionary *parameters = @{
                                 @"groupid": [group objectForKey:@"id"],
                                 @"classid": [group objectForKey:@"classid"],
                                 @"mediaid": @"1",
                                 @"assignmentid": [NSString stringWithFormat:@"%i", self.assignment.identifier],
                                 @"latitude": [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.latitude],
                                 @"longitude": [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.longitude]
                                 };
    
    // manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:onlineURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:fileurl name:@"file" error:nil];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Success: %@", responseObject);
        
        UIView *btnFakeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
        
        UIButton *btnFake = [UIButton buttonWithType:UIButtonTypeSystem];
        btnFake.frame = CGRectMake(0, 0, 70, 30);
        btnFake.titleLabel.textColor = [UIColor colorWithRed:0.33 green:0.79 blue:0.63 alpha:1];
        btnFake.titleLabel.font = [UIFont fontWithName:@"Hallosans" size:20.0f];
        [btnFake setTitle:@"Geüpload" forState:UIControlStateNormal];
        [btnFakeView addSubview:btnFake];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btnFakeView];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error debugDescription]);
        NSLog(@"Error: %@", [error localizedDescription]);
        
        UIAlertView *alertError = [[UIAlertView alloc] initWithTitle:@"Oei, oei" message:@"Er is iets foutgelopen…\nheb je wel internet?" delegate:self cancelButtonTitle:@"Ok, niet erg" otherButtonTitles:nil];
        [alertError show];
    }];
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
        self.view.imageView.image = image;
        [self.view addSubview:self.view.imageView];
        self.view.bottomView.image = image;
        
        self.view.cameraButton.hidden = YES;
        [self.view addInterface];
        
        UIView *btnSaveView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
        
        UIButton *btnSave = [UIButton buttonWithType:UIButtonTypeSystem];
        btnSave.frame = CGRectMake(0, 0, 70, 30);
        btnSave.titleLabel.textColor = [UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1];
        btnSave.titleLabel.font = [UIFont fontWithName:@"Hallosans" size:20.0f];
        [btnSave addTarget:self action:@selector(snap:) forControlEvents:UIControlEventTouchUpInside];
        [btnSave setTitle:@"Opslaan" forState:UIControlStateNormal];
        [btnSaveView addSubview:btnSave];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btnSaveView];
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
