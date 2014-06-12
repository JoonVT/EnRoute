//
//  AddNoteDelegate.h
//  Notities
//
//  Created by Niels Boey on 10/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AddNoteViewController;
#import "Note.h"

@protocol AddNoteDelegate <NSObject>

@required

-(void)addNoteViewController:(AddNoteViewController *)viewController didSaveNote:(Note *)note;

@end