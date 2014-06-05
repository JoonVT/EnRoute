//
//  LoginViewController.m
//  En Route
//
//  Created by Joon Van Thuyne on 03/06/14.
//  Copyright (c) 2014 JoonVT. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    self.view = [[LoginView alloc] initWithFrame:bounds];
}

- (void)viewDidAppear:(BOOL)animated
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    [UIView animateWithDuration:2 delay:.5 usingSpringWithDamping:.75 initialSpringVelocity:.75 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.view.backImage.center = CGPointMake(bounds.size.width/2, 0);
    } completion:^(BOOL finished)
    {
        [UIView animateWithDuration:.75 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.view.welcome.center = CGPointMake(bounds.size.width/2, bounds.origin.y+55);
        } completion:^(BOOL finished)
        {
            [UIView animateWithDuration:.75 delay:.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.view.lblTitle.alpha = 1;
                self.view.lblSubTitle.alpha = 1;
                self.view.classSelect.alpha = 1;
                self.view.btnStart.alpha = 1;
                self.view.loading.alpha = .75;
                [self.view.loading startAnimating];
            } completion:^(BOOL finished){}];
        }];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadClasses];
}

- (void)loadClasses
{
    self.classData = [[NSMutableArray alloc] initWithObjects:nil];
    
    NSAttributedString *txtStart = [[NSAttributedString alloc] initWithString:@"START" attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Hallosans-Black" size:22], NSForegroundColorAttributeName : [UIColor colorWithRed:0.76 green:0.62 blue:0.18 alpha:1], NSKernAttributeName : @(1.0f)}];
    
    NSAttributedString *txtReload = [[NSAttributedString alloc] initWithString:@"HERLAAD" attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Hallosans-Black" size:22], NSForegroundColorAttributeName : [UIColor colorWithRed:0.76 green:0.62 blue:0.18 alpha:1], NSKernAttributeName : @(1.0f)}];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://student.howest.be/niels.boey/20132014/MAIV/ENROUTE/api/classgroups" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for (NSDictionary* value in responseObject)
        {
            NSString *class = value[@"classname"];
            [self.classData addObject:class];
        }
        
        self.view.classSelect.delegate = self;
        [self.view.loading removeFromSuperview];
        [self.view addSubview:self.view.classSelect];
        [self.view.btnStart setAttributedTitle:txtStart forState:UIControlStateNormal];
        [self.view.btnStart addTarget:self action:@selector(startButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertError = [[UIAlertView alloc] initWithTitle:@"Oei, oei" message:@"Ik werk jammer genoeg niet zonder internet… Zoek je vlug een netwerk?" delegate:self cancelButtonTitle:@"Ok, niet erg" otherButtonTitles:nil];
        [self.view.btnStart setAttributedTitle:txtReload forState:UIControlStateNormal];
        [self.view.btnStart addTarget:self action:@selector(reloadButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [alertError show];
    }];
}

- (void)startButtonTapped:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLoggedIn"];
    [self dismissViewControllerAnimated:YES completion:^{}];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)reloadButtonTapped:(id)sender
{
    [self loadClasses];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    NSString *listText = self.classData[row];
    
    NSAttributedString *txtLabel = [[NSAttributedString alloc] initWithString:listText attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Hallosans-Black" size:18], NSForegroundColorAttributeName : [UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1], NSKernAttributeName : @(1.0f)}];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 44)];
    label.attributedText = txtLabel;
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.classData.count;
}

-(NSString*) pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.classData objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //Write the required logic here that should happen after you select a row in Picker View.
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
