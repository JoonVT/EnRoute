//
//  AssignmentView.m
//  En Route
//
//  Created by Joon Van Thuyne on 05/06/14.
//  Copyright (c) 2014 JoonVT. All rights reserved.
//

#import "AssignmentView.h"

@implementation AssignmentView

- (id)initWithFrame:(CGRect)frame andAssignment:(Assignment *)assignment
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.assignment = assignment;
        
        if (assignment.identifier == 0)
        {
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"explanation"]];
            
            NSDictionary *group = [[NSUserDefaults standardUserDefaults] objectForKey:@"group"];
            
            NSAttributedString *txtTitle = [[NSAttributedString alloc] initWithString:[group objectForKey:@"groupname"] attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Hallosans-Black" size:25], NSForegroundColorAttributeName : [UIColor colorWithRed:0.58 green:0.86 blue:0.8 alpha:1], NSKernAttributeName : @(1.0f)}];
            
            NSAttributedString *txtExplanation = [[NSAttributedString alloc] initWithString:assignment.explanation1 attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Hallosans" size:20], NSForegroundColorAttributeName : [UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1], NSKernAttributeName : @(0.5f)}];
            
            NSAttributedString *txtLogout = [[NSAttributedString alloc] initWithString:@"KIES EEN ANDERE GROEP" attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Hallosans-Black" size:22], NSForegroundColorAttributeName : [UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1], NSKernAttributeName : @(1.0f)}];
            
            UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 85, self.frame.size.width - 30, 25)];
            lblTitle.attributedText = txtTitle;
            lblTitle.textAlignment = NSTextAlignmentCenter;
            
            UILabel *lblExplanation = [[UILabel alloc] initWithFrame:CGRectMake(15, 115, frame.size.width-30, 100)];
            lblExplanation.attributedText = txtExplanation;
            lblExplanation.numberOfLines = 0;
            
            self.btnNext = [UIButton buttonWithType:UIButtonTypeSystem];
            self.btnNext.frame = CGRectMake(frame.size.width - 50, (frame.size.height/2)-26, 30, 52);
            [self.btnNext setBackgroundImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
            
            UIButton *logout = [UIButton buttonWithType:UIButtonTypeSystem];
            logout.frame = CGRectMake(0, frame.size.height - 45, frame.size.width, 45);
            [logout setBackgroundImage:[UIImage imageNamed:@"button_grey"] forState:UIControlStateNormal];
            [logout setAttributedTitle:txtLogout forState:UIControlStateNormal];
            [logout addTarget:self action:@selector(logoutTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:lblTitle];
            [self addSubview:lblExplanation];
            [self addSubview:self.btnNext];
            [self addSubview:logout];
        }
        else if (assignment.identifier == 9999)
        {
            RMMapboxSource *source = [[RMMapboxSource alloc]initWithMapID:@"ewoudsurmont.ih39bpe9"];
            
            self.mapView = [[RMMapView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) andTilesource:source centerCoordinate:CLLocationCoordinate2DMake(51.047, 3.727) zoomLevel:17 maxZoomLevel:20 minZoomLevel:10 backgroundImage:nil];
            self.mapView.delegate = self;
            self.mapView.showsUserLocation = YES;
            self.mapView.tintColor = [UIColor colorWithRed:0.33 green:0.79 blue:0.63 alpha:1];
            
            self.btnPrevious = [UIButton buttonWithType:UIButtonTypeSystem];
            self.btnPrevious.frame = CGRectMake(20, (frame.size.height/2)-26, 30, 52);
            [self.btnPrevious setBackgroundImage:[UIImage imageNamed:@"previous"] forState:UIControlStateNormal];
            
            [self loadCompletedAssignments];
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadCompletedAssignments) name:@"reloadMap" object:nil];
            
            [self addSubview:self.mapView];
            [self addSubview:self.btnPrevious];
        }
        else
        {
            UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"streets%i",assignment.panelID]]];
            
            self.btnPrevious = [UIButton buttonWithType:UIButtonTypeSystem];
            self.btnPrevious.frame = CGRectMake(20, (frame.size.height/2)-26, 30, 52);
            [self.btnPrevious setBackgroundImage:[UIImage imageNamed:@"previous"] forState:UIControlStateNormal];
            
            self.btnNext = [UIButton buttonWithType:UIButtonTypeSystem];
            self.btnNext.frame = CGRectMake(frame.size.width - 50, (frame.size.height/2)-26, 30, 52);
            [self.btnNext setBackgroundImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
            
            UIButton *btnLight = [UIButton buttonWithType:UIButtonTypeCustom];
            btnLight.frame = CGRectMake(0, 0, 195, 195);
            btnLight.center = CGPointMake(frame.size.width/2, frame.size.height/2);
            [btnLight setImage:[UIImage imageNamed:@"light"] forState:UIControlStateNormal];
            [btnLight addTarget:self action:@selector(lampTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            UIImageView *lamp = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"lamp%i",assignment.panelID]]];
            lamp.center = CGPointMake(frame.size.width/2, frame.size.height/2);
            
            self.popup = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"explanation_popup"]];
            self.popup.center = CGPointMake(frame.size.width/2, frame.origin.y-90);
            
            [self addSubview:background];
            [self addSubview:self.btnPrevious];
            [self addSubview:self.btnNext];
            [self addSubview:btnLight];
            [self addSubview:lamp];
            [self addSubview:self.popup];
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showPopup) name:@"showPopup" object:nil];
            
            [self createMotionEffect];
            
            [background addMotionEffect:self.motion];
        }
    }
    return self;
}

