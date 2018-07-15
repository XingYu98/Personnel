//
//  chartInqVC.m
//  Personnel
//
//  Created by 罗星宇 on 2018/7/14.
//  Copyright © 2018年 罗星宇. All rights reserved.
//

#import "chartInqVC.h"

@interface chartInqVC ()
@property (nonatomic, strong) PieChartView *chartView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation chartInqVC


-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fakeAsync];
    [self drawPieCharts1];
    [self.view addSubview:_chartView];
    NSLog(@"%@", self.dataArray[1]);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma 请求数据
-(void)fakeAsync {
    NSArray *array = @[
                        @{
                           @"博士":@"23",
                           @"硕士":@"45",
                           @"本科":@"78",
                           @"其他":@"98",
                           },
                       @{
                           @"教授":@"45",
                           @"副教授":@"78",
                           @"讲师":@"123",
                           @"其他":@"342"
                           }];
    NSArray *array1 = @[@"23",@"45",@"78",@"98"];
    self.dataArray = array;
}
#pragma 绘制饼图
-(void)drawPieCharts1 {
    self.chartView = [[PieChartView alloc] initWithFrame:CGRectMake(12, 200, 340, 250)];
    [self setupPieChartView:_chartView];
    _chartView.delegate = self.chartView.delegate;
    _chartView.noDataText = @"Charts for kong";
    
    //图例
    ChartLegend *l = _chartView.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
    l.verticalAlignment = ChartLegendVerticalAlignmentCenter;
    l.orientation = ChartLegendOrientationVertical;
    l.form = ChartLegendFormCircle;
    l.drawInside = NO;
//    l.xEntrySpace = 7.0;
//    l.yEntrySpace = 0.0;
//    l.yOffset = 0.0;
    l.formSize = 8;
    l.maxSizePercent = 1;
    l.formToTextSpace =8;
    l.font = [UIFont systemFontOfSize: 10];
//    l.textColor = [UIColor grayColor];
//    l.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
//    l.verticalAlignment = ChartLegendVerticalAlignmentCenter;
    
    
    //entry label styling
    _chartView.entryLabelColor = UIColor.whiteColor;
    _chartView.entryLabelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.f];
    
    [_chartView animateWithXAxisDuration:1.4 easingOption:ChartEasingOptionEaseOutBack]; //打开图表时的动画时间和动画类型
    [self setDataCount:4 range:100];
}

- (void)setDataCount:(int)count range:(double)range
{
//    double mult = range;
    parties = @[
                             @"博士", @"硕士", @"本科", @"其他"
                             ];

    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
//    for (int i = 0; i < count; i++)
//    {
//        //        [values addObject:[[PieChartDataEntry alloc] initWithValue:(arc4random_uniform(mult) + mult / 5) label:parties[i % parties.count] icon: [UIImage imageNamed:@"icon"]]];
//        [values addObject:[[PieChartDataEntry alloc] initWithValue:[self.dataArray[i] doubleValue] label:parties[i % parties.count]]];
//        NSLog(@"%f", [self.dataArray[i] doubleValue]);
//    }
    [values addObject:[[PieChartDataEntry alloc] initWithValue:[self.dataArray[0][@"博士"] doubleValue] label:parties[0]]];
    [values addObject:[[PieChartDataEntry alloc] initWithValue:[self.dataArray[0][@"硕士"] doubleValue] label:parties[1]]];
    [values addObject:[[PieChartDataEntry alloc] initWithValue:[self.dataArray[0][@"本科"] doubleValue] label:parties[2]]];
    [values addObject:[[PieChartDataEntry alloc] initWithValue:[self.dataArray[0][@"其他"] doubleValue] label:parties[3]]];
    
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:values label:nil];
    
    dataSet.drawIconsEnabled = NO;
    
    dataSet.sliceSpace = 2.0;
    dataSet.iconsOffset = CGPointMake(0, 40);
    
    // add a lot of colors
    
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
    [colors addObjectsFromArray:ChartColorTemplates.joyful];
    [colors addObjectsFromArray:ChartColorTemplates.colorful];
    [colors addObjectsFromArray:ChartColorTemplates.liberty];
    [colors addObjectsFromArray:ChartColorTemplates.pastel];
    [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
    
    dataSet.colors = colors;
    
    PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
    
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterPercentStyle;
    pFormatter.maximumFractionDigits = 1;
    pFormatter.multiplier = @1.f;
    pFormatter.percentSymbol = @" %";
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];
    [data setValueTextColor:UIColor.whiteColor];
    
    _chartView.data = data;
    [_chartView highlightValues:nil];
}

@end
