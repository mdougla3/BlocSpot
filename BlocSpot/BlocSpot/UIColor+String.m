//
//  UIColor+String.m
//  BlocSpot
//
//  Created by McCay Barnes on 9/3/15.
//  Copyright (c) 2015 McCay Barnes. All rights reserved.
//

#import "UIColor+String.h"

@implementation UIColor (String)


-(NSString *)toString{
    
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    NSString *colorAsString = [NSString stringWithFormat:@"%f,%f,%f,%f", components[0], components[1], components[2], components[3]];
    return colorAsString;
}



+(UIColor *)fromString:(NSString *)string{
    
    NSArray *components = [string componentsSeparatedByString:@","];
    CGFloat r = [[components objectAtIndex:0] floatValue];
    CGFloat g = [[components objectAtIndex:1] floatValue];
    CGFloat b = [[components objectAtIndex:2] floatValue];
    CGFloat a = [[components objectAtIndex:3] floatValue];
    UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:a];
    
    return color;
}

+(UIColor *)randomColor{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    return color; 
}

@end
