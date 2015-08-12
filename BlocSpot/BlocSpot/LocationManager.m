//
//  LocationManager.m
//  BlocSpot
//
//  Created by McCay Barnes on 8/6/15.
//  Copyright (c) 2015 McCay Barnes. All rights reserved.
//

#import "LocationManager.h"


@implementation LocationManager


+ (instancetype) sharedLocationManager{
    static dispatch_once_t once;
    static id sharedLocationManager;
    dispatch_once(&once, ^{
        sharedLocationManager = [[self alloc] init];
    });
    return sharedLocationManager;
}

-(void) runLocationManager{
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    self.lastLocation = locations[0];
    [self.delegate locationManager:[LocationManager sharedLocationManager].locationManager didUpdateLocations:locations];
}


@end
