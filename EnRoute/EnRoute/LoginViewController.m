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

- (void)loadView{
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    self.view = [[LoginView alloc] initWithFrame:bounds];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view.btnLogin addTarget:self action:@selector(loginButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loginButtonTapped:(id)sender
{
    if([self.view.txtUsername.text isEqualToString:@"JoonVT"] && [self.view.txtPassword.text isEqualToString:@"azerty"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLoggedIn"];
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLoggedIn"];
        [self.view showErrorMessage];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
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
