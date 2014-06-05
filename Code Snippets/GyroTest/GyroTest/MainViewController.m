//
//  MainViewController.m
//  GyroTest
//
//  Created by Joon Van Thuyne on 04/06/14.
//  Copyright (c) 2014 JoonVT. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    self.bounds = [[UIScreen mainScreen] bounds];
    
    self.view = [[MainView alloc] initWithFrame:self.bounds];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.rect = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.rect.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    self.rect.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.rect];
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = .2;
    self.motionManager.gyroUpdateInterval = .2;
    
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error)
    {
        [self outputAccelertionData:accelerometerData.acceleration];
        if(error)
        {
            NSLog(@"%@", error);
        }
    }];
    
    [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMGyroData *gyroData, NSError *error)
    {
        [self outputRotationData:gyroData.rotationRate];
    }];
}

-(void)outputAccelertionData:(CMAcceleration)acceleration
{
    NSLog(@"Acceleration X: %f", acceleration.x);
    NSLog(@"Acceleration Y: %f", acceleration.y);
    NSLog(@"Acceleration Z: %f", acceleration.z);
    
    self.rect.frame = CGRectMake(0, 0, self.rect.frame.size.width * acceleration.x, self.rect.frame.size.height * acceleration.y);
}
-(void)outputRotationData:(CMRotationRate)rotation
{
    
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
