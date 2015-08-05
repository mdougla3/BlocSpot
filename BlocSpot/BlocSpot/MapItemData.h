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
@property (weak, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) NSString *text;

-(void) returnMapItems:(void (^)(NSArray *mapItems, NSString *text))successBlock;

@end
