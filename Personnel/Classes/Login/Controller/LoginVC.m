//
//  LoginVC.m
//  Personnel
//
//  Created by 罗星宇 on 2018/7/3.
//  Copyright © 2018年 罗星宇. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()

@property (weak, nonatomic) IBOutlet UINavigationItem *NavigationBar;

@end

@implementation LoginVC


- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationController setNavigationBarHidden:YES animated:NO];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

@end
