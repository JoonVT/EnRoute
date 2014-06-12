//
//  Note.m
//  Notities
//
//  Created by Niels Boey on 10/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import "Note.h"

@implementation Note

-(id)initWithNote:(NSString *)note andNoteID:(NSString *)noteid {
    self.note = note;
    self.noteid = noteid;
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.note forKey:@"note"];
    [coder encodeObject:self.noteid forKey:@"noteid"];
}

-(instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    
    if(self){
        self.note = [decoder decodeObjectForKey:@"note"];
        self.noteid = [decoder decodeObjectForKey:@"noteid"];
    }
    
    return self;
}

@end
