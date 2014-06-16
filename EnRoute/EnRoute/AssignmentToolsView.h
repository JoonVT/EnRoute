//
//  AssignmentToolsView.h
//  En Route
//
//  Created by Joon Van Thuyne on 10/06/14.
//  Copyright (c) 2014 JoonVT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Assignment.h"

@interface AssignmentToolsView : UIView

@property (strong, nonatomic) UILabel *lblExplanation1;
@property (strong, nonatomic) UILabel *lblExplanation2;
@property (strong, nonatomic) UILabel *lblExplanation3;

@property (strong, nonatomic) UIButton *btnShadowMovie;
@property (strong, nonatomic) UIButton *btnMultipeer;

@property (strong, nonatomic) UIButton *btnNotes;
@property (strong, nonatomic) UIButton *btnFlash;
@property (strong, nonatomic) UIButton *btnMicrophone;
@property (strong, nonatomic) UIButton *btnCamera;

- (id)initWithAssignment:(Assignment *)assignment andFrame:(CGRect)frame;

@end
