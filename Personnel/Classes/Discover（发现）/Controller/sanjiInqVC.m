//
//  sanjiInqVC.m
//  Personnel
//
//  Created by 罗星宇 on 2018/7/14.
//  Copyright © 2018年 罗星宇. All rights reserved.
//

#import "sanjiInqVC.h"

@interface sanjiInqVC ()
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
