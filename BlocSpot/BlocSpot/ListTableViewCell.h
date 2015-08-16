//
//  ListTableViewCell.h
//  BlocSpot
//
//  Created by McCay Barnes on 8/12/15.
//  Copyright (c) 2015 McCay Barnes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImage *visitImage;
@property (strong, nonatomic) UILabel *placeName;
@property (nonatomic) BOOL wasVisited;


@end
