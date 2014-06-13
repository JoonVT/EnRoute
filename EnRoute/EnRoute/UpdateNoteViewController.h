//
//  UpdateNoteViewController.h
//  Notities
//
//  Created by Niels Boey on 10/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UpdateNoteView.h"
#import "UpdateNoteDelegate.h"
#import "Note.h"

@interface UpdateNoteViewController : UIViewController

@property (nonatomic,weak) id<UpdateNoteDelegate> delegate;
@property (nonatomic,strong) UpdateNoteView *view;
@property (nonatomic,strong) NSString *note;
@property (nonatomic,strong) NSString *noteid;
@property (nonatomic) NSInteger index;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil note:(NSString *)note noteid:(NSString *)noteid andIndex:(NSInteger)index;

@end