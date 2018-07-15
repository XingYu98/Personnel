//
//  search1.m
//  Personnel
//
//  Created by 罗星宇 on 2018/7/15.
//  Copyright © 2018年 罗星宇. All rights reserved.
//

#import "search1.h"

@interface search1 ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSArray *Option;
@end

@implementation search1

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
    //[self async];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    //自定义文本框键盘
    self.inputView = pickerView;
    [self fakeAsync];
}
#pragma 请求数据
-(void)fakeAsync {
    NSArray *array = @[@"",@"部门系别",@"进校时间",@"籍贯"];
    self.Option = array;
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
    
    return _Option.count;
    
}

//返回第compon列第row行的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
//    NSString *str = _Option[row];
//    self.text = str;
    return _Option[row];
}


//监听PickView的选中
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *str = _Option[row];
    self.text = str;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
