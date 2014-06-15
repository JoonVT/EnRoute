//
//  AssignmentsFactory.m
//  LocationMap
//
//  Created by Niels Boey on 13/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import "AssignmentsFactory.h"

@implementation AssignmentsFactory

+(Assignment *)createAssignmentWithDictionary:(NSDictionary *)dictionary {
    Assignment *assignment = [[Assignment alloc] init];
    
    assignment.identifier = [[dictionary objectForKey:@"id"] intValue];
    assignment.mediaid = [dictionary objectForKey:@"mediaid"];
    assignment.assignmentTitle = [dictionary objectForKey:@"title"];
    
    float latitude = [[dictionary objectForKey:@"latitude"] floatValue];
    float longitude = [[dictionary objectForKey:@"longitude"] floatValue];
    
    assignment.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    
    return assignment;
}

@end
