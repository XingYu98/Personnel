//
//  sanjiInforVC.m
//  Personnel
//
//  Created by 罗星宇 on 2018/7/17.
//  Copyright © 2018年 罗星宇. All rights reserved.
//

#import "sanjiInforVC.h"
#import "informationTVC.h"
#import "inforTV.h"

@interface sanjiInforVC ()
@property (weak, nonatomic) IBOutlet UITableView *smallTableView;

@property (strong, nonatomic) IBOutlet UILabel *perNum;
@property (nonatomic, strong) NSDictionary *dataDict;
@property (nonatomic, strong) NSArray *dataArray;

//要传递的数据
@property (nonatomic, strong) NSString *xm;
@property (nonatomic, strong) NSString *bm;
@property (nonatomic, strong) NSString *zgxw;
@property (nonatomic, strong) NSString *sjjg;
@property (nonatomic, strong) NSString *jszwzg;
@end

@implementation sanjiInforVC


-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fakeAsync];
    self.perNum.text = self.dataDict[@"perNum"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma 情求数据
-(void)fakeAsync {
    NSDictionary *dict = nil;
    
    dict = @{
        @"status":@"success",
        @"perNum":@"345",   //num-request的个数
        @"request":@[
                   @{
                       @"jszwzg": @"助教",
                       @"bm": @"党委办公室（党委宣传部、统战部）",
                       @"zgxw": @"硕士",
                       @"sjjg": @"网络工程教研室",
                       @"xm": @"王爱敏",
                   },
                   @{
                       @"jszwzg": @"助教",
                       @"bm": @"党委组织部（党校）",
                       @"zgxw": @"硕士",
                       @"sjjg": @"网络工程教研室",
                       @"xm": @"王维新",
                   }
                   ]
        };
    
    self.dataDict = dict;
    self.dataArray = dict[@"request"];
}

-(void)asyncWithFirstInf:(NSString *)firstInf andSecond:(NSString *)secondInf andThird:(NSString *)thirdInf {
    //基本的URL地址
    NSString *urlBaseString = @"http://172.17.143.230/httpDemo1/Index?style=1&firstInf=%@&secondInf=%@&thtrdInf=%@";
    
    //合成新的请求字符串
    NSString *urlString = [NSString stringWithFormat:urlBaseString, firstInf, secondInf, thirdInf];
    
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    //tableView = _smallTableView;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementations return the number of rows
    //tableView = _smallTableView;
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //tableView = _smallTableView;
    static NSString *ID = @"cell";
    
    //1.创建cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    //拿到该行cell对应的数据
    cell.textLabel.text = self.dataArray[indexPath.row][@"xm"];
    
    //3.返回cell
    return cell;
}

//获取当前的cell信息
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *transFormDict = self.dataArray[indexPath.row];
    self.xm = transFormDict[@"xm"];
    self.bm = transFormDict[@"bm"];
    self.zgxw = transFormDict[@"zgxw"];
    self.sjjg = transFormDict[@"sjjg"];
    self.jszwzg = transFormDict[@"jszwzg"];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //获取table和IndexPath参数
//    NSIndexPath *setIndex = [self.smallTableView indexPathForSelectedRow];
//    
//    inforTV *tableView = [[inforTV alloc] init];
//    
//    [self tableView:tableView didSelectRowAtIndexPath:setIndex];

    
    informationTVC *inforTVC = segue.destinationViewController;
    inforTVC.xm = self.xm;
    inforTVC.bm = self.bm;
    inforTVC.zgxw = self.zgxw;
    inforTVC.sjjg = self.sjjg;
    inforTVC.jszwzg = self.jszwzg;
}
@end
