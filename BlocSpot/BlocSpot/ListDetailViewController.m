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
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Save" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    button.frame = CGRectMake(80, 120, 100, 100);
    [self.view addSubview:button];
    
}

-(void) buttonPressed:(UIButton *)sender {
    NSLog(@"Button pressed");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
