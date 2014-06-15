//
//  LocationViewController.m
//  LocationMap
//
//  Created by Niels Boey on 13/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()

@end

@implementation LocationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self loadAssignments];
#warning inladen wanneer de map view ingeladen wordt
    }
    return self;
}

- (void)loadView {
    
    CGRect sizeofScreen = [[UIScreen mainScreen] bounds];
    self.view = [[LocationView alloc] initWithFrame:sizeofScreen];
}

-(void)loadAssignments {
#warning voeg na "/files/" de groupid toe
    NSString *onlineURL = [NSString stringWithFormat:@"http://student.howest.be/niels.boey/20132014/MAIV/ENROUTE/api/files/1"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:onlineURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.assignments = responseObject;
        [self addIcons];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)addIcons {

        self.locations = [NSMutableArray array];
        
        for(NSDictionary *dict in self.assignments){
            Assignment *assignment = [AssignmentsFactory createAssignmentWithDictionary:dict];
            [self.locations addObject:assignment];
        }
    
        [self.view updateWithLocations:self.locations];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
