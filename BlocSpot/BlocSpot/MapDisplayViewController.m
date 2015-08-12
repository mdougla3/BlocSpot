//
//  MapDisplayViewController.m
//  BlocSpot
//
//  Created by McCay Barnes on 8/4/15.
//  Copyright (c) 2015 McCay Barnes. All rights reserved.
//

#import "MapDisplayViewController.h"
#import <MapKit/MapKit.h>
#import "MapItemData.h"
#import "CustomAnnotation.h"
#import "LocationManager.h"

@interface MapDisplayViewController () <CLLocationManagerDelegate, LocationManagerDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSString *searchTerm;
@property (assign) BOOL isRegionSet;
@property (weak, nonatomic) IBOutlet UISearchBar *mapSearchBar;
@property (strong, nonatomic) MapItemData *data;
@property (strong, nonatomic) NSMutableArray *annotationArray;
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic) MKCoordinateRegion searchRegion;

@end

@implementation MapDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchTerm = self.mapSearchBar.text;
    [[LocationManager sharedLocationManager] runLocationManager];
    [LocationManager sharedLocationManager].delegate = self;
    self.mapSearchBar.delegate = self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    if (self.isRegionSet) {
        return;
    }
    self.isRegionSet = YES;
    
    CLLocationCoordinate2D initialLocation = [locations[0] coordinate];
    MKCoordinateRegion initialRegion = MKCoordinateRegionMakeWithDistance(initialLocation, 25, 25);
    [self.mapView setRegion:initialRegion];
    
    self.annotationArray = [[NSMutableArray alloc]init];
    
    self.data = [[MapItemData alloc] init];
    [self.data returnMapItems:^(NSArray *mapItems) {
        //Add annotations here
        for (MKMapItem *item in mapItems) {
            CustomAnnotation *annotation = [[CustomAnnotation alloc] initWithTitle:item.placemark.title Location:item.placemark.coordinate];
            [self.annotationArray addObject:annotation];
        }
        [self.mapView addAnnotations:self.annotationArray];
        
    }  withString: self.searchTerm withRegion:self.mapView.region];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    
    self.data = [[MapItemData alloc] init];
    [self.data returnMapItems:^(NSArray *mapItems) {
        for (MKMapItem *item in mapItems) {
            
            CustomAnnotation *annotation = [[CustomAnnotation alloc] initWithTitle:item.placemark.title Location:item.placemark.coordinate];
            [self.annotationArray addObject:annotation];
            
            CLLocationCoordinate2D searchLocation = item.placemark.coordinate;
            self.searchRegion = MKCoordinateRegionMakeWithDistance(searchLocation, 5, 5);
            
            self.tableView.hidden = YES;
            [self.mapView setRegion:self.searchRegion];
            [self.mapView addAnnotations:self.annotationArray];
        }
    } withString:self.mapSearchBar.text withRegion:self.searchRegion];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.annotationArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    MKMapItem *item = self.annotationArray[indexPath.row];
    cell.textLabel.text = item.name;
    
    return cell;
}

@end
