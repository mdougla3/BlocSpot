//
//  SortedCategoryViewController.m
//  BlocSpot
//
//  Created by McCay Barnes on 9/1/15.
//  Copyright (c) 2015 McCay Barnes. All rights reserved.
//

#import "SortedCategoryViewController.h"
#import "ColoredCategory.h"
#import "POICategory.h"
#import "UIColor+String.h"
#import "POI.h"
@import CoreData;

@interface SortedCategoryViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *categories;
@property (strong, nonatomic) NSString *selectedCategoryName;
@property (strong, nonatomic) NSArray *selectedCategoryPOINames;

@end

@implementation SortedCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.displayResultsTableView.hidden = YES;
    self.categorySelectionTableView.hidden = NO;
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"POI"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"category" ascending:YES]];
    
    id delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSError *error = nil;
    
    NSArray *fetchedCategories = [context executeFetchRequest:fetchRequest error:&error];
    
    self.categories = [fetchedCategories mutableCopy];
    [self.categorySelectionTableView reloadData];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == self.categorySelectionTableView && self.categorySelectionTableView.hidden == NO) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"categoryCell"];
        POI *poiCategory = self.categories[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@", poiCategory.category];
        return cell;
    }
    else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sortedCategoryCell"];
        POI *poiNames = self.categories[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@", poiNames.name];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.categorySelectionTableView) {
        self.categorySelectionTableView.hidden = YES;
        self.displayResultsTableView.hidden = NO;
        POI *category = self.categories[indexPath.row];
        self.selectedCategoryName = [NSString stringWithFormat:@"%@", category.category];
        [self.displayResultsTableView reloadData];
    }
}

- (void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (tableView == self.categorySelectionTableView) {
        POI *selectedcategory = self.categories[indexPath.row];
        cell.backgroundColor = [UIColor fromString:selectedcategory.category];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.categorySelectionTableView) {
        return self.categories.count;
    }
    return self.categories.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.categorySelectionTableView) {
    return @"Pick a Category";
    }
    else {
        return self.selectedCategoryName;
    }
}

@end
