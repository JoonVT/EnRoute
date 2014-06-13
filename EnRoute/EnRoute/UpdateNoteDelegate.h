//
//  UpdateNoteDelegate.h
//  Notities
//
//  Created by Niels Boey on 10/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UpdateNoteViewController;
#import "Note.h"

@protocol UpdateNoteDelegate <NSObject>

-(void)updateNoteViewController:(UpdateNoteViewController *)viewController didUpdateNote:(Note *)note atIndex:(NSInteger)index;

@end