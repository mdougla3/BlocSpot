//
//  ColoredCategory.m
//  BlocSpot
//
//  Created by McCay Barnes on 8/15/15.
//  Copyright (c) 2015 McCay Barnes. All rights reserved.
//

#import "ColoredCategory.h"

@implementation ColoredCategory

-(void) createColors {
    
    UIColor *yellowColor = [UIColor yellowColor];
    UIColor *orangeColor = [UIColor orangeColor];
    UIColor *purpleColor = [UIColor purpleColor];
    UIColor *grayColor = [UIColor grayColor];
    UIColor *otherColor = [UIColor greenColor];
    
    self.categoryColors = [NSArray arrayWithObjects:yellowColor, orangeColor, purpleColor, grayColor, otherColor , nil];
    self.categoryNames = [@[@"Restaurants",@"Hotels",@"Places of Interest",@"Things To Do"] mutableCopy];;

}

@end
