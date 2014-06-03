//
//  SelectClassViewController.h
//  API-selectClass
//
//  Created by Niels Boey on 03/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import "SelectClassView.h"

@interface SelectClassViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, retain)  NSMutableArray *pickerData;
@property (nonatomic,strong) SelectClassView *view;

@end
