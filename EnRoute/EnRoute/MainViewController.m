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
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.title = @"Super, klaar om Gent te verlichten?";
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"assignments" ofType:@"json"];
        
        NSData *jsonData = [NSData dataWithContentsOfFile:path];
        NSError *error = nil;
        
        NSArray *loadedData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        
        if( !error )
        {
            self.assignments = [NSMutableArray array];
            
            for(NSDictionary *dict in loadedData){
                Assignment *assignment = [AssignmentFactory createAssignmentWithDictionary:[dict objectForKey:@"assignment"]];
                [self.assignments addObject:assignment];
            }
            
        }
        else
        {
            UIAlertView *alertError = [[UIAlertView alloc] initWithTitle:@"Error" message:@"We couldn't load our awesome assignments!" delegate:self cancelButtonTitle:@"Ok 😢" otherButtonTitles:nil];
            [alertError show];
        }
    }
    return self;
}

- (void)loadView
{
    if( [[NSUserDefaults standardUserDefaults] boolForKey:@"isLoggedIn"] == NO )
    {
        self.loginVC = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
        self.loginVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:self.loginVC animated:NO completion:^{}];
    }
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    self.view = [[MainView alloc] initWithFrame:bounds andAssignments:self.assignments];
    
    self.view.scrollView.delegate = self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDefaultsDidChange:) name:NSUserDefaultsDidChangeNotification object:nil];
}

-(void) userDefaultsDidChange:(NSNotification*)notification
{
    if( [[NSUserDefaults standardUserDefaults] boolForKey:@"isLoggedIn"] == NO )
    {
        self.loginVC = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
        self.loginVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:self.loginVC animated:YES completion:^{}];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(brightnessDidChange:) name:UIScreenBrightnessDidChangeNotification object:nil];
    
    float light = [UIScreen mainScreen].brightness;
    
    [UIScreen mainScreen].brightness = light - 0.01;
}

-(void) brightnessDidChange:(NSNotification*)notification
{
    float light = [UIScreen mainScreen].brightness;
    self.darkPercentage = 255*light;
    
    NSLog(@"Brightness did change to %f", light*100);
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.view.pageControl.currentPage = page;
    
    Assignment *currentAssignment = [self.assignments objectAtIndex:page];
    
    self.title = currentAssignment.name;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.view.pageControl.currentPage = page;
    
    Assignment *currentAssignment = [self.assignments objectAtIndex:page];
    
    self.title = currentAssignment.name;
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
