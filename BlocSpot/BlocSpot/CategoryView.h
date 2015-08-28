//
//  CategoryView.h
//  BlocSpot
//
//  Created by McCay Barnes on 8/15/15.
//  Copyright (c) 2015 McCay Barnes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryView : UIView

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *locationLabel;
@property (nonatomic, weak) IBOutlet UITextView *poiTextView;
@property (assign) BOOL wasVisited;
@property (strong, nonatomic) UIBlurEffect *blurEffect;


@property (strong, nonatomic) UIButton *saveButton;
@property (strong, nonatomic) UIButton *dismissedButton;
@property (strong, nonatomic) UIButton *visitedButton;


@end
