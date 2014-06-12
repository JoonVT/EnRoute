//
//  Note.h
//  Notities
//
//  Created by Niels Boey on 10/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject

@property (nonatomic, strong) NSString *note;
@property (nonatomic,strong) NSString *noteid;

-(id)initWithNote:(NSString *)note andNoteID:(NSString*)noteid;

@end
