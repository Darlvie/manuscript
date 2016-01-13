//
//  LTLoginViewController.m
//  InewsAudit
//
//  Created by zyq on 15/11/3.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import "LTLoginViewController.h"
#import "LTUnderlineTextField.h"
#import "SVProgressHUD.h"
#import "LTAccount.h"
#import "LTAccountTool.h"
#import "LTTabBarController.h"
#import "AppDelegate.h"
#import "NSString+LT.h"
#import "UIView+Toast.h"
#import "AFNetworking.h"
#import "LTUserInfo.h"
#import "LTFileLocationHelper.h"
#import "LTNetworkingHelper.h"

@interface LTLoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *inputView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewHeightConstraint;

@property(nonatomic,strong) LTUnderlineTextField *userNameTextField;
@property(nonatomic,strong) LTUnderlineTextField *passwordTextField;
@property(nonatomic,strong) UIButton *loginButton;
@property(nonatomic,strong) LTAccount *account;
@end

@implementation LTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        
    [self setupInputView];
    
    AppDelegate *app = APPDELEGATE;
    self.headerView.backgroundColor = app.tintColor;
    [self.loginButton setBackgroundColor:app.tintColor];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.account = [LTAccountTool account];
    if (self.account) {
        self.userNameTextField.text = self.account.userName;
        self.passwordTextField.text = self.account.password;
    }
    
    [NOTIFICATION_CENTER addObserver:self
                            selector:@selector(keyboardWillShow:)
                                name:UIKeyboardWillShowNotification
                              object:nil];
    [NOTIFICATION_CENTER addObserver:self
                            selector:@selector(keyboardWillHiden:)
                                name:UIKeyboardWillHideNotification
                              object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 视图初始化
- (void)setupInputView {
    //用户名输入框
    _userNameTextField = [[LTUnderlineTextField alloc]init];
    _userNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"用户名"
                                                                               attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    _userNameTextField.delegate = self;
    _userNameTextField.returnKeyType = UIReturnKeyNext;
    _userNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_inputView addSubview:_userNameTextField];
    
    //密码输入框
    _passwordTextField = [[LTUnderlineTextField alloc]init];
    _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"密码"
                                                                               attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    _passwordTextField.delegate = self;
    _passwordTextField.returnKeyType = UIReturnKeyDone;
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_inputView addSubview:_passwordTextField];
    
    //登录按钮
    _loginButton = [[UIButton alloc]init];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginButton setBackgroundColor:RGB(112, 140, 26)];
    _loginButton.layer.cornerRadius = 5;
    _loginButton.layer.masksToBounds = YES;
    [_loginButton addTarget:self
                     action:@selector(loginButtonClick)
           forControlEvents:UIControlEventTouchUpInside];
    [_inputView addSubview:_loginButton];
    
}

#pragma mark - 视图布局
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    if (SCREEN_HEIGTH == 480) {
        self.headerViewHeightConstraint.constant = 150;
    } else if (SCREEN_HEIGTH == 667) {
        self.headerViewHeightConstraint.constant = 220;
    } else if (SCREEN_HEIGTH == 736) {
        self.headerViewHeightConstraint.constant = 250;
    }
    self.userNameTextField.frame = CGRectMake(0, 0, self.inputView.bounds.size.width, 60);
    self.passwordTextField.frame = CGRectMake(0, self.userNameTextField.bounds.size.height, self.inputView.bounds.size.width, 60);
    self.loginButton.frame = CGRectMake(0, self.inputView.bounds.size.height - 44, self.inputView.bounds.size.width, 44);
}

