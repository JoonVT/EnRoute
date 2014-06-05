//
//  AssignmentFactory.h
//  En Route
//
//  Created by Joon Van Thuyne on 05/06/14.
//  Copyright (c) 2014 JoonVT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Assignment.h"

@interface AssignmentFactory : NSObject

+ (Assignment *)createAssignmentWithDictionary:(NSDictionary *)dictionary;

@end
