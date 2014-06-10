//
//  AssignmentToolsViewController.h
//  En Route
//
//  Created by Joon Van Thuyne on 10/06/14.
//  Copyright (c) 2014 JoonVT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssignmentToolsView.h"
#import "Assignment.h"

@interface AssignmentToolsViewController : UIViewController

@property (strong, nonatomic) AssignmentToolsView *view;

@property (strong, nonatomic) Assignment *assignment;

- (id)initWithAssignment:(Assignment *)assignment;

@end
