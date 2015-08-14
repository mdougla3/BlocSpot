//
//  POICategory.h
//  BlocSpot
//
//  Created by McCay Barnes on 8/13/15.
//  Copyright (c) 2015 McCay Barnes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class POI;

@interface POICategory : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) NSSet *pois;
@end

@interface POICategory (CoreDataGeneratedAccessors)

- (void)addPoisObject:(POI *)value;
- (void)removePoisObject:(POI *)value;
- (void)addPois:(NSSet *)values;
- (void)removePois:(NSSet *)values;

@end
