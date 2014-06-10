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
#import "Assignment.h"

@interface AssignmentView : UIView

@property (strong, nonatomic) Assignment *assignment;

@property (strong, nonatomic) UILabel *lblExplanation;

@property (strong, nonatomic) UIButton *btnPrevious;
@property (strong, nonatomic) UIButton *btnNext;

@property (strong, nonatomic) RMMapView *mapView;

@property (strong, nonatomic) UIMotionEffectGroup *motion;

- (id)initWithFrame:(CGRect)frame andAssignment:(Assignment *)assignment;

@end