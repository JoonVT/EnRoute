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
    
    self.classData = [[NSMutableArray alloc] initWithObjects:nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://student.howest.be/niels.boey/20132014/MAIV/ENROUTE/api/classgroups" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for (NSDictionary* value in responseObject) {
            NSString *class = value[@"classname"];
            [self.classData addObject:class];
        }
        
        self.view.classSelect.delegate = self;
        [self.view addSubview:self.view.classSelect];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertError = [[UIAlertView alloc] initWithTitle:@"Oei, oei" message:@"We kunnen je klas nu niet ophalen. Sorry!" delegate:self cancelButtonTitle:@"Voor 1 keer is het goed" otherButtonTitles:nil];
        [alertError show];
    }];
}

- (void)loginButtonTapped:(id)sender
{
    /*
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
    */
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    NSString *listText = self.classData[row];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 44)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Avenir-Light" size:25];
    
    label.text = listText;
    return label;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView; {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component; {
    return self.classData.count;
}

-(NSString*) pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.classData objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
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
