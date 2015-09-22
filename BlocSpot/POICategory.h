//
//  POICategory.h
//  BlocSpot
//
//  Created by McCay Barnes on 9/8/15.
//  Copyright (c) 2015 McCay Barnes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "POI.h"

@class POI;

@interface POICategory : POI

@property (nonatomic, retain) NSString * categoryColor;
@property (nonatomic, retain) NSString * categoryName;
@property (nonatomic, retain) POI *pois;

@end
