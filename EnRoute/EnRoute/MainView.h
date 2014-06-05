//
//  MainView.h
//  EnRoute
//
//  Created by Joon Van Thuyne on 28/05/14.
//  Copyright (c) 2014 JoonVT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "AssignmentView.h"
#import "Assignment.h"


@interface MainView : UIView

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic,strong) AssignmentView *assignmentView;

- (id)initWithFrame:(CGRect)frame andAssignments:(NSArray *)assignments;

@end
