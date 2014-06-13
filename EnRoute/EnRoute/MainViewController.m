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
    
    self.bounds = [[UIScreen mainScreen] bounds];
    
    self.view = [[MainView alloc] initWithFrame:self.bounds andAssignments:self.assignments];
    
    self.view.scrollView.delegate = self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDefaultsDidChange:) name:NSUserDefaultsDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lampTapped:) name:@"lampTapped" object:nil];
}

-(void) userDefaultsDidChange:(NSNotification*)notification
{
    if( [[NSUserDefaults standardUserDefaults] boolForKey:@"isLoggedIn"] == NO )
    {
        self.loginVC = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
        self.loginVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:self.loginVC animated:YES completion:^{}];
    }
}

-(void) lampTapped:(NSNotification*)notification
{
    Assignment *assignment = [AssignmentFactory createAssignmentWithDictionary:[notification userInfo]];
    
    AssignmentToolsViewController *assignmentToolsVC = [[AssignmentToolsViewController alloc] initWithAssignment:assignment andFrame:self.bounds];
    [self presentViewController:assignmentToolsVC animated:YES completion:^{}];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    if (page == 0) {
        self.view.pageControl.hidden = YES;
    } else {
        self.view.pageControl.hidden = NO;
        self.view.pageControl.currentPage = page;
    }
    
    Assignment *currentAssignment = [self.assignments objectAtIndex:page];
    
    self.title = currentAssignment.name;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    if (page == 0) {
        self.view.pageControl.hidden = YES;
    } else {
        self.view.pageControl.hidden = NO;
        self.view.pageControl.currentPage = page;
    }
    
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
