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
#import "PersonnelCharts.h" //Charts文件

@interface MainVC ()
@property (nonatomic, strong) NSDictionary *dataDict;  //请求的数据字典
@property (nonatomic, strong) LineChartView *chartView; //折线图对象
@end

@implementation MainVC

- (void)viewDidAppear:(BOOL)animated {

    if (self.Flag == 0) {
        [self loadPersonField]; //加载四个人员的数据框
        self.Flag = 1;
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //****发送首页的请求
    
    //获取FaceVC的token值
    NSString *token = ((FaceVC *)self.parentViewController).token;
    //定义首页信息
    NSString *condition = @"首页";
    [self fakeRequestChartsDataWithCondition:condition andToken:token];

    [self drawLineChart];
    [self updateChartData];
//    [self loadMainLogo];
    [self.view addSubview:_chartView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma 加载MainLogo
-(void)loadMainLogo {
    UIImageView *mainLogo = [[UIImageView alloc] init];
    mainLogo.image = [UIImage imageNamed:@"MainLogo"];
    mainLogo.alpha = 0.f;
    
    [UIView transitionWithView:mainLogo duration:1.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        mainLogo.frame = CGRectMake(20, 20, 222, 209);
        mainLogo.alpha = 1.f;
    } completion:^(BOOL finished) {
        
    }];
    [self.view addSubview:mainLogo];
}

#pragma 加载四种人数框
-(void)loadPersonField {
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
    
    [self.view addSubview:xib1];
    [self.view addSubview:xib2];
    [self.view addSubview:xib3];
    [self.view addSubview:xib4];
}

#pragma 绘制折线图
-(void)drawLineChart {
    self.chartView = [[LineChartView alloc] initWithFrame:CGRectMake(10, 365, 350, 250)];
    _chartView.delegate = self.chartView.delegate;
    
    _chartView.chartDescription.enabled = NO;
    
    _chartView.dragEnabled = YES;
    [_chartView setScaleEnabled:YES];
    _chartView.pinchZoomEnabled = YES;
    _chartView.drawGridBackgroundEnabled = NO;
    
    // x-axis limit line
    ChartLimitLine *llXAxis = [[ChartLimitLine alloc] initWithLimit:10.0 label:@"Index 10"];
    llXAxis.lineWidth = 4.0;
    llXAxis.lineDashLengths = @[@(10.f), @(10.f), @(0.f)];
    llXAxis.labelPosition = ChartLimitLabelPositionRightBottom;
    llXAxis.valueFont = [UIFont systemFontOfSize:10.f];
    
    //[_chartView.xAxis addLimitLine:llXAxis];
    
    _chartView.xAxis.gridLineDashLengths = @[@10.0, @10.0];
    _chartView.xAxis.gridLineDashPhase = 0.f;
    
    ChartLimitLine *ll1 = [[ChartLimitLine alloc] initWithLimit:150.0 label:@"Upper Limit"];
    ll1.lineWidth = 4.0;
    ll1.lineDashLengths = @[@5.f, @5.f];
    ll1.labelPosition = ChartLimitLabelPositionRightTop;
    ll1.valueFont = [UIFont systemFontOfSize:10.0];

    ChartLimitLine *ll2 = [[ChartLimitLine alloc] initWithLimit:-30.0 label:@"Lower Limit"];
    ll2.lineWidth = 4.0;
    ll2.lineDashLengths = @[@5.f, @5.f];
    ll2.labelPosition = ChartLimitLabelPositionRightBottom;
    ll2.valueFont = [UIFont systemFontOfSize:10.0];
    
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont systemFontOfSize:10.f];
    xAxis.drawGridLinesEnabled = NO;
    xAxis.granularity = 1.0; // only intervals of 1 day
    xAxis.labelCount = 7;
    xAxis.axisMaximum = 2018;
    xAxis.axisMinimum = 2014;
    
    ChartYAxis *leftAxis = _chartView.leftAxis;
    [leftAxis removeAllLimitLines];
//    [leftAxis addLimitLine:ll1];
//    [leftAxis addLimitLine:ll2];
    leftAxis.axisMaximum = 1000.0;
    leftAxis.axisMinimum = 0.0;
    leftAxis.gridLineDashLengths = @[@10.f, @5.f];
    leftAxis.drawZeroLineEnabled = NO;
    leftAxis.drawLimitLinesBehindDataEnabled = NO;
    
    _chartView.rightAxis.enabled = NO;
    
    //[_chartView.viewPortHandler setMaximumScaleY: 2.f];
    //[_chartView.viewPortHandler setMaximumScaleX: 2.f];
    
    
//    BalloonMarker *marker = [[BalloonMarker alloc]
//                             initWithColor: [UIColor colorWithWhite:180/255. alpha:1.0]
//                             font: [UIFont systemFontOfSize:12.0]
//                             textColor: UIColor.whiteColor
//                             insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)];
//    marker.chartView = _chartView;
//    marker.minimumSize = CGSizeMake(80.f, 40.f);
//    _chartView.marker = marker;
    
    _chartView.legend.form = ChartLegendFormLine;

    
    [_chartView animateWithXAxisDuration:1.0];
}

#pragma 提供数据
- (void)updateChartData
{
    if (self.shouldHideData)
    {
        _chartView.data = nil;
        return;
    }
    
    [self setDataCount:5 range:150];
}

- (void)setDataCount:(int)count range:(double)range
{
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    NSInteger flag = 2014;
    for (int i = 0; i < count; i++)
    {
//        double val = arc4random_uniform(range) + 3;
        NSArray *yValsData = @[self.dataDict[@"request"][4][@"sumCount-4"], self.dataDict[@"request"][3][@"sumCount-3"], self.dataDict[@"request"][2][@"sumCount-2"], self.dataDict[@"request"][1][@"sumCount-1"], self.dataDict[@"request"][0][@"sumCount"]];

        
        [values addObject:[[ChartDataEntry alloc] initWithX:flag y:[yValsData[i] doubleValue] icon: [UIImage imageNamed:@"icon"]]];
        
        flag++;
    }
    
    LineChartDataSet *set1 = nil;
    if (_chartView.data.dataSetCount > 0)
    {
        set1 = (LineChartDataSet *)_chartView.data.dataSets[0];
        set1.values = values;
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[LineChartDataSet alloc] initWithValues:values label:@"总人数"];
        
        set1.drawIconsEnabled = NO;
        
        set1.lineDashLengths = @[@5.f, @2.5f];
        set1.highlightLineDashLengths = @[@5.f, @2.5f];
        [set1 setColor:UIColor.blackColor];
        [set1 setCircleColor:UIColor.blackColor];
        set1.lineWidth = 1.0;
        set1.circleRadius = 3.0;
        set1.drawCircleHoleEnabled = NO;
        set1.valueFont = [UIFont systemFontOfSize:9.f];
        set1.formLineDashLengths = @[@5.f, @2.5f];
        set1.formLineWidth = 1.0;
        set1.formSize = 15.0;
        
        NSArray *gradientColors = @[
                                    (id)[ChartColorTemplates colorFromString:@"#00ff0000"].CGColor,
                                    (id)[ChartColorTemplates colorFromString:@"#ffff0000"].CGColor
                                    ];
        CGGradientRef gradient = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
        
        set1.fillAlpha = 1.f;
        set1.fill = [ChartFill fillWithLinearGradient:gradient angle:90.f];
        set1.drawFilledEnabled = YES;
        
        CGGradientRelease(gradient);
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        
        _chartView.data = data;
    }
}


