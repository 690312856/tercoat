//
//  RegisterViewController.h
//  Feldsher
//
//  Created by 李雨龙 on 16/8/8.
//  Copyright © 2016年 cike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *mailTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIButton *maleBtn;
@property (weak, nonatomic) IBOutlet UIButton *famaleBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;


@end
