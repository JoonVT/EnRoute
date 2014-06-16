//
//  AssignmentView.h
//  En Route
//
//  Created by Joon Van Thuyne on 05/06/14.
//  Copyright (c) 2014 JoonVT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <RMMapView.h>
#import <RMMapboxSource.h>
#import <RMPointAnnotation.h>
#import <AFNetworking/AFNetworking.h>
#import "Assignment.h"
#import "CompletedAssignmentsFactory.h"
#import "CompletedAssignment.h"

@interface AssignmentView : UIView <RMMapViewDelegate>

@property (strong, nonatomic) Assignment *assignment;
@property (strong, nonatomic) UIButton *btnPrevious;
@property (strong, nonatomic) UIButton *btnNext;
@property (strong, nonatomic) RMMapView *mapView;
@property (strong, nonatomic) UIMotionEffectGroup *motion;
@property (nonatomic,strong) NSDictionary *completedAssignments;
@property (nonatomic,strong) NSMutableArray *locations;
@property (strong, nonatomic) UIImageView *popup;

- (id)initWithFrame:(CGRect)frame andAssignment:(Assignment *)assignment;

-(void)updateWithLocations:(NSArray *)locations;

@end