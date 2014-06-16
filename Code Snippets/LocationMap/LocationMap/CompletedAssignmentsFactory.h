//
//  AssignmentsFactory.h
//  LocationMap
//
//  Created by Niels Boey on 13/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CompletedAssignment.h"

@interface CompletedAssignmentsFactory : NSObject

+(CompletedAssignment *)createCompletedAssignmentWithDictionary:(NSDictionary *)dictionary;

@end