#pragma mark - 登录事件
- (void)loginButtonClick {

    if ([self.userNameTextField.text isEqualToString:@""] || [self.passwordTextField.text isEqualToString:@""]) {
        
        [self.view makeToast:@"用户名或密码不能为空" duration:2.0 position:CSToastPositionCenter];
        
    } else {
        
        if ([[LTNetworkingHelper sharedManager] isReachable]) {
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSString *username = self.userNameTextField.text;
        NSString *password = [self.passwordTextField.text MD5String];
        
        NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
        parameter[@"loginname"] = username;
        parameter[@"loginpswd"] = password;
        
        [SVProgressHUD show];
        
        __weak typeof(self) weakSelf = self;
        NSURLSessionDataTask *dataTask = [manager POST:kLoginUrl parameters:parameter constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [SVProgressHUD dismiss];

            NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            NSString *token = [result substringFromIndex:3];
            if (token && [token length] == 36) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    LTAccount *account = [[LTAccount alloc]init];
                    account.userName = self.userNameTextField.text;
                    account.password = self.passwordTextField.text;
                    account.autoLogin = YES;
                    [LTAccountTool saveAccount:account];
                    
                    [self getUserInfoByToken:token];
                    
                    [USERDEFAULT setObject:token forKey:MANUSCRIPT_TOKEN];
                    [USERDEFAULT synchronize];
                });
                LTTabBarController *tabBar = [[LTTabBarController alloc]init];
                [self presentViewController:tabBar animated:YES completion:nil];
            } else {
                [weakSelf.view makeToast:token
                                                     duration:2.0
                                                     position:CSToastPositionCenter];
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD dismiss];
            if (error) {
                NSLog(@"%@",error.localizedDescription);
                [weakSelf.view makeToast:error.localizedDescription
                                duration:2.0
                                position:CSToastPositionCenter];
            }
        }];

        [dataTask resume];
            
        } else {
            [self.view makeToast:@"当前网络不可用，请尝试连接网络后再试"
                        duration:2.0
                        position:CSToastPositionCenter];
        }
    }
    
}

#pragma mark - 获取userId
- (void)getUserInfoByToken:(NSString *)token {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"token"] = token;
    
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *dataTask = [manager POST:kGetUserByToken parameters:parameter constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error;
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject
                                                               options:NSJSONReadingMutableContainers
                                                                 error:&error];
        
        if (error) {
            [weakSelf.view makeToast:error.description
                            duration:2.0
                            position:CSToastPositionCenter];
            return ;
        }
        
        if ([result[@"code"] isEqualToNumber:@(-1)]) {
            [weakSelf.view makeToast:result[@"msg"]
                            duration:2.0
                            position:CSToastPositionCenter];
            return;
        }
        
//        NSLog(@"%@",result);
        
        LTUserInfo *userInfo = [LTUserInfo userInfoWithDict:result[@"obj"]];
        [USERDEFAULT setInteger:userInfo.userId forKey:USERINFO_USERID];
        [USERDEFAULT synchronize];
        
        if (userInfo) {
            NSMutableData *data = [[NSMutableData alloc] init];
            NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
            [archiver encodeObject:userInfo forKey:USERINFO];
            [archiver finishEncoding];
            NSString *filePath = [[LTFileLocationHelper getUserInfoDocumentPath] stringByAppendingPathComponent:@"userInfo.archiver"];
//            NSLog(@"%@",filePath);
            [data writeToFile:filePath atomically:YES];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"%@",error.localizedDescription);
            [weakSelf.view makeToast:error.localizedDescription
                            duration:2.0
                            position:CSToastPositionCenter];
        }
    }];
    [dataTask resume];
}


#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.userNameTextField) {
        [self.userNameTextField resignFirstResponder];
        [self.passwordTextField becomeFirstResponder];
    } else {
        [self.view endEditing:YES];
    }
    return YES;
}

#pragma mark - 键盘通知

- (void)keyboardWillShow:(NSNotification *)notification {
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] doubleValue];
    UIViewAnimationOptions option = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:duration delay:0.2 options:option animations:^{
        self.view.frame = CGRectMake(0, -130, SCREEN_WIDTH, SCREEN_HEIGTH);
    } completion:nil];
}

- (void)keyboardWillHiden:(NSNotification *)notification {
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] doubleValue];
    UIViewAnimationOptions option = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH);
    } completion:nil];
}


#pragma mark - 其它处理
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [NOTIFICATION_CENTER removeObserver:self];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
