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
    assignment.explanation1 = [dictionary objectForKey:@"explanation1"];
    assignment.explanation2 = [dictionary objectForKey:@"explanation2"];
    assignment.explanation3 = [dictionary objectForKey:@"explanation3"];
    assignment.topColor = [dictionary objectForKey:@"color_top"];
    assignment.bottomColor = [dictionary objectForKey:@"color_bottom"];
    assignment.panelID = [[dictionary objectForKey:@"panel_id"] intValue];
    
    return assignment;
}


@end
