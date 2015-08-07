//
//  MapItemData.h
//  BlocSpot
//
//  Created by McCay Barnes on 8/4/15.
//  Copyright (c) 2015 McCay Barnes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapItemData : NSObject <MKMapViewDelegate>

@property (strong, nonatomic) NSArray *mapItems;

-(void) returnMapItems:(void (^)(NSArray *mapItems))successBlock withString:(NSString *)text withRegion:(MKCoordinateRegion)region;

@end
