//
//  LocationView.m
//  LocationMap
//
//  Created by Niels Boey on 13/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import "LocationView.h"

@implementation LocationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
       RMMapboxSource *source = [[RMMapboxSource alloc] initWithMapID:@"ewoudsurmont.ih39bpe9"];
        self.mapView = [[RMMapView alloc] initWithFrame:frame andTilesource:source centerCoordinate:CLLocationCoordinate2DMake(51.0541, 3.7238) zoomLevel:6 maxZoomLevel:20 minZoomLevel:11 backgroundImage:nil];
        
        [self addSubview:self.mapView];
        self.mapView.delegate = self;
        [self addSubview:self.mapView];
    }
    return self;
}

-(void)updateWithLocations:(NSArray *)locations{
    for(Assignment *assignment in locations){
        RMPointAnnotation *annotation = [[RMPointAnnotation alloc] initWithMapView:self.mapView coordinate:assignment.coordinate andTitle:assignment.assignmentTitle];
        NSString *assignmentid = [NSString stringWithFormat:@"%d", assignment.identifier];
        annotation.userInfo = assignmentid;
        annotation.image = [UIImage imageNamed:assignmentid];
        [self.mapView addAnnotation:annotation];
    }
}

@end
