//
//  ListDetailViewController.m
//  BlocSpot
//
//  Created by McCay Barnes on 8/12/15.
//  Copyright (c) 2015 McCay Barnes. All rights reserved.
//

#import "ListDetailViewController.h"

@interface ListDetailViewController ()

@end

@implementation ListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Save" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    button.frame = CGRectMake(80, 120, 100, 100);
    [self.view addSubview:button];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 220, 300, 100)];
    nameLabel.backgroundColor = [UIColor whiteColor];
    nameLabel.text = @"Sample Label";
    [self.view addSubview:nameLabel];
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 320, 600, 100)];
    descriptionLabel.backgroundColor = [UIColor whiteColor];
    descriptionLabel.text = @"This is the description label";
    [self.view addSubview:descriptionLabel];
    
}

-(void) buttonPressed:(UIButton *)sender {
    NSLog(@"Button pressed");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
