//
//  discoverVC.m
//  Personnel
//
//  Created by 罗星宇 on 2018/7/14.
//  Copyright © 2018年 罗星宇. All /Users/luoxingyu/Personnel Communication/Personnel/Personnel/Classes/Discover（发现）/Controller/discoverVC.hrights reserved.
//

#import "discoverVC.h"
#import "sanjiInqVC.h"

@interface discoverVC ()

@end

@implementation discoverVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma Button的行为

- (IBAction)ChartInquire:(id)sender {
    [self performSegueWithIdentifier:@"chartInquire" sender:nil];
}
- (IBAction)AllInquire:(id)sender {
}
- (IBAction)NameInquire:(id)sender {
}
- (IBAction)inYearInquire:(id)sender {
    [self performSegueWithIdentifier:@"sanjiInquire" sender:self.inYearLab.text];
}
- (IBAction)organInquire:(id)sender {
    [self performSegueWithIdentifier:@"sanjiInquire" sender:self.organLab.text];
}
- (IBAction)jobInquire:(id)sender {
    [self performSegueWithIdentifier:@"sanjiInquire" sender:self.jobLab.text];
}
- (IBAction)degreeInquire:(id)sender {
    [self performSegueWithIdentifier:@"sanjiInquire" sender:self.degreeLab.text];
}
- (IBAction)stuBackInquire:(id)sender {
    [self performSegueWithIdentifier:@"sanjiInquire" sender:self.stuBackLab.text];
}
- (IBAction)ageInquire:(id)sender {
    [self performSegueWithIdentifier:@"sanjiInquire" sender:self.ageLab.text];
}
- (IBAction)sectionInquire:(id)sender {
    [self performSegueWithIdentifier:@"sanjiInquire" sender:self.sectionLab.text];
}


#pragma segue传值代码
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    sanjiInqVC *sanjiVc = segue.destinationViewController;
    if ([sender  isEqual: @"部门系别"]) {
        sanjiVc.VTitle = @"部门查询";
        sanjiVc.firstSearchLab = @"部门：";
        sanjiVc.secondSearchLab = @"学历：";
        sanjiVc.thirdSearchLab = @"岗位性质：";
    }else if ([sender isEqual: @"年龄段"]) {
        sanjiVc.VTitle = @"年龄查询";
        sanjiVc.firstSearchLab = @"年龄段：";
        sanjiVc.secondSearchLab = @"学历：";
        sanjiVc.thirdSearchLab = @"岗位性质：";
        
    }else if ([sender isEqual: @"学历"]) {
        sanjiVc.VTitle = @"学历查询";
        sanjiVc.firstSearchLab = @"学历：";
        sanjiVc.secondSearchLab = @"部门：";
        sanjiVc.thirdSearchLab = @"年龄：";
        
    }else if ([sender isEqual: @"学位"]) {
        sanjiVc.VTitle = @"学位查询";
        sanjiVc.firstSearchLab = @"学位：";
        sanjiVc.secondSearchLab = @"部门：";
        sanjiVc.thirdSearchLab = @"岗位性质：";
        
    }else if ([sender isEqual: @"岗位"]) {
        sanjiVc.VTitle = @"岗位查询";
        sanjiVc.firstSearchLab = @"岗位性质：";
        sanjiVc.secondSearchLab = @"部门：";
        sanjiVc.thirdSearchLab = @"学历：";
        
    }else if ([sender isEqual: @"三级机构"]) {
        sanjiVc.VTitle = @"机构查询";
        sanjiVc.firstSearchLab = @"三级机构：";
        sanjiVc.secondSearchLab = @"学历：";
        sanjiVc.thirdSearchLab = @"年龄：";
        
    }else if ([sender isEqual: @"进校年份"]) {
        sanjiVc.VTitle = @"年份查询";
        sanjiVc.firstSearchLab = @"进校年份：";
        sanjiVc.secondSearchLab = @"部门：";
        sanjiVc.thirdSearchLab = @"学历：";
        
    }

}

@end
