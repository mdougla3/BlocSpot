////
////  CustomAnnotation.m
////  BlocSpot
////
////  Created by McCay Barnes on 8/4/15.
////  Copyright (c) 2015 McCay Barnes. All rights reserved.
////
//
//#import "CustomAnnotation.h"
//
//@implementation CustomAnnotation
//
//-(id)initWithTitle:(NSString *)newTitle Location:(CLLocationCoordinate2D)location {
//    self = [super init];
//    
//    if (self) {
//        _title = newTitle;
//        _coordinate = location;
//    }
//    return self;
//}
//
//-(MKAnnotationView *)annotationView {
//    
//    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"customAnnotation"];
//    
//    annotationView.enabled = YES;
//    annotationView.canShowCallout = YES;
//    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    
//    return annotationView;
//}
//
//@end
