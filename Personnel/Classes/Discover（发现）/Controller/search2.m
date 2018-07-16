//
//  search2.m
//  Personnel
//
//  Created by 罗星宇 on 2018/7/15.
//  Copyright © 2018年 罗星宇. All rights reserved.
//

#import "search2.h"

@interface search2() <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSArray *Section;
@property (nonatomic, strong) NSDictionary *dataDict;
@end

@implementation search2

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setUp];
}

-(void)setUp
{
    //创建pickerView
    UIPickerView *pickerView = [[UIPickerView alloc] init];

    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    [pickerView setBackgroundColor:[UIColor whiteColor]];
    //自定义文本框键盘
    self.inputView = pickerView;

    [self fakeAsync];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self resignFirstResponder];
    return YES;
}


#pragma 请求数据
- (void)fakeAsync {
    NSDictionary * dict =
    @{
        @"status":@"success",
        @"token":@"tokentokentokenQQQ",
        @"request":@{
            @"部门系别":@[
                       @"",
                       @"党委",
                       @"党组织部",
                       @"信息系"
                       ],
            @"籍贯":@[
                     @"",
                     @"北京",
                     @"河北",
                     @"山西"
                     ],
            @"进校时间":@[
                    @"",
                    @"2017",
                    @"2016",
                    @"2015"
                    ]
                }
        };
    self.dataDict = dict;
}

#pragma mark - 数据源方法
//PickerView   1列
-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
//第0列   描述搜索类型   行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    _Section = _dataDict[@"request"][self.text];
    return _Section.count;
}

//返回第compon列第row行的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _Section[row];
}
//监听PickView的选中
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *str = _Section[row];
    self.text = str;
    self.textColor = [UIColor blackColor];
}

@end
