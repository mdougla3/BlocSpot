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

@interface ListViewController () <UITableViewDelegate, UITableViewDataSource, LocationManagerDelegate>

@property (strong, nonatomic) NSMutableArray *returnMapItems;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *listSearchBar;
@property MapItemData *data;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocationCoordinate2D initialLocation = [locations[0] coordinate];
    MKCoordinateRegion initialRegion = MKCoordinateRegionMakeWithDistance(initialLocation, 8, 8);
    
    self.data = [[MapItemData alloc] init];
    [self.data returnMapItems:^(NSArray *mapItems) {
        
    } withString:self.listSearchBar.text withRegion:initialRegion];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.returnMapItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
    MKMapItem *item = self.returnMapItems[indexPath.row];
    cell.textLabel.text = item.name;
    
    return cell;
}



@end
