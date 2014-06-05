//
//  AssignmentFactory.m
//  En Route
//
//  Created by Joon Van Thuyne on 05/06/14.
//  Copyright (c) 2014 JoonVT. All rights reserved.
//

#import "AssignmentFactory.h"

@implementation AssignmentFactory

+ (Assignment *)createAssignmentWithDictionary:(NSDictionary *)dictionary
{
    Assignment *assignment = [[Assignment alloc] init];
    
    assignment.identifier = [[dictionary objectForKey:@"id"] intValue];
    assignment.name = [dictionary objectForKey:@"name"];
    assignment.explanation = [dictionary objectForKey:@"explanation"];
    assignment.imgpath = [NSString stringWithFormat:@"%@.png", [dictionary objectForKey:@"id"]];
    
    return assignment;
}


@end
