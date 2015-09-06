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
#import "POI.h"
#import "CategoryView.h"
#import "ColoredCategory.h"
#import "POICategory.h"
#import "UIColor+String.h"

@interface MapDisplayViewController () <CLLocationManagerDelegate, LocationManagerDelegate, UISearchBarDelegate, UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSString *searchTerm;
@property (assign) BOOL isRegionSet;
@property (weak, nonatomic) IBOutlet UISearchBar *mapSearchBar;
@property (strong, nonatomic) MapItemData *data;
@property (strong, nonatomic) NSMutableArray *annotationArray;
@property (nonatomic) MKCoordinateRegion searchRegion;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchController;
@property (strong, nonatomic) NSArray *savedMapItems;
@property (weak, nonatomic) IBOutlet CategoryView *categoryView;
@property (strong, nonatomic) UIVisualEffectView *blurEffectView;
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (strong, nonatomic) UIButton *addCategoryButton;
@property (strong, nonatomic) NSArray *savedSearchResults;
@property (assign, nonatomic) NSInteger selectedIndex;
@property (strong, nonatomic) NSMutableArray *categories;

@end

@implementation MapDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchTerm = self.mapSearchBar.text;
    [[LocationManager sharedLocationManager] runLocationManager];
    [LocationManager sharedLocationManager].delegate = self;
    self.mapSearchBar.delegate = self;
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.categoryTableView.hidden = YES;
    
    self.categoryView.alpha = 0.0;
    self.categoryView.layer.cornerRadius = 15;
    self.categoryView.clipsToBounds = YES;
    self.isRegionSet = NO;
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
        self.savedSearchResults = mapItems;
        
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
            
        }
        [self.mapView setRegion:self.searchRegion];
        [self.mapView addAnnotations:self.annotationArray];

        self.savedSearchResults = mapItems;
        [[self.searchController searchResultsTableView] reloadData];
    } withString:searchText withRegion:self.searchRegion];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.categoryTableView && self.categoryTableView.hidden == NO) {
        return self.categories.count;
    }
    return self.annotationArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.categoryTableView && self.categoryTableView.hidden == NO) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"categoryCell"];
        POICategory *category = self.categories[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@", category.name];
        return cell;
    }
    else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    CustomAnnotation *annotation = self.annotationArray[indexPath.row];
    cell.textLabel.text = annotation.title;
    
    return cell;
    }
}

- (void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (tableView == self.categoryTableView) {
        POICategory *category = self.categories[indexPath.row];
        cell.backgroundColor = [UIColor fromString:category.color];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView == self.categoryTableView) {
        MKMapItem *item = self.savedSearchResults[self.selectedIndex];
        POI *mapPOI = [self poiWithMapItem:item];
        POICategory *category = self.categories[indexPath.row];
        mapPOI.category = category.name;
        
        self.categoryTableView.hidden = YES;
        [self.blurEffectView removeFromSuperview];
        [self.addCategoryButton removeFromSuperview];
    }
    
    // NSRangeException', reason: '*** -[__NSArrayM objectAtIndex:]: index 3 beyond bounds [0 .. 0]' when clicking past 1st cell
    
    CustomAnnotation *annotation = self.annotationArray[indexPath.row];
    CLLocationCoordinate2D searchLocation = annotation.coordinate;
    self.searchRegion = MKCoordinateRegionMakeWithDistance(searchLocation, 5, 5);
    
    [self.mapView setRegion:self.searchRegion];
    [self.mapView removeAnnotations:self.mapView.annotations];
    self.annotationArray = [@[annotation] mutableCopy];
    [self.mapView addAnnotation:annotation];
    self.selectedIndex = indexPath.row;
    [self.searchController setActive:NO animated:YES];
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{
    
    if([annotation isKindOfClass: [MKUserLocation class]])
        return nil;
    
    MKPinAnnotationView *selectedAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myPin"];
    selectedAnnotation.pinColor = MKPinAnnotationColorGreen;
    selectedAnnotation.canShowCallout = YES;
    
    return selectedAnnotation;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    MKMapItem *item = self.savedSearchResults[self.selectedIndex];
    self.savedMapItems = @[item];
    
    [self createBlurEffect];
    
    [UIView animateWithDuration:0.4 animations:^{
        
        // Add in mapData info to this view
        
        self.categoryView.alpha = 1.0;
        self.categoryView.poiTextView.text = @"A user can edit this later";
        self.categoryView.locationLabel.text = item.phoneNumber;
        self.categoryView.titleLabel.text = item.name;
    }];
    
}

-(POI *)poiWithMapItem:(MKMapItem *)item {
    
    id delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    POI *poi = [NSEntityDescription insertNewObjectForEntityForName:@"POI" inManagedObjectContext:context];
    
    poi.name = item.name;
    poi.address = item.phoneNumber;
    
    NSError *error = nil;
    if (![context save:&error]) {
        // there is an error
        NSLog(@"%@", error);
    }
    
    return poi;
}

-(POICategory *)poiCategoryWithName:(NSString *)name {
    
    id delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    POICategory *poiCategory = [NSEntityDescription insertNewObjectForEntityForName:@"POICategory" inManagedObjectContext:context];
    poiCategory.name = name;
    poiCategory.color = [[UIColor randomColor] toString];
    
    NSError *error = nil;
    if (![context save:&error]) {
        // there is an error
        NSLog(@"%@", error);
    }
    
    return poiCategory;
}

# pragma mark - UIView Buttons

- (IBAction)cancelButton:(UIButton *)sender {
    self.categoryView.alpha = 0.0;
    [self.blurEffectView removeFromSuperview];
}

- (IBAction)visitedButton:(UIButton *)sender {
    
}

- (IBAction)saveButton:(UIButton *)sender {
    
    self.categoryView.alpha = 0.0;
    self.categoryTableView.hidden = NO;
    [self.categoryTableView reloadData];
    
    self.addCategoryButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    self.addCategoryButton.frame = CGRectMake(310, 115, 25, 25);
    [self.addCategoryButton addTarget:self action:@selector(addCategoryButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.mapView addSubview:self.addCategoryButton];
    
    MKMapItem *item = self.savedSearchResults[self.selectedIndex];
    POI *mapPOI = [self poiWithMapItem:item];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"POICategory"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    
    id delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSError *error = nil;
    
    NSArray *fetchedCategories = [context executeFetchRequest:fetchRequest error:&error];
    
    self.categories = [fetchedCategories mutableCopy];
    [self.categoryTableView reloadData];
    
}

-(void) createBlurEffect {
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [self.blurEffectView setFrame:self.view.bounds];
    [self.mapView addSubview:self.blurEffectView];
}

-(void) addCategoryButtonPressed:(UIButton *)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add a new Category"
                                                    message:@"Please enter your new category name here"
                                                   delegate:self
                                          cancelButtonTitle:@"Add"
                                          otherButtonTitles:@"Cancel", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
    


}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == [alertView cancelButtonIndex]){
        
        NSString *addedCategoryName = [alertView textFieldAtIndex:0].text;
        
        POICategory *categoryName = [self poiCategoryWithName:addedCategoryName];
        
        [self.categories addObject:categoryName];
        [self.categoryTableView reloadData];
    
    
    }else{
        [alertView dismissWithClickedButtonIndex:1 animated:YES];
    }
}

@end
