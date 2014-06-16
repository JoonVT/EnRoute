//
//  Assignment.h
//  LocationMap
//
//  Created by Niels Boey on 13/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface CompletedAssignment : NSObject <MKAnnotation>

@property (nonatomic) int identifier;
@property (nonatomic,strong) NSNumber *mediaid;
@property (nonatomic,strong) NSString *assignmentTitle;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@end
