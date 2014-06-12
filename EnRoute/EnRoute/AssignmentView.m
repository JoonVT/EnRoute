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
            
            NSAttributedString *txtLogout = [[NSAttributedString alloc] initWithString:@"KIES EEN ANDERE GROUP" attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Hallosans-Black" size:22], NSForegroundColorAttributeName : [UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1], NSKernAttributeName : @(1.0f)}];
            
            NSAttributedString *txtExplanation = [[NSAttributedString alloc] initWithString:@"Welkom bij 'Gent Verlicht', waar we Gent op een artistieke manier zullen ontdekken samen met Led. Dit aan de hand van enkele toffe opdrachten." attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Hallosans" size:20], NSForegroundColorAttributeName : [UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1], NSKernAttributeName : @(0.5f)}];
            
            self.lblExplanation = [[UILabel alloc] initWithFrame:CGRectMake(15, 70, frame.size.width-30, 100)];
            self.lblExplanation.attributedText = txtExplanation;
            self.lblExplanation.numberOfLines = 0;
            
            self.btnNext = [UIButton buttonWithType:UIButtonTypeSystem];
            self.btnNext.frame = CGRectMake(frame.size.width - 50, (frame.size.height/2)-26, 30, 52);
            [self.btnNext setBackgroundImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
            
            UIButton *logout = [UIButton buttonWithType:UIButtonTypeCustom];
            logout.frame = CGRectMake(0, frame.size.height - 45, frame.size.width, 45);
            [logout setBackgroundImage:[UIImage imageNamed:@"button_grey"] forState:UIControlStateNormal];
            [logout setBackgroundImage:[UIImage imageNamed:@"button_pressed"] forState:UIControlStateHighlighted];
            [logout setAttributedTitle:txtLogout forState:UIControlStateNormal];
            [logout addTarget:self action:@selector(logoutTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:self.lblExplanation];
            [self addSubview:self.btnNext];
            [self addSubview:logout];
        }
        else if (assignment.identifier == 9999)
        {
            RMMapboxSource *source = [[RMMapboxSource alloc]initWithMapID:@"joonvt.ifmcehng"];
            
            self.mapView = [[RMMapView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) andTilesource:source centerCoordinate:CLLocationCoordinate2DMake(51.053, 3.724) zoomLevel:15 maxZoomLevel:20 minZoomLevel:10 backgroundImage:nil];
            
            //RMPointAnnotation *annotion = [[RMPointAnnotation alloc] initWithMapView:self.mapView coordinate:self.mapView.centerCoordinate andTitle:@"DevineHQ!"];
            
            //[self.mapView addAnnotation:annotion];
            
            self.btnPrevious = [UIButton buttonWithType:UIButtonTypeSystem];
            self.btnPrevious.frame = CGRectMake(20, (frame.size.height/2)-26, 30, 52);
            [self.btnPrevious setBackgroundImage:[UIImage imageNamed:@"previous"] forState:UIControlStateNormal];
            
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
            
            UIImageView *lamp = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"lamp%i",assignment.identifier]]];
            lamp.center = CGPointMake(frame.size.width/2, frame.size.height/2);
            
            [self addSubview:background];
            [self addSubview:self.btnPrevious];
            [self addSubview:self.btnNext];
            [self addSubview:btnLight];
            [self addSubview:lamp];
            
            [self createMotionEffect];
            
            [background addMotionEffect:self.motion];
        }
    }
    return self;
}

- (void)logoutTapped:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLoggedIn"];
    [[NSUserDefaults standardUserDefaults] setObject:@{} forKey:@"group"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)lampTapped:(id)sender
{
    NSDictionary *assignment = @{
                                 @"id": [NSString stringWithFormat:@"%i", self.assignment.identifier],
                                 @"name": self.assignment.name,
                                 @"explanation": self.assignment.explanation,
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
