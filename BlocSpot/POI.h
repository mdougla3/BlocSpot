//
//  POI.h
//  BlocSpot
//
//  Created by McCay Barnes on 9/6/15.
//  Copyright (c) 2015 McCay Barnes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface POI : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * placeDescription;
@property (nonatomic, retain) NSNumber * visited;
@property (nonatomic, retain) NSString * categoryColor;

@end
