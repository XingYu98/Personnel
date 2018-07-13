//
//  BaseViewControler.h
//  ChartsTest2
//
//  Created by 罗星宇 on 2018/7/9.
//  Copyright © 2018年 罗星宇. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ChartsTest2-Swift.h"
#import "PersonnelCharts.h"

@interface BaseViewControler : UIViewController
{
    @protected
    NSArray *parties;
}
@property (nonatomic, assign) BOOL shouldHideData;

- (void)updateChartData;

- (void)setupPieChartView:(PieChartView *)chartView;

@end
