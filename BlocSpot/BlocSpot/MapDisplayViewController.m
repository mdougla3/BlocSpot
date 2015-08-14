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

@interface MapDisplayViewController () <CLLocationManagerDelegate, LocationManagerDelegate, UISearchBarDelegate, UIGestureRecognizerDelegate, UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSString *searchTerm;
@property (assign) BOOL isRegionSet;
@property (weak, nonatomic) IBOutlet UISearchBar *mapSearchBar;
@property (strong, nonatomic) MapItemData *data;
@property (strong, nonatomic) NSMutableArray *annotationArray;
@property (nonatomic) MKCoordinateRegion searchRegion;
@property (strong, nonatomic) UILongPressGestureRecognizer *longPressGestureRecognizer;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchController;


@end

@implementation MapDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchTerm = self.mapSearchBar.text;
    [[LocationManager sharedLocationManager] runLocationManager];
    [LocationManager sharedLocationManager].delegate = self;
    self.mapSearchBar.delegate = self;
    
    self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressFired:)];
    self.longPressGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:self.longPressGestureRecognizer];
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

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    self.data = [[MapItemData alloc] init];
    [self.data returnMapItems:^(NSArray *mapItems) {
        self.annotationArray = [@[] mutableCopy];
        [self.mapView removeAnnotations:self.mapView.annotations];
        for (MKMapItem *item in mapItems) {
            
            CustomAnnotation *annotation = [[CustomAnnotation alloc] initWithTitle:item.placemark.title Location:item.placemark.coordinate];
            [self.annotationArray addObject:annotation];
            
            CLLocationCoordinate2D searchLocation = item.placemark.coordinate;
            self.searchRegion = MKCoordinateRegionMakeWithDistance(searchLocation, 5, 5);
            
            [self.mapView setRegion:self.searchRegion];
            [self.mapView addAnnotations:self.annotationArray];
        }
        [[self.searchController searchResultsTableView] reloadData];
    } withString:searchText withRegion:self.searchRegion];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.annotationArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    CustomAnnotation *annotation = self.annotationArray[indexPath.row];
    cell.textLabel.text = annotation.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomAnnotation *annotation = self.annotationArray[indexPath.row];
    CLLocationCoordinate2D searchLocation = annotation.coordinate;
    self.searchRegion = MKCoordinateRegionMakeWithDistance(searchLocation, 5, 5);
    
    [self.mapView setRegion:self.searchRegion];
    [self.mapView addAnnotation:annotation];
    [self.searchController setActive:NO animated:YES];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
}



-(void) longPressFired:(UILongPressGestureRecognizer *)sender {
    NSLog(@"Long Press");
}

@end
