//
//  SortedCategoryViewController.m
//  BlocSpot
//
//  Created by McCay Barnes on 9/1/15.
//  Copyright (c) 2015 McCay Barnes. All rights reserved.
//

#import "SortedCategoryViewController.h"
#import "ColoredCategory.h"
#import "UIColor+String.h"
#import "POI.h"
#import "POICategory.h"
@import CoreData;

@interface SortedCategoryViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSString *selectedCategoryName;
@property (strong, nonatomic) NSArray *selectedCategoryPOINames;
@property (strong, nonatomic) NSMutableArray *savedPOIs;
@property (strong, nonatomic) NSMutableArray *savedCategories;


@end

@implementation SortedCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.displayResultsTableView.hidden = YES;
    self.categorySelectionTableView.hidden = NO;
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"POI"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    
    id delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSError *error = nil;
    
    NSArray *fetchedPois = [context executeFetchRequest:fetchRequest error:&error];
    
    self.savedPOIs = [fetchedPois mutableCopy];
    
    fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"POICategory"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"categoryName" ascending:YES]];
    
    NSArray *fetchedCategories = [context executeFetchRequest:fetchRequest error:&error];
    
    self.savedCategories = [fetchedCategories mutableCopy];
    
    [self.categorySelectionTableView reloadData];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == self.categorySelectionTableView && self.categorySelectionTableView.hidden == NO) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"categoryCell"];
        POICategory *savedCategories = self.savedCategories[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@", savedCategories.categoryName];
        return cell;
    }
    else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sortedCategoryCell"];
        POI *poiNames = self.savedPOIs[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@", poiNames.name];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.categorySelectionTableView) {
        self.categorySelectionTableView.hidden = YES;
        self.displayResultsTableView.hidden = NO;
        POI *poiCategory = self.savedPOIs[indexPath.row];
        self.selectedCategoryName = [NSString stringWithFormat:@"%@", poiCategory.categoryType.categoryName];
        [self.displayResultsTableView reloadData];
    }
}

- (void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (tableView == self.categorySelectionTableView) {
        POICategory *selectedcategory = self.savedCategories[indexPath.row];
        cell.backgroundColor = [UIColor fromString:selectedcategory.categoryColor];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.categorySelectionTableView) {
        //return self.savedCategories.count;
        return 5;
    }
    return self.savedPOIs.count;
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
