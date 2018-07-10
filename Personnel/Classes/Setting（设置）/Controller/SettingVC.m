//
//  SettingVC.m
//  Personnel
//
//  Created by 罗星宇 on 2018/7/4.
//  Copyright © 2018年 罗星宇. All rights reserved.
//

#import "SettingVC.h"
#import "PersonnelCharts.h"

@interface SettingVC ()

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//退出登陆
- (IBAction)LogOut:(id)sender {
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"确定退出登陆吗？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"退出" otherButtonTitles:nil, nil];
    
    [sheet showInView:self.view];
    
}

//监听UIActionSheet上按钮的点击（退出登陆的关键）
-(void)actionSheet: (UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:NO];
    }
}



@end
