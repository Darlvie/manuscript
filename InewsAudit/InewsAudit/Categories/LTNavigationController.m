//
//  LTNavigationController.m
//  RCS
//
//  Created by zyq on 15/10/22.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import "LTNavigationController.h"
#import "AppDelegate.h"

@interface LTNavigationController ()

@end

@implementation LTNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [NOTIFICATION_CENTER addObserver:self selector:@selector(tintColorDidChange:) name:TINTCOLOR_DID_CHANGED object:nil];
    
    //设置整个项目所有item的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    //设置普通状态下的样式
    NSMutableDictionary *textAttrs= [NSMutableDictionary dictionary];
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTintColor:[UIColor whiteColor]];
    
    //设置导航栏背景
    UINavigationBar *bar = [UINavigationBar appearance];
    AppDelegate *app = APPDELEGATE;
    [bar setBarTintColor:app.tintColor];
 
    
    [bar setTitleTextAttributes:textAttrs];    

}

- (void)tintColorDidChange:(NSNotification *)noti {
    UIColor *color = noti.userInfo[@"tintColor"];
    
    [self.navigationBar setBarTintColor:color];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//重写导航控制器的push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) { //这时push进来的导航控制器不是根控制器
        //push出控制器时自动隐藏tabBar
//        viewController.hidesBottomBarWhenPushed = YES;        
        
        //自定义左侧返回按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
                
    }
    
    [super pushViewController:viewController animated:animated];
    
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

/**
 *  设置状态栏风格
 */
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)dealloc {
    [NOTIFICATION_CENTER removeObserver:self];
}
@end
