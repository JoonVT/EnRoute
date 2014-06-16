//
//  AssignmentToolsViewController.h
//  En Route
//
//  Created by Joon Van Thuyne on 10/06/14.
//  Copyright (c) 2014 JoonVT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "AssignmentToolsView.h"
#import "Assignment.h"
#import "ConnectionViewController.h"
#import "LookViewController.h"
#import "BokehViewController.h"
#import "NotesTableViewController.h"
#import "RecorderViewController.h"
#import "CameraViewController.h"

@interface AssignmentToolsViewController : UIViewController

@property (strong, nonatomic) AssignmentToolsView *view;

@property (strong, nonatomic) Assignment *assignment;

- (id)initWithAssignment:(Assignment *)assignment andFrame:(CGRect)frame;

@end
