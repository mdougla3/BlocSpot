//
//  UIColor+String.h
//  BlocSpot
//
//  Created by McCay Barnes on 9/3/15.
//  Copyright (c) 2015 McCay Barnes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (String)

-(NSString *)toString;
+(UIColor *)fromString:(NSString *)string;
+(UIColor *)randomColor;



@end
