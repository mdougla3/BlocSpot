//
//  SearchViewController.m
//  BlocSpot
//
//  Created by McCay Barnes on 8/4/15.
//  Copyright (c) 2015 McCay Barnes. All rights reserved.
//

#import "SearchViewController.h"
#import "MapItemData.h"
#import "ListViewController.h"

@interface SearchViewController () <UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) ListViewController *listViewController;
@property (strong, nonatomic) NSMutableArray *searchMapItems;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    ListViewController *vc = [[ListViewController alloc] init];
    return vc.savedMapItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    return cell;
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
}

@end
