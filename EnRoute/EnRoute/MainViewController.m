//
//  MainViewController.m
//  EnRoute
//
//  Created by Joon Van Thuyne on 28/05/14.
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
        
        self.title = @"En Route";
    }
    return self;
}

- (void)loadView{
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    self.view = [[MainView alloc] initWithFrame:bounds];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(brightnessDidChange:) name:UIScreenBrightnessDidChangeNotification object:nil];
    
    [UIScreen mainScreen].brightness = 0.5;
}

- (void)viewDidAppear:(BOOL)animated
{
    if( [[NSUserDefaults standardUserDefaults] boolForKey:@"isLoggedIn"] == NO )
    {
        self.loginVC = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
        [self presentViewController:self.loginVC animated:NO completion:^{}];
    }
}

-(void) brightnessDidChange:(NSNotification*)notification
{
    float light = [UIScreen mainScreen].brightness;
    int redPercentage = 255*light;
    int greenPercentage = 255-redPercentage;
    
    NSLog(@"Brightness did change to %f", light*100);
    
    self.view.backgroundColor = [UIColor colorWithRed:(redPercentage/255.0) green:(greenPercentage/255.0) blue:(0) alpha:1];
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
