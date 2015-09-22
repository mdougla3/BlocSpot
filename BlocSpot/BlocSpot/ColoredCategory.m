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
    UIColor *redColor = [UIColor redColor];
    UIColor *cyanColor = [UIColor cyanColor];
    UIColor *magentaColor = [UIColor magentaColor];
    UIColor *brownColor = [UIColor brownColor];
    UIColor *lightGrayColor = [UIColor lightGrayColor];
    UIColor *otherColor = [UIColor greenColor];
    
    self.categoryColors = [NSArray arrayWithObjects:yellowColor, orangeColor, purpleColor, redColor, cyanColor, magentaColor, brownColor, lightGrayColor, otherColor , nil];
    self.categoryNames = [[NSMutableArray alloc] init];

}

@end
