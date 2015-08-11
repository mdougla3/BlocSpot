//
//  MapItemData.m
//  BlocSpot
//
//  Created by McCay Barnes on 8/4/15.
//  Copyright (c) 2015 McCay Barnes. All rights reserved.
//

#import "MapItemData.h"

@implementation MapItemData


-(void) returnMapItems:(void (^)(NSArray *mapItems))successBlock withString:(NSString *)text withRegion:(MKCoordinateRegion)region {
    
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = text;
    //Region should be set by userLocation or search area on map
    //request.region = region;
    
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        
        if (successBlock) {
            successBlock(response.mapItems);
        }
    }];
    
}

@end
