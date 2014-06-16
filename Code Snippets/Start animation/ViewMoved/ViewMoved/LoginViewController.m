//
//  LoginViewController.m
//  ViewMoved
//
//  Created by Niels Boey on 05/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
}

-(void)viewDidAppear:(BOOL)animated {
    [self.view.animationImageView startAnimating];
}

- (void)loadView {
    CGRect sizeofScreen = [[UIScreen mainScreen] bounds];
    self.view = [[LoginView alloc] initWithFrame:sizeofScreen];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
