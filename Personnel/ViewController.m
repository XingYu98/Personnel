//
//  ViewController.m
//  Personnel
//
//  Created by 罗星宇 on 2018/7/3.
//  Copyright © 2018年 罗星宇. All rights reserved.
//

#import "ViewController.h"
#import "PersonnelCharts.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    BarChartView *chatView = [[BarChartView alloc] initWithFrame:CGRectMake(5, 5, [UIScreen mainScreen].bounds.size.width - 10, [UIScreen mainScreen].bounds.size.height - 10)];
    [self.view addSubview:chatView];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