- (void)showPopup
{
    NSLog(@"BINNEEEEEENNN");
    
    [UIView animateWithDuration:.75 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.popup.center = CGPointMake(self.frame.size.width/2, self.frame.origin.y+120);
    } completion:^(BOOL finished)
    {
        [UIView animateWithDuration:.75 delay:10 usingSpringWithDamping:.5 initialSpringVelocity:.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.popup.center = CGPointMake(self.frame.size.width/2, self.frame.origin.y-90);
        } completion:^(BOOL finished)
         {
             [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"didShowPopup"];
         }];
    }];
}

- (void)logoutTapped:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLoggedIn"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"didShowPopup"];
    [[NSUserDefaults standardUserDefaults] setObject:@{} forKey:@"group"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)lampTapped:(id)sender
{
    NSDictionary *assignment = @{
                                 @"id": [NSString stringWithFormat:@"%i", self.assignment.identifier],
                                 @"name": self.assignment.name,
                                 @"explanation1": self.assignment.explanation1,
                                 @"explanation2": self.assignment.explanation2,
                                 @"explanation3": self.assignment.explanation3,
                                 @"color_top": self.assignment.topColor,
                                 @"color_bottom": self.assignment.bottomColor,
                                 @"panel_id": [NSString stringWithFormat:@"%i", self.assignment.panelID]
                                 };
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"lampTapped" object:self userInfo:assignment];
}

- (void)createMotionEffect
{
    float quantity = 10;
    
    UIInterpolatingMotionEffect *xAxis = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    xAxis.minimumRelativeValue = [NSNumber numberWithFloat:-quantity];
    xAxis.maximumRelativeValue = [NSNumber numberWithFloat:quantity];
    
    UIInterpolatingMotionEffect *yAxis = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    yAxis.minimumRelativeValue = [NSNumber numberWithFloat:-quantity];
    yAxis.maximumRelativeValue = [NSNumber numberWithFloat:quantity];
    
    self.motion = [[UIMotionEffectGroup alloc] init];
    self.motion.motionEffects = @[xAxis,yAxis];
}

- (void)loadCompletedAssignments
{
    self.completedAssignments = nil;
    
    NSDictionary *group = [[NSUserDefaults standardUserDefaults] objectForKey:@"group"];
    
    NSString *onlineURL = [NSString stringWithFormat:@"http://student.howest.be/niels.boey/20132014/MAIV/ENROUTE/api/files/%@", [group objectForKey:@"id"]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:onlineURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.completedAssignments = responseObject;
        [self addIcons];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)addIcons
{
    self.locations = [NSMutableArray array];
    
    for(NSDictionary *dict in self.completedAssignments){
        CompletedAssignment *assignment = [CompletedAssignmentsFactory createCompletedAssignmentWithDictionary:dict];
        [self.locations addObject:assignment];
    }
    
    [self updateWithLocations:self.locations];
    
}

- (void)updateWithLocations:(NSArray *)locations
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    for(CompletedAssignment *assignment in locations)
    {
        RMPointAnnotation *annotation = [[RMPointAnnotation alloc] initWithMapView:self.mapView coordinate:assignment.coordinate andTitle:assignment.assignmentTitle];
        NSString *assignmentid = [NSString stringWithFormat:@"%d", assignment.identifier];
        annotation.userInfo = assignmentid;
        annotation.image = [UIImage imageNamed:[NSString stringWithFormat:@"lamp%d", assignment.identifier]];
        [self.mapView addAnnotation:annotation];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
