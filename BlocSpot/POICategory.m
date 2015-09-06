//
//  POICategory.m
//  BlocSpot
//
//  Created by McCay Barnes on 8/13/15.
//  Copyright (c) 2015 McCay Barnes. All rights reserved.
//

#import "POICategory.h"
#import "POI.h"
#import "UIColor+String.h"


@implementation POICategory

@dynamic name;
@dynamic color;
@dynamic pois;

-(POICategory *)poiCategoryWithName:(NSString *)name {
    
    id delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    POICategory *poiCategory = [NSEntityDescription insertNewObjectForEntityForName:@"POICategory" inManagedObjectContext:context];
    poiCategory.name = name;
    poiCategory.color = [[UIColor randomColor] toString];
    
    NSError *error = nil;
    if (![context save:&error]) {
        // there is an error
        NSLog(@"%@", error);
    }
    
    return poiCategory;
}

@end
