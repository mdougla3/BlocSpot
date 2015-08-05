//
//  MapItemData.m
//  BlocSpot
//
//  Created by McCay Barnes on 8/4/15.
//  Copyright (c) 2015 McCay Barnes. All rights reserved.
//

#import "MapItemData.h"

@implementation MapItemData


-(void) returnMapItems:(void (^)(NSArray *mapItems))successBlock {
    
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    self.mapView.delegate = self;
    // Change from hardcode to user input
    request.naturalLanguageQuery = @"restaurants";
    //Region should be set by userLocation or search area on map
    request.region = self.mapView.region;
    
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        self.mapItems = response.mapItems;
        
        if (successBlock) {
            successBlock(self.mapItems);
        }
    }];
    
}

@end
