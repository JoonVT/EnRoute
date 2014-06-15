//
//  AssignmentsFactory.h
//  LocationMap
//
//  Created by Niels Boey on 13/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Assignment.h"

@interface AssignmentsFactory : NSObject

+(Assignment *)createAssignmentWithDictionary:(NSDictionary *)dictionary;

@end
