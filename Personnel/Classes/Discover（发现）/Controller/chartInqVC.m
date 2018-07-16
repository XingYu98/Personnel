//
//  chartInqVC.m
//  Personnel
//
//  Created by 罗星宇 on 2018/7/14.
//  Copyright © 2018年 罗星宇. All rights reserved.
//

#import "chartInqVC.h"
#import "PersonnelCharts.h" //Charts图表文件
#import "MBProgressHUD+XMG.h"

@interface chartInqVC ()
@property (strong, nonatomic) IBOutlet UITextField *Search1Field;
@property (strong, nonatomic) IBOutlet UITextField *Search2Field;
@property (nonatomic, strong) PieChartView *chartView;
@property (nonatomic, strong) PieChartView *chartView1;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation chartInqVC


-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _Search1Field.delegate = self;
    _Search2Field.delegate = self;
    
    
    //及时监听文本框输入
    [_Search1Field addTarget:self action:@selector(search1FieldTextChange) forControlEvents:UIControlEventEditingChanged];
    [_Search2Field addTarget:self action:@selector(search2FieldTextChange) forControlEvents:UIControlEventEditingChanged];
    
    
    [self fakeAsyncWithSearch1:self.Search1Field.text andSearch2:self.Search2Field.text];
    [self drawPieCharts];
    [self.view addSubview:_chartView];
    [self drawPieCharts1];
    [self.view addSubview:_chartView1];
}

#pragma search1 monitor Method
- (void)search1FieldTextChange {
    _Search2Field.text = _Search1Field.text;
    NSLog(@"%@", _Search2Field.text);
    _Search2Field.textColor = [UIColor whiteColor];
}

#pragma click search1 trigger Method
-(void)textFieldDidBeginEditing:(UITextField*)textField
{
    // [_SecField resignFirstResponder];
    if (textField == _Search2Field) {
        _Search2Field.text = _Search1Field.text;
        _Search2Field.textColor = [UIColor whiteColor];
        NSLog(@"%@", _Search2Field.text);
    }else if (textField == _Search1Field) {
        _Search2Field.text = @"";
    }
}


- (void)search2FieldTextChange {
    
}

#pragma searchBtn Action Method
- (IBAction)searchBtn:(id)sender {
    if (![self.Search1Field.text  isEqual: @""] && ![self.Search2Field.text  isEqual: @""]) {
        [self.Search1Field resignFirstResponder];
        [self.Search2Field resignFirstResponder];
        [self.chartView removeFromSuperview];
        [self.chartView1 removeFromSuperview];
        [self fakeAsyncWithSearch1:self.Search1Field.text andSearch2:self.Search2Field.text];
        [self drawPieCharts];
        [self.view addSubview:_chartView];
        [self drawPieCharts1];
        [self.view addSubview:_chartView1];
    }else {
        [MBProgressHUD showError:@"请完善查询信息"];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

//点击出textField的区域收回键盘
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {//触摸事件中的触摸结束时会调用
    if (![_Search1Field isExclusiveTouch] || ![_Search2Field isExclusiveTouch]) {//判断点击是否在textfield和键盘以外
        //将MinField中的“部门/系别”变白
        //_MinField.textColor = [UIColor whiteColor];
        [_Search1Field resignFirstResponder];//收起键盘
        [_Search2Field resignFirstResponder];
    }
}
#pragma 请求数据
-(void)fakeAsyncWithSearch1: (NSString *)search1 andSearch2: (NSString *)search2 {
    NSArray *NSarray = nil;
    if (![search1 isEqual: @""] && [search2 isEqual: @"党委"]) {
    NSarray = @[
                        @{
                           @"博士":@"23",
                           @"硕士":@"451",
                           @"本科":@"78",
                           @"其他":@"98",
                           },
                       @{
                           @"教授":@"451",
                           @"副教授":@"78",
                           @"讲师":@"123",
                           @"助教":@"342"
                           }];
    }else if (![search1 isEqual: @""] && [search2 isEqual: @"2015"]){
        NSarray = @[
                    @{
                        @"博士":@"45",
                        @"硕士":@"45",
                        @"本科":@"35",
                        @"其他":@"78",
                        },
                    @{
                        @"教授":@"31",
                        @"副教授":@"45",
                        @"讲师":@"73",
                        @"助教":@"45"
                        }];
    }else if (![search1 isEqual: @""] && [search2 isEqual: @"山西"]){
        NSarray = @[
                    @{
                        @"博士":@"46",
                        @"硕士":@"50",
                        @"本科":@"80",
                        @"其他":@"102",
                        },
                    @{
                        @"教授":@"98",
                        @"副教授":@"45",
                        @"讲师":@"73",
                        @"助教":@"35"
                        }];
    }else if ([search1 isEqual: @""] && [search2 isEqual: @""]){
        NSarray = @[
                    @{
                        @"博士":@"46",
                        @"硕士":@"50",
                        @"本科":@"80",
                        @"其他":@"102",
                        },
                    @{
                        @"教授":@"98",
                        @"副教授":@"45",
                        @"讲师":@"73",
                        @"助教":@"35"
                        }];
    }else {
        NSarray = @[
                    @{
                        @"博士":@"146",
                        @"硕士":@"250",
                        @"本科":@"380",
                        @"其他":@"102",
                        },
                    @{
                        @"教授":@"198",
                        @"副教授":@"245",
                        @"讲师":@"373",
                        @"助教":@"435"
                        }];
    }
    self.dataArray = NSarray;
}

-(void)asyncWithSearch1: (NSString *)search1 andSearch2: (NSString *)search2 {
    //基本的URL地址
    NSString *urlBaseString = @"http://172.17.143.230/httpDemo1/Index?search1=%@&search2=%@";
    
    //合成新的请求字符串
    NSString *urlString = [NSString stringWithFormat:urlBaseString, search1, search2];
    
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
#pragma 绘制饼图
-(void)drawPieCharts {
    self.chartView = [[PieChartView alloc] initWithFrame:CGRectMake(7, 190, 340, 250)];
    [self setupPieChartView:_chartView];
    _chartView.delegate = self.chartView.delegate;
    _chartView.noDataText = @"Charts for kong";
    _chartView.drawCenterTextEnabled = NO; //能否显示中间文字
    _chartView.drawHoleEnabled = NO; //能否显示中间圆圈
    
    //图例
    ChartLegend *l = _chartView.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentRight; //图例的水平位置
    l.verticalAlignment = ChartLegendVerticalAlignmentCenter; //图例的垂直位置
    l.orientation = ChartLegendOrientationVertical; //图例的方向--垂直方向
    l.form = ChartLegendFormCircle; //图例的外观--圆形
    l.drawInside = NO;
//    l.xEntrySpace = 7.0; //图例的水平间隔
    l.yEntrySpace = 7.0; //图里的垂直间隔
    l.yOffset = 0.0;
    l.formSize = 15; //图例的大小
    l.maxSizePercent = 1;
    l.formToTextSpace =8;
    l.font = [UIFont systemFontOfSize: 15]; //图例的文字大小

    
    
    //entry label styling
    _chartView.entryLabelColor = UIColor.whiteColor;
    _chartView.entryLabelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.f];
    
    [_chartView animateWithXAxisDuration:1.4 easingOption:ChartEasingOptionEaseOutBack]; //打开图表时的动画时间和动画类型
    [self setDataCount];
}

- (void)setDataCount {
    int count = 4;
    parties = @[@"博士", @"硕士", @"本科", @"其他"];

    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    NSArray *yVals = @[self.dataArray[0][@"博士"], self.dataArray[0][@"硕士"], self.dataArray[0][@"本科"], self.dataArray[0][@"其他"]];
    
    for (int i = 0; i < count; i++)
    {
        [values addObject:[[PieChartDataEntry alloc] initWithValue:[yVals[i] doubleValue] label:parties[i % parties.count]]];
    }
    
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
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:13.f]];
    [data setValueTextColor:UIColor.blackColor]; //饼图中的文字颜色
    
    _chartView.data = data;
    [_chartView highlightValues:nil];
}

