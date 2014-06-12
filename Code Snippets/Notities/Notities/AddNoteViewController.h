//
//  AddNoteViewController.h
//  Notities
//
//  Created by Niels Boey on 10/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddNoteDelegate.h"
#import "AddNoteView.h"
#import "Note.h"

@interface AddNoteViewController : UIViewController

@property (nonatomic,weak) id<AddNoteDelegate> delegate;
@property (nonatomic,strong) AddNoteView *view;

@end