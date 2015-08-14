//
//  ListTableViewCell.m
//  BlocSpot
//
//  Created by McCay Barnes on 8/12/15.
//  Copyright (c) 2015 McCay Barnes. All rights reserved.
//

#import "ListTableViewCell.h"
#import "POI.h"

@implementation ListTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    //POI *newPOI = [[POI alloc] initWithEntity:POI insertIntoManagedObjectContext:context];
    
    self.placeName = [UILabel new];
    //self.placeName.text = POI.name;
    
    if (self.wasVisited) {
        self.visitImage = [UIImage imageNamed:@"visitImage.jpg"];
    }
    else {
        self.visitImage = [UIImage imageNamed:@"notVisitedImage.jpg"];
    }

    self.imageView.image = self.visitImage;
    [self.contentView addSubview:self.placeName];

}

@end