-(void)drawPieCharts1 {
    self.chartView1 = [[PieChartView alloc] initWithFrame:CGRectMake(13, 400, 340, 250)];
    [self setupPieChartView:_chartView1];
    _chartView1.delegate = self.chartView.delegate;
    _chartView1.noDataText = @"Charts for kong";
    _chartView1.drawCenterTextEnabled = NO; //能否显示中间文字
    _chartView1.drawHoleEnabled = NO; //能否显示中间圆圈
    
    //图例
    ChartLegend *l = _chartView1.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentRight; //图例的水平位置
    l.verticalAlignment = ChartLegendVerticalAlignmentCenter; //图例的垂直位置
    l.orientation = ChartLegendOrientationVertical; //图例的方向--垂直方向
    l.form = ChartLegendFormCircle; //图例的外观--圆形
    l.drawInside = NO;
    //    l.xEntrySpace = 7.0; //图例的水平间隔
    l.yEntrySpace = 7.0; //图里的垂直间隔
    l.yOffset = 0.0;
    l.formSize = 15; //图例的大小
    l.maxSizePercent = 1;
    l.formToTextSpace =8;
    l.font = [UIFont systemFontOfSize: 15]; //图例的文字大小
    
    
    
    //entry label styling
    _chartView1.entryLabelColor = UIColor.whiteColor;
    _chartView1.entryLabelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.f];
    
    [_chartView1 animateWithXAxisDuration:1.4 easingOption:ChartEasingOptionEaseOutBack]; //打开图表时的动画时间和动画类型
    [self setDataCount1];
}

-(void)setDataCount1 {
    int count = 4;
    parties = @[@"教授", @"副教授", @"讲师", @"助教"];
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    NSArray *yVals = @[self.dataArray[1][@"教授"], self.dataArray[1][@"副教授"], self.dataArray[1][@"讲师"], self.dataArray[1][@"助教"]];
    
    for (int i = 0; i < count; i++)
    {
        [values addObject:[[PieChartDataEntry alloc] initWithValue:[yVals[i] doubleValue] label:parties[i % parties.count]]];
    }
    
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
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:13.f]];
    [data setValueTextColor:UIColor.blackColor]; //饼图中的文字颜色
    
    _chartView1.data = data;
    [_chartView1 highlightValues:nil];
}


@end
