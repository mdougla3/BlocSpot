//
//  ListViewController.m
//  BlocSpot
//
//  Created by McCay Barnes on 8/4/15.
//  Copyright (c) 2015 McCay Barnes. All rights reserved.
//

#import "ListViewController.h"
#import "MapItemData.h"

@interface ListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *returnMapItems;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property MapItemData *data;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.data = [[MapItemData alloc] init];
//    [self.data returnMapItems:^(NSArray *mapItems, NSString *text) {
//        for (MKMapItem *item in mapItems) {
//            [self.returnMapItems addObject:item];
//        }
//        [self.listTableView reloadData];
//    }];

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
