//
//  AssignmentToolsViewController.m
//  En Route
//
//  Created by Joon Van Thuyne on 10/06/14.
//  Copyright (c) 2014 JoonVT. All rights reserved.
//

#import "AssignmentToolsViewController.h"

@interface AssignmentToolsViewController ()

@end

@implementation AssignmentToolsViewController

- (id)initWithAssignment:(Assignment *)assignment andFrame:(CGRect)frame
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        
        self.assignment = assignment;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(brightnessDidChange:) name:UIScreenBrightnessDidChangeNotification object:nil];
        
        float light = [UIScreen mainScreen].brightness;
        
        [UIScreen mainScreen].brightness = light - 0.01;
        
        UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 66)];
        UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:self.assignment.name];
        
        navigationBar.tintColor = [UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1];
        navigationBar.translucent = YES;
        navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1],NSForegroundColorAttributeName,[UIFont fontWithName:@"Hallosans-black" size:20.0],NSFontAttributeName,nil];
        
        UIView *customBarButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
        
        UIButton *buttonDone = [UIButton buttonWithType:UIButtonTypeSystem];
        [buttonDone addTarget:self action:@selector(backTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        buttonDone.frame = CGRectMake(0, 0, 50, 30);
        
        buttonDone.titleLabel.textColor = [UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1];
        buttonDone.titleLabel.font = [UIFont fontWithName:@"Hallosans" size:20.0f];
        [buttonDone setTitle:@"Klaar" forState:UIControlStateNormal];
        [customBarButtonView addSubview:buttonDone];
        
        navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:customBarButtonView];
        
        [navigationBar pushNavigationItem:navigationItem animated:NO];
        [self.view addSubview:navigationBar];
    }
    return self;
}

- (void)loadView
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    self.view = [[AssignmentToolsView alloc] initWithAssignment:self.assignment andFrame:bounds];
}

- (void)backTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view.btnNotes addTarget:self action:@selector(notesTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.btnFlash addTarget:self action:@selector(flashTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.btnMicrophone addTarget:self action:@selector(microphoneTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.btnCamera addTarget:self action:@selector(cameraTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)notesTapped:(id)sender
{
    NotesTableViewController *notesTVC = [[NotesTableViewController alloc] initWithStyle:UITableViewStylePlain andAssignment:self.assignment];
    UINavigationController *navController =  [[UINavigationController alloc] initWithRootViewController:notesTVC];
    navController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1],NSForegroundColorAttributeName,[UIFont fontWithName:@"Hallosans-black" size:20.0],NSFontAttributeName,nil];
    [self presentViewController:navController animated:YES completion:^{}];
}

- (void)flashTapped:(id)sender
{
    AVCaptureDevice * captDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if ([captDevice hasFlash]&&[captDevice hasTorch])
    {
        if (captDevice.torchMode == AVCaptureTorchModeOff)
        {
            [self.view.btnFlash setBackgroundImage:[UIImage imageNamed:@"button_flash_on"] forState:UIControlStateNormal];
            [captDevice lockForConfiguration:nil];
            [captDevice setTorchMode:AVCaptureTorchModeOn];
            [captDevice unlockForConfiguration];
        }
        else
        {
            [self.view.btnFlash setBackgroundImage:[UIImage imageNamed:@"button_flash"] forState:UIControlStateNormal];
            [captDevice lockForConfiguration:nil];
            [captDevice setTorchMode:AVCaptureTorchModeOff];
            [captDevice unlockForConfiguration];
        }
    }
}

- (void)microphoneTapped:(id)sender
{
    
}

- (void)cameraTapped:(id)sender
{
    CameraViewController *cameraVC = [[CameraViewController alloc] initWithAssignment:self.assignment];
    UINavigationController *navController =  [[UINavigationController alloc] initWithRootViewController:cameraVC];
    navController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1],NSForegroundColorAttributeName,[UIFont fontWithName:@"Hallosans-black" size:20.0],NSFontAttributeName,nil];
    [self presentViewController:navController animated:YES completion:^{}];
}

-(void) brightnessDidChange:(NSNotification*)notification
{
    float light = [UIScreen mainScreen].brightness;

    if (light < 0.25) {
        light = 0.25;
    }
    
    NSLog(@"Brightness did change to %f", light*100);
    
    [UIView animateWithDuration:1 animations:^{
        self.view.backgroundColor = [UIColor colorWithRed:light+.25 green:light+.25 blue:light+.25 alpha:1];
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
