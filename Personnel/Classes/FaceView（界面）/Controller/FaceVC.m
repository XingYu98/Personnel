//
//  FaceVC.m
//  Personnel
//
//  Created by 罗星宇 on 2018/7/3.
//  Copyright © 2018年 罗星宇. All rights reserved.
//

#import "FaceVC.h"

@interface FaceVC ()

@end

@implementation FaceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置导航条显示，animate：YES（有动画效果）：NO（没有动画效果，直接显示）
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated {
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
//设置导航条外观
-(void)setUpNavigation {
    [self.navigationController.navigationBar setBackgroundColor:[UIColor redColor]];
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
