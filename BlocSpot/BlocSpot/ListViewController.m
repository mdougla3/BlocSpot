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

@interface ListViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) NSArray *returnMapItems;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *listSearchBar;
@property MapItemData *data;
@property (nonatomic) MKCoordinateRegion listSearchRegion;


@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.returnMapItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    MKMapItem *item = self.returnMapItems[indexPath.row];
    cell.textLabel.text = item.name;
    //cell.detailTextLabel.text =[NSString stringWithFormat:(@"%@", item.placemark.location)];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.modalPresentationStyle = UIModalPresentationCustom;
    
    // Create a second viewcontroller with the information
    ListDetailViewController *detailVC = [[ListDetailViewController alloc] init];
    [self presentViewController:detailVC animated:YES completion:nil];
}



-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    self.data = [[MapItemData alloc] init];
    [self.data returnMapItems:^(NSArray *mapItems) {
        self.returnMapItems = mapItems;
        MKMapItem *item = mapItems[0];
        
        CLLocationCoordinate2D searchLocation = item.placemark.coordinate;
        self.listSearchRegion = MKCoordinateRegionMakeWithDistance(searchLocation, 20, 20);

        [self.listTableView reloadData];
        
    } withString:self.listSearchBar.text withRegion:self.listSearchRegion];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.listTableView.hidden = YES;
}

@end
