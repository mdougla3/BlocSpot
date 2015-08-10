//
//  LocationManager.h
//  BlocSpot
//
//  Created by McCay Barnes on 8/6/15.
//  Copyright (c) 2015 McCay Barnes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class LocationManager;

@protocol LocationManagerDelegate <NSObject>

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations;

@end

@interface LocationManager : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, weak) id <LocationManagerDelegate> delegate;

+(instancetype) sharedLocationManager; 
-(void) runLocationManager;

@end
