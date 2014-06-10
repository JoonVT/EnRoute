//
//  OverviewViewController.h
//  API-test
//
//  Created by Niels Boey on 10/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OverviewView.h"
#import "UploadViewController.h"

@interface OverviewViewController : UIViewController

@property (nonatomic,strong) OverviewView *view;
@property (nonatomic,strong) UploadViewController *uploadVC;

@end
