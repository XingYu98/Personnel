//
//  LoginVC.m
//  Personnel
//
//  Created by 罗星宇 on 2018/7/3.
//  Copyright © 2018年 罗星宇. All rights reserved.
//

#import "LoginVC.h"
#import "FaceVC.h"
#import "MBProgressHUD+XMG.h"

@interface LoginVC ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UINavigationItem *NavigationBar;
@property (nonatomic, strong) NSString *loginStatus;
@property (nonatomic, strong) NSString *token;


@end

@implementation LoginVC


- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationController setNavigationBarHidden:YES animated:NO];
    // Do any additional setup after loading the view.
    
    //设置文本框代理
    _usernameField.delegate = self.usernameField.delegate;
    _passwordField.delegate = self.passwordField.delegate;
    
    //及时监听文本框输入
    [_usernameField addTarget:self action:@selector(usernameFieldTextChange) forControlEvents:UIControlEventEditingChanged];
    [_passwordField addTarget:self action:@selector(passwordFieldTextChange) forControlEvents:UIControlEventEditingChanged];
    
    //加载logo动画
    [self loadLogoView];
}

- (IBAction)loginAction:(id)sender {
    
    if (![self.usernameField.text  isEqual:@""] && ![self.passwordField.text  isEqual: @""]) {
        [MBProgressHUD showMessage:@"登陆中..."];
        //延迟1秒就会调用代码块的东西
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //弹出蒙版，在登陆期间，不允许用户交互
            [MBProgressHUD hideHUD];
            
            //1.测试用的请求方法 fakeAsync
            //2.运行用的请求方法 async
            [self fakeAsyncWithUsername:self.usernameField.text andPassword:self.passwordField.text];
            
            //如果返回的self.loginStatus == success，则登陆成功
            if ([self.loginStatus isEqual: @"success"]) {
                [self performSegueWithIdentifier:@"loginContact" sender:nil];
            }
            else if([self.loginStatus isEqual: @"error"]){
                [MBProgressHUD showError: @"账号或密码错误"];
            }else {
                [MBProgressHUD showError: @"请求超时"];
            }
        });
    }else {
        [MBProgressHUD showError:@"请输入账号或密码"];
    }
}

#pragma 请求方式
-(void)fakeAsyncWithUsername: (NSString *)username andPassword: (NSString *)password {
    if ([username isEqual:@"123"] && [password isEqual:@"123"]) {
        //可以通过请求获得Dictionary, 先假设收到的Dictionary
        NSDictionary *dict = @{
                               @"status":@"success",
                               @"token":@"tokentokentokenQQQ",
                               @"request":@[
                                       @{
                                           @"总人数":@"678",
                                           @"教师人数":@"456",
                                           @"博士":@"45",
                                           @"硕士":@"123"
                                           },
                                       @{
                                           @"当前年份-4的总人数":@"123",
                                           @"当年年份-4的教师人数":@"234",
                                           @"当前年份-4的博士人数":@"12",
                                           @"当前年份-4的硕士人数":@"34"
                                           },
                                       @{
                                           @"当前年份-3的总人数":@"123",
                                           @"当年年份-3的教师人数":@"234",
                                           @"当前年份-3的博士人数":@"12",
                                           @"当前年份-3的硕士人数":@"34"
                                           },
                                       @{
                                           @"当前年份-2的总人数":@"123",
                                           @"当年年份-2的教师人数":@"234",
                                           @"当前年份-2的博士人数":@"12",
                                           @"当前年份-2的硕士人数":@"34"
                                           },
                                       @{
                                           @"当前年份-1的总人数":@"123",
                                           @"当年年份-1的教师人数":@"234",
                                           @"当前年份-1的博士人数":@"12",
                                           @"当前年份-1的硕士人数":@"34"
                                           }
                                       ]
                               };
        
        self.loginStatus = dict[@"status"];
        self.token = dict[@"token"];
    }else {
        self.loginStatus = @"error";
    }
    
}

-(void)asyncWithUsername: (NSString *)username andPassword: (NSString *)password {
    //基本的URL地址
    NSString *urlBaseString = @"http://172.17.143.230/httpDemo1/Index?style=1&username=%@&password=%@";
    
    //合成新的请求字符串
    NSString *urlString = [NSString stringWithFormat:urlBaseString, username, password];
    
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

#pragma 监听文本框的action
-(void)usernameFieldTextChange {
    NSLog(@"%@", _usernameField.text);
}
-(void)passwordFieldTextChange {
    NSLog(@"%@", _passwordField.text);
}
#pragma 监听textField代码
-(void)textChange {
    //账号和密码（6位），同时输入才能点击登陆
    if (_usernameField.text.length && _passwordField.text.length) {
        [self testPrint];
    }else {
        //        _LoginBtn.enabled = NO;
    }
    NSLog(@"%@", _usernameField.text);
    NSLog(@"%@",_passwordField.text);
}

#pragma segue传值代码
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    FaceVC *faceVc = segue.destinationViewController;
    faceVc.username = self.usernameField.text;
    faceVc.token = self.token;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)testPrint{
    NSLog(@"success");
}


//*****************************动画*****************************//
#pragma 导航条的动态效果
-(void)viewDidAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];

}
#pragma logo动画
-(void)loadLogoView {
    //logo动画
    UIImageView *logoV = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 360, 350)];
    logoV.image = [UIImage imageNamed:@"logo"];
    logoV.alpha = 0.f;
    
    [UIView transitionWithView:logoV duration:1.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        logoV.frame = CGRectMake(76, 75, 222, 209);
        logoV.alpha = 1.f;
    } completion:^(BOOL finished) {
        
    }];
    [self.view addSubview:logoV];
}

@end
