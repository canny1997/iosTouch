//
//  ViewController.m
//  ios指纹识别
//
//  Created by TOPTEAM on 16/9/13.
//  Copyright © 2016年 TOPTEAM. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor orangeColor];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1. 判断iOS8.0及以上版本  从iOS8.0开始才有的指纹识别
    if (!([UIDevice currentDevice].systemVersion.floatValue >= 8.0)) {
        NSLog(@"当前系统暂不支持指纹识别");
        return;
    }
    
    // 2. 创建LAContext对象 --> 本地验证对象上下文
    LAContext *context = [LAContext new];
    
    // 3.判断用户是否设置了Touch ID
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil]) {
        //4. 开始使用指纹识别
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"指纹验证登录" reply:^(BOOL success, NSError *error) {
            //4.1 验证成功
            if (success) {
                NSLog(@"验证成功");
                UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"验证成功" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
                [alert show];
            }
            
            //4.2 验证失败
            NSLog(@"error: %ld",error.code);
            
            if (error.code == -2) {
                NSLog(@"用户自己取消");
            }
            
            if (error.code != 0 && error.code != -2) {
                NSLog(@"验证失败");
            }
        }];
    } else {
        NSLog(@"请先设置Touch ID");
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
