//
//  ListViewController.m
//  BlocSpot
//
//  Created by McCay Barnes on 8/4/15.
//  Copyright (c) 2015 McCay Barnes. All rights reserved.
//

#import "ListViewController.h"
#import "MapItemData.h"
#import "LocationManager.h"
#import "ListDetailViewController.h"
#import "POI.h"

@interface ListViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) NSArray *returnMapItems;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *listSearchBar;
@property MapItemData *data;
@property (nonatomic) MKCoordinateRegion listSearchRegion;
@property (nonatomic, retain) NSIndexPath *checkedIndexPath;
@property (assign) BOOL wasSaved;


@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listTableView.sectionHeaderHeight = 40;
    self.wasSaved = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
       return self.returnMapItems.count;
    }
    return self.savedMapItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    MKMapItem *item = self.returnMapItems[indexPath.row];
    cell.textLabel.text = item.name;
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    saveButton.frame = CGRectMake(cell.bounds.origin.x + 280, cell.frame.origin.y + 10, 100, 30);
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(savePressed:) forControlEvents:UIControlEventTouchUpInside];
    saveButton.backgroundColor= [UIColor clearColor];
    [[saveButton layer] setBorderColor:[UIColor blueColor].CGColor];
    [cell.contentView addSubview:saveButton];
    
    return cell;
}

-(void) savePressed:(UIButton *)sender {

    self.wasSaved = YES;
    POI *newPOI = [self poiWithName:sender.description];
    self.savedMapItems = @[newPOI];
}

-(POI *)poiWithName:(NSString *)name {
    
    id delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    POI *poi = [NSEntityDescription insertNewObjectForEntityForName:@"POI" inManagedObjectContext:context];
    poi.name = name;
    
    NSError *error = nil;
    if (![context save:&error]) {
        // there is an error
        NSLog(@"%@", error);
    }
    
    return poi;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.checkedIndexPath = indexPath;
    
    if (self.checkedIndexPath) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:self.checkedIndexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *sectionName;
    if (section == 1) {
        sectionName = @"Current Search";
    }
    else {
        sectionName = @"Saved Searches";
    }
    return sectionName;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    self.data = [[MapItemData alloc] init];
    [self.data returnMapItems:^(NSArray *mapItems) {
        self.returnMapItems = mapItems;
        MKMapItem *item = mapItems[0];
        
        CLLocationCoordinate2D searchLocation = item.placemark.coordinate;
        self.listSearchRegion = MKCoordinateRegionMakeWithDistance(searchLocation, 20, 20);
        
        [self.listTableView reloadData];
        
    } withString:searchText withRegion:self.listSearchRegion];
}

@end
