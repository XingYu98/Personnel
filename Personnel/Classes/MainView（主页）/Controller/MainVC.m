//
//  MainVC.m
//  Personnel
//
//  Created by 罗星宇 on 2018/7/10.
//  Copyright © 2018年 罗星宇. All rights reserved.
//

#import "MainVC.h"
#import "FaceVC.h" //界面文件
#import "personNum.h"  //xib文件
#import "personImgNum.h" //xibImage文件
#import "UIColor+ColorChange.h" //编辑十六进制颜色文件

@interface MainVC ()

@end

@implementation MainVC

- (void)viewDidAppear:(BOOL)animated {

    if (self.Flag == 0) {
        UINib *nib = [UINib nibWithNibName:@"personNum" bundle:nil];
        
        personNum *xib1 = [[nib instantiateWithOwner:nil options:nil] firstObject];
        xib1.frame = CGRectMake(0,230, 100, 100);
        xib1.alpha = 0.f;
        xib1.deforeLab.text = @"总人数：";
        xib1.afterLab.text = @"678";
        
        [UIView transitionWithView:xib1 duration:1.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            xib1.frame = CGRectMake(20, 230, 150, 50);
            xib1.layer.cornerRadius = 5.0;
            xib1.layer.shadowOpacity = 0.5;
            xib1.alpha = 1.f;
            xib1.backgroundColor = [UIColor colorWithHexString:@"#d4fb79"];
        } completion:^(BOOL finished) {
            
        }];
        
        personNum *xib2 = [[nib instantiateWithOwner:nil options:nil] firstObject];
        xib2.frame = CGRectMake(220, 230, 100, 100);
        xib2.alpha = 0.f;
        xib2.deforeLab.text = @"教师人数：";
        xib2.afterLab.text = @"456";
        
        [UIView transitionWithView:xib2 duration:1.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            xib2.frame = CGRectMake(200, 230, 150, 50);
            xib2.layer.cornerRadius = 5.0;
            xib2.layer.shadowOpacity = 0.5;
            xib2.alpha = 1.f;
            xib2.backgroundColor = [UIColor colorWithHexString:@"#52fae3"];
        } completion:^(BOOL finished){
            
        }];
        
        personNum *xib3 = [[nib instantiateWithOwner:nil options:nil] firstObject];
        xib3.frame = CGRectMake(0, 300, 100, 100);
        xib3.alpha = 0.f;
        xib3.deforeLab.text = @"博士人数：";
        xib3.afterLab.text = @"56";
        
        [UIView transitionWithView:xib3 duration:1.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            xib3.frame = CGRectMake(20, 300, 150, 50);
            xib3.layer.cornerRadius = 5.0;
            xib3.layer.shadowOpacity = 0.5;
            xib3.alpha = 1.f;
            xib3.backgroundColor = [UIColor colorWithHexString:@"#faf814"];
        } completion:^(BOOL finished) {
            
        }];
        
        personNum *xib4 = [[nib instantiateWithOwner:nil options:nil] firstObject];
        xib4.frame = CGRectMake(220, 300, 100, 100);
        xib4.alpha = 0.f;
        xib4.deforeLab.text = @"硕士人数：";
        xib4.afterLab.text = @"234";
        
        [UIView transitionWithView:xib4 duration:1.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            xib4.frame = CGRectMake(200, 300, 150, 50);
            xib4.layer.cornerRadius = 5.0;
            xib4.layer.shadowOpacity = 0.5;
            xib4.alpha = 1.f;
            xib4.backgroundColor = [UIColor colorWithHexString:@"#fa9aa2"];
        }completion:^(BOOL finished) {
            
        }];
        
        //    显示xib1234控件
        [self.view addSubview:xib1];
        [self.view addSubview:xib2];
        [self.view addSubview:xib3];
        [self.view addSubview:xib4];
        self.Flag = 1;
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    

    

    
    

    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma 在TabBarController的子控制下，调用根控制器的值
/*例
 NSString *username = ((FaceVC *)self.parentViewController).username;
 NSLog(@"----%s----%@", __func__, username);
 */

@end
