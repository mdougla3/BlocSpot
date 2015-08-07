//
//  LocationManager.h
//  BlocSpot
//
//  Created by McCay Barnes on 8/6/15.
//  Copyright (c) 2015 McCay Barnes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface LocationManager : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

+(instancetype) sharedLocationManager; 
-(void) runLocationManager;

@end
