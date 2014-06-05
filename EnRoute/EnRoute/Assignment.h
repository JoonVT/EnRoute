//
//  Assignment.h
//  En Route
//
//  Created by Joon Van Thuyne on 05/06/14.
//  Copyright (c) 2014 JoonVT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Assignment : NSObject

@property (nonatomic) int identifier;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *explanation;
@property (nonatomic,strong) NSString *imgpath;

@end
