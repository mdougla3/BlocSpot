//
//  CategoryView.m
//  BlocSpot
//
//  Created by McCay Barnes on 8/15/15.
//  Copyright (c) 2015 McCay Barnes. All rights reserved.
//

#import "CategoryView.h"

@implementation CategoryView


-(instancetype)initWithFrame:(CGRect)frame {
    
    self.titleLabel.text = @"Placeholder";
    self.locationLabel.text = @"New York Express";
    self.poiTextView.text = @"Lorem ipsum, Lorem ipsum, Lorem ipsumLorem ipsum, Lorem ipsumLorem ipsumvLorem ipsum";
    
    self.saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.saveButton.backgroundColor = [UIColor blueColor];
    [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];

    
    self.dismissedButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.dismissedButton.backgroundColor = [UIColor blackColor];
    [self.dismissedButton setTitle:@"Exit" forState:UIControlStateNormal];
    
    self.visitedButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.visitedButton.backgroundColor = [UIColor orangeColor];
    [self.visitedButton setTitle:@"Visited" forState:UIControlStateNormal];
    
    self.blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:self.blurEffect];

    
    [self addSubview:self.dismissedButton];
    [self addSubview:self.saveButton];
    [self addSubview:self.visitedButton];

    return self;
}

-(void)saveButtonPressed:(id)sender {
    self.alpha = 0.0;
}

-(void)dismissButtonPressed:(id)sender {
    self.alpha = 0.0;
   
}

-(void)visitedButtonPressed:(id)sender {
    NSLog(@"Add in code here later");
}

@end