#pragma 请求图表数据
-(void)fakeRequestChartsDataWithCondition: (NSString *)condition andToken: (NSString *)token {
    if ([token  isEqual: @"tokentokentokenQQQ"]) {
        NSDictionary *dict = @{
                               @"status":@"success",
                               @"request":@[
                                       @{
                                           @"sumCount":@"678",
                                           @"teachCount":@"456",
                                           @"doctCount":@"45",
                                           @"mastCount":@"123"
                                           },
                                       @{
                                           @"sumCount-1":@"564",
                                           @"teachCount-1":@"234",
                                           @"doctCount-1":@"12",
                                           @"mastCount-1":@"34"
                                           },
                                       @{
                                           @"sumCount-2":@"621",
                                           @"teachCount-2":@"234",
                                           @"doctCount-2":@"12",
                                           @"mastCount-2":@"34"
                                           },
                                       @{
                                           @"sumCount-3":@"432",
                                           @"teachCount-3":@"234",
                                           @"doctCount-3":@"12",
                                           @"mastCount-3":@"34"
                                           },
                                       @{
                                           @"sumCount-4":@"342",
                                           @"teachCount-4":@"234",
                                           @"doctCount-4":@"12",
                                           @"mastCount-4":@"34"
                                           }
                                       ]
                               };
        self.dataDict = dict;
    }else {
        NSDictionary *errDict = @{@"status":@"error"};
        self.dataDict = errDict;
    }
}

-(void)requestChartsDataWithCondition: (NSString *)condition andToken: (NSString *)token {
    //基本的URL地址
    NSString *urlBaseString = @"http://172.17.143.230:80/Index1?condition=%@&token=%@";
    //合成新的请求字符串
    NSString *urlString = [NSString stringWithFormat:urlBaseString, condition, token];
    
    //对含有汉字的url地址进行UTF-8编码，即可访问
    NSString *utfStringUTF8 = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    //一种旧的方法，但是能用
    /*
     NSString *urlStringUTF8 = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     */
    
    NSURL *url = [NSURL URLWithString:utfStringUTF8];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable  connectionError) {
        
        if (connectionError) {
            NSLog(@"请求失败");
        }else {
            //当请求结束之后会调用该block
            //4.解析数据
            NSString *res = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"------\n%@\n------", res);
            NSLog(@"====\n%@\n====", dict);
        }
    }];
    //    self.loginStatus = dict[@"status"];
    //    self.token = dict[@"token"];
}

#pragma 在TabBarController的子控制下，调用根控制器的值
/*例
 NSString *username = ((FaceVC *)self.parentViewController).username;
 NSLog(@"----%s----%@", __func__, username);
 */

@end
