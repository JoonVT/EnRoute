//
//  OverviewViewController.m
//  API-test
//
//  Created by Niels Boey on 10/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import "OverviewViewController.h"

@interface OverviewViewController ()

@end

@implementation OverviewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Overview";
    }
    return self;
}

- (void)loadView {
    
    CGRect sizeofScreen = [[UIScreen mainScreen] bounds];
    self.view = [[OverviewView alloc] initWithFrame:sizeofScreen];
    
}

-(void)camera {
    
  //  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveTestNotification:) name:@"TestNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadNotification:) name:@"uploadfile" object:nil];

    self.uploadVC = [[UploadViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:self.uploadVC animated:YES];
}

- (void)uploadNotification:(NSNotification *)notification {

    [self.navigationController popViewControllerAnimated:self.uploadVC];
    NSURL *fileurl = [notification.userInfo objectForKey:@"mediaurl"];
    [self upload:fileurl];
}

-(void)upload:(NSURL *)fileurl {
    NSLog(@"Uploading");
    
    self.view.label.text = @"Uploading...";
    
    NSString *onlineURL = @"http://student.howest.be/niels.boey/20132014/MAIV/ENROUTE/api/files";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
#warning update parameters met GroupID, ClassID en MediaID
    NSDictionary *parameters = @{@"groupid": @"1", @"classid": @"1", @"mediaid": @"1"};
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:onlineURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:fileurl name:@"file" error:nil];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
#warning bij return true = Upload gelukt / false = mislukt
        self.view.label.text = @"Geupload";
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error debugDescription]);
        NSLog(@"Error: %@", [error localizedDescription]);
        self.view.label.text = @"upload mislukt";
    }];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.view.pictureButton addTarget:self action:@selector(camera) forControlEvents:UIControlEventTouchUpInside];
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
