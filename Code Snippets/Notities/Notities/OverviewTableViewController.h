//
//  OverviewTableViewController.h
//  Notities
//
//  Created by Niels Boey on 10/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "AddNoteViewController.h"
#import "UpdateNoteViewController.h"
#import "ColorCell.h"

@interface OverviewTableViewController : UITableViewController <AddNoteDelegate, UpdateNoteDelegate>

@property (nonatomic,strong) AddNoteViewController *addNoteVC;
@property (nonatomic,strong) UpdateNoteViewController *updateNoteVC;
@property (nonatomic,strong) NSMutableArray *notes;
@property (nonatomic,strong) NSString *noteID;

@end