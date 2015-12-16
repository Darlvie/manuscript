//
//  LTModifyAccountController.m
//  稿件审核系统
//
//  Created by zyq on 15/11/4.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import "LTModifyAccountController.h"
#import "LTLoginViewController.h"
#import "SVProgressHUD.h"
#import "LTAccount.h"
#import "LTAccountTool.h"
#import "AppDelegate.h"

@interface LTModifyAccountController () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *changeUserNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *changePasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *repeatChangePasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@end

@implementation LTModifyAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Modify Account", @"Modify Account");
    
    AppDelegate *app = APPDELEGATE;
    self.saveButton.layer.cornerRadius = 5;
    self.saveButton.layer.masksToBounds = YES;
    [self.saveButton setBackgroundColor:app.tintColor];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSArray *array = self.tabBarController.view.subviews;
    UIView *tabBarView = array.lastObject;    
    tabBarView.frame = CGRectMake(0, SCREEN_HEIGTH, SCREEN_WIDTH, 49);
    
    //修复右滑导航不返回
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//保存修改账户
- (IBAction)saveAccountButtonClick {
    if ([self.changeUserNameTextField.text isEqualToString:@""] || [self.changePasswordTextField.text isEqualToString:@""] || [self.repeatChangePasswordTextField.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"ModifyAccountEmptyError", @"User name or password can not be empty")
                                  maskType:SVProgressHUDMaskTypeBlack];
    } else if (![self.changePasswordTextField.text isEqualToString:self.repeatChangePasswordTextField.text]) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"ModifyAccountShowError", @"The two passwords do not match")
                                  maskType:SVProgressHUDMaskTypeBlack];
    } else {
        [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"ModifyAccountShowSaveSuccess", @"ModifyAccountShowSaveSuccess")
                                    maskType:SVProgressHUDMaskTypeBlack];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            LTAccount *account = [[LTAccount alloc]init];
            account.userName = self.changeUserNameTextField.text;
            account.password = self.changePasswordTextField.text;
            account.autoLogin = NO;
            [LTAccountTool saveAccount:account];
        });
        
        LTLoginViewController *loginVC = [[LTLoginViewController alloc] initWithNibName:@"LTLoginViewController" bundle:nil];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}



@end
