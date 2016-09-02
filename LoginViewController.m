//
//  LoginViewController.m
//  Feldsher
//
//  Created by 李雨龙 on 16/8/8.
//  Copyright © 2016年 cike. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import <HYBNetworking/HYBNetworking.h>


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.mailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}


- (IBAction)loginBtnAction:(id)sender {
    
    
    NSDictionary *postDict = @{ @"username": self.mailTextField.text,
                                @"password" : self.passwordTextField.text,
                                };
    NSString *path = @"/users/login/";
    [HYBNetworking updateBaseUrl:@"http://192.168.191.1:8888/"];
    __weak __typeof(self)weakSelf = self;
    //NSDictionary *temp = @{@"Authorization":@"Token fjaksdfhsakj",};
    //[HYBNetworking configCommonHttpHeaders:temp];
    [HYBNetworking postWithUrl:path refreshCache:YES params:postDict success:^(id response) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:strongSelf.passwordTextField.text forKey:@"password"];
        [defaults setObject:response[@"email"] forKey:@"username"];
        [defaults setObject:response[@"gender"] forKey:@"gender"];
        [defaults setObject:response[@"name"] forKey:@"name"];
        [defaults setObject:response[@"token"] forKey:@"token"];
        [defaults synchronize];
        
        //创建通知
        NSNotification *notification =[NSNotification notificationWithName:@"loginSuccess" object:nil userInfo:nil];
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    } fail:^(NSError *error) {
        NSLog(@"登录失败");
    }];
    
}

- (IBAction)registerBtnAction:(id)sender {

    RegisterViewController *vc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)forgetBtnAction:(id)sender {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
