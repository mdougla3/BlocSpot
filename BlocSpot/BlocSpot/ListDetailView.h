//
//  ListDetailView.h
//  BlocSpot
//
//  Created by McCay Barnes on 8/26/15.
//  Copyright (c) 2015 McCay Barnes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListDetailView : UIView

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *locationLabel;
@property (nonatomic, weak) IBOutlet UITextView *poiTextView;


@end
