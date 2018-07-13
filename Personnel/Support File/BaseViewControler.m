//
//  BaseViewControler.m
//  ChartsTest2
//
//  Created by 罗星宇 on 2018/7/9.
//  Copyright © 2018年 罗星宇. All rights reserved.
//

#import "BaseViewControler.h"

@interface BaseViewControler ()

@end

@implementation BaseViewControler



- (void)initialize
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    parties = @[
                @"Party A", @"Party B", @"Party C", @"Party D", @"Party E", @"Party F",
                @"Party G", @"Party H", @"Party I", @"Party J", @"Party K", @"Party L",
                @"Party M", @"Party N", @"Party O", @"Party P", @"Party Q", @"Party R",
                @"Party S", @"Party T", @"Party U", @"Party V", @"Party W", @"Party X",
                @"Party Y", @"Party Z"
                ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateChartData
{
    // Override this
}

- (void)setupPieChartView:(PieChartView *)chartView
{
    chartView.usePercentValuesEnabled = YES; //是否使用百分比的值
    chartView.drawSlicesUnderHoleEnabled = NO;
    chartView.holeRadiusPercent = 0.58;
    chartView.transparentCircleRadiusPercent = 0.61;
    chartView.chartDescription.enabled = NO;
    [chartView setExtraOffsetsWithLeft:5.f top:10.f right:5.f bottom:5.f]; //饼图的位置？？
    
    chartView.drawCenterTextEnabled = YES;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:@"Charts\nby Daniel Cohen Gindi"];
    [centerText setAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:13.f],
                                NSParagraphStyleAttributeName: paragraphStyle
                                } range:NSMakeRange(0, centerText.length)];
    [centerText addAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f],
                                NSForegroundColorAttributeName: UIColor.grayColor
                                } range:NSMakeRange(10, centerText.length - 10)];
    [centerText addAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:11.f],
                                NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]
                                } range:NSMakeRange(centerText.length - 19, 19)];
    chartView.centerAttributedText = centerText;
    
    chartView.drawHoleEnabled = YES; //能否显示中间圆圈
    chartView.rotationAngle = 0.0; //旋转角度
    chartView.rotationEnabled = YES; //能否旋转
    chartView.highlightPerTapEnabled = YES; //能否轻触高亮饼图
    
    ChartLegend *l = chartView.legend; //legend图例对象
    l.horizontalAlignment = ChartLegendHorizontalAlignmentRight; //水平校准
    l.verticalAlignment = ChartLegendVerticalAlignmentTop; //垂直校准
    l.orientation = ChartLegendOrientationVertical; //方向
    l.drawInside = NO; //图例画在图表内或者是图表外部
    l.xEntrySpace = 7.0; //x轴空多少
    l.yEntrySpace = 0.0; //y轴空多少
    l.yOffset = 0.0;
}
@end
