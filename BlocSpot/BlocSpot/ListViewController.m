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
#import "ListDetailView.h"

@interface ListViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) NSArray *returnMapItems;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *listSearchBar;
@property MapItemData *data;
@property (nonatomic) MKCoordinateRegion listSearchRegion;
@property (nonatomic, retain) NSIndexPath *checkedIndexPath;
@property (assign) BOOL wasSaved;
@property (weak, nonatomic) IBOutlet ListDetailView *listDetailView;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchController;
@property (strong, nonatomic) UIVisualEffectView *blurEffectView;
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (strong, nonatomic) UIButton *addCategoryButton;
@property (strong, nonatomic) NSMutableArray *categories;


@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listTableView.sectionHeaderHeight = 40;
    self.wasSaved = NO;
    self.categoryTableView.hidden = YES;


    self.listDetailView.alpha = 0.0;
    self.listDetailView.layer.cornerRadius = 15;
    self.listDetailView.clipsToBounds = YES;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.categoryTableView) {
        return self.categories.count;
    }
    else if (section == 0) {
       return self.returnMapItems.count;
    }
    return self.savedMapItems.count;
}

- (void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (tableView == self.categoryTableView) {
        cell.backgroundColor = [self.categories objectAtIndex:indexPath.row];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.categoryTableView) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"categoryCell"];
        cell.textLabel.text = [self.categories objectAtIndex:indexPath.row];
        return cell;
    }
    else {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.textLabel.frame = CGRectMake(cell.textLabel.frame.origin.x, cell.textLabel.frame.origin.y, cell.textLabel.frame.size.width - 60, cell.textLabel.frame.size.height);
    }
    
    MKMapItem *item = self.returnMapItems[indexPath.row];
    cell.textLabel.text = item.name;
    
    return cell;
    }
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

    [self.searchController setActive:NO animated:YES];
    [self createBlurEffect];
    [UIView animateWithDuration:0.4 animations:^{
        
        // Add in mapData info to this view
        
        self.listDetailView.alpha = 1.0;
        self.listDetailView.poiTextView.text = @"Poison berries are poison";
        self.listDetailView.locationLabel.text = @"Location 0";
        self.listDetailView.titleLabel.text = @"Harrah's Casino";
        
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.categoryTableView) {
        return 1;
    }
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *sectionName;
    if (tableView == self.categoryTableView) {
        sectionName = @"Pick A Category";
    }
    else if (section == 0) {
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

- (IBAction)saveButton:(UIButton *)sender {
    
    self.listDetailView.alpha = 0.0;
    self.categoryTableView.hidden = NO;
    [self.categoryTableView reloadData];
    
    self.addCategoryButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    self.addCategoryButton.frame = CGRectMake(275, 0, 25, 25);
    [self.addCategoryButton addTarget:self action:@selector(addCategoryButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.categoryTableView addSubview:self.addCategoryButton];
    
}


-(void) createBlurEffect {
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self.blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [self.blurEffectView setFrame:self.view.bounds];
    [self.listTableView addSubview:self.blurEffectView];
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
        
        [self.categories addObject:addedCategoryName];
        [self.categoryTableView reloadData];
        
        
    }else{
        [alertView dismissWithClickedButtonIndex:1 animated:YES];
    }
}

@end
