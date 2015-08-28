//
//  ColoredCategory.h
//  BlocSpot
//
//  Created by McCay Barnes on 8/15/15.
//  Copyright (c) 2015 McCay Barnes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ColoredCategory : NSObject

@property (strong, nonatomic) NSArray *categoryColors;
@property (strong, nonatomic) NSString *categoryName;
@property (strong, nonatomic) NSMutableArray *categoryNames;

-(void) createColors;

@end
