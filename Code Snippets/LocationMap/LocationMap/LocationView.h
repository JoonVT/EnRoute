//
//  LocationView.h
//  LocationMap
//
//  Created by Niels Boey on 13/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RMMarker.h>
#import <RMMapView.h>
#import <RMMapboxSource.h>
#import <RMPointAnnotation.h>
#import "CompletedAssignment.h"

@interface LocationView : UIView <RMMapViewDelegate>

@property (nonatomic,strong) RMMapView *mapView;

-(void)updateWithLocations:(NSArray *)locations;

@end
