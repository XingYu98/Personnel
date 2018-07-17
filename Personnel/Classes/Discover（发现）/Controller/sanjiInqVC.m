//
//  sanjiInqVC.m
//  Personnel
//
//  Created by 罗星宇 on 2018/7/14.
//  Copyright © 2018年 罗星宇. All rights reserved.
//

#import "sanjiInqVC.h"
#import "MBProgressHUD+XMG.h"
#import "sanjiInforVC.h"

@interface sanjiInqVC ()
@property (strong, nonatomic) IBOutlet UITextField *firstField;
@property (strong, nonatomic) IBOutlet UITextField *secondField;
@property (strong, nonatomic) IBOutlet UITextField *thirdField;
@property (strong, nonatomic) IBOutlet UILabel *firstSearch;
@property (strong, nonatomic) IBOutlet UILabel *secondSearch;
@property (strong, nonatomic) IBOutlet UILabel *thirdSearch;
@end

@implementation sanjiInqVC

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
                                                                      
    [self loadWillView];
}

#pragma WillAppear设置
-(void)loadWillView {
    //设置导航栏标题
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 62, 20)] ;
    titleLabel.text = self.VTitle;
    self.navigationItem.titleView = titleLabel ;
    
    self.firstSearch.text = self.firstSearchLab;
    self.secondSearch.text = self.secondSearchLab;
    self.thirdSearch.text = self.thirdSearchLab;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma 点击InquireBtn的行为
- (IBAction)inquireBtn:(id)sender {
    if (![_firstField.text isEqual:@""]) {
    [self performSegueWithIdentifier:@"sanjiContact" sender:nil];
    }else {
        [MBProgressHUD showError:@"请输入第一项信息"];
    }
}

#pragma segue传值代码
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    FaceVC *faceVc = segue.destinationViewController;
//    faceVc.username = self.usernameField.text;
//    faceVc.token = self.token;
    sanjiInforVC *sanjiVc = segue.destinationViewController;
    sanjiVc.firstInfor = self.firstField.text;
    sanjiVc.secondInfor = self.secondField.text;
    sanjiVc.thirdInfor = self.thirdField.text;
}

@end
