//
//  RegisterViewController.m
//  Feldsher
//
//  Created by 李雨龙 on 16/8/8.
//  Copyright © 2016年 cike. All rights reserved.
//

#import "RegisterViewController.h"
#import <HYBNetworking/HYBNetworking.h>

@interface RegisterViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.avatarImageView.userInteractionEnabled = YES;
    [self.avatarImageView.layer setBorderColor:(__bridge CGColorRef _Nullable)([UIColor grayColor])];
    [self.avatarImageView.layer setBorderWidth:2];
    [self.avatarImageView.layer setBorderWidth:0];
    [self.avatarImageView.layer setCornerRadius:self.avatarImageView.frame.size.height * 0.5];
    [self.avatarImageView.layer setMasksToBounds:YES];
    UITapGestureRecognizer *tapPhotoGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alterHeadPortrait:)];
    [self.avatarImageView addGestureRecognizer:tapPhotoGestureRecognizer];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.maleBtn setBackgroundColor:[UIColor yellowColor]];
}

-(void) keyboardHide:(UITapGestureRecognizer*)tap{
    [self.mailTextField resignFirstResponder];
    [self.nameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

-(void)alterHeadPortrait:(UITapGestureRecognizer *)gesture
{
    NSLog(@"fsadfads");
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        
        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        PickerImage.allowsEditing = YES;
        PickerImage.delegate = self;
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
        PickerImage.allowsEditing = YES;
        PickerImage.delegate = self;
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    self.avatarImageView.image = newPhoto;
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)maleBtnAction:(id)sender {
    [self.maleBtn setBackgroundColor:[UIColor yellowColor]];
    
    [self.famaleBtn setBackgroundColor:[UIColor whiteColor]];
}
- (IBAction)famaleBtnAction:(id)sender {
    [self.maleBtn setBackgroundColor:[UIColor whiteColor]];
    
    [self.famaleBtn setBackgroundColor:[UIColor yellowColor]];
}
- (IBAction)registerBtnAction:(id)sender {
    
    NSString *gender = [[NSString alloc] init];
    if (self.maleBtn.backgroundColor == [UIColor yellowColor]) {
        gender = @"Male";
    }else{
        gender = @"Famale";
    }
    NSLog(@"%@",gender);
    
    
    NSDictionary *postDict = @{ @"email": self.mailTextField.text,
                                @"password": self.passwordTextField.text,
                                @"name": self.nameTextField.text,
                                @"gender":gender,
                                @"age":@"21",
                                };
    NSString *path = @"/users/signup/";
    [HYBNetworking updateBaseUrl:@"http://192.168.191.1:8888/"];
    __weak __typeof(self)weakSelf = self;
    [HYBNetworking postWithUrl:path refreshCache:YES params:postDict success:^(id response) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注册成功"message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"hahah");
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }];
                [alert addAction:okAction];
        [strongSelf presentViewController:alert animated:YES completion:nil];
        
        
    } fail:^(NSError *error) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注册失败"message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        [strongSelf presentViewController:alert animated:YES completion:nil];
    }];
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
