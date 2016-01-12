//
//  LTTabBarController.m
//  InewsAudit
//
//  Created by zyq on 15/11/2.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import "LTTabBarController.h"
#import "LTNavigationController.h"
#import "LTTabBar.h"
#import "LTManuscriptListController.h"
#import "LTManuscriptAuditController.h"
#import "LTMyTaskController.h"
#import "LTSettingViewController.h"

@interface LTTabBarController () <LTTabBarDelegate>

@end

@implementation LTTabBarController

- (void)viewDidLoad {
     [super viewDidLoad];   
    
    
    LTManuscriptListController *manuscriptListVC = [[LTManuscriptListController alloc]init];
    [self addChildViewController:manuscriptListVC title:@"稿件列表"];
    
    LTMyTaskController *myTaskVC = [[LTMyTaskController alloc]init];
    [self addChildViewController:myTaskVC title:@"我的任务"];
    
    LTManuscriptAuditController *manuscriptVerifyVC = [[LTManuscriptAuditController alloc]init];
    [self addChildViewController:manuscriptVerifyVC title:@"审核记录"];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupTabBar];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title {
    
    LTNavigationController *navi = [[LTNavigationController alloc]initWithRootViewController:childController];
    [self addChildViewController:navi];
    
}

- (void)setupTabBar {    
    CGRect rect = CGRectMake(0, SCREEN_HEIGTH - 49, SCREEN_WIDTH, 49);
    
    //添加自定义tabBar
    LTTabBar *tabBarView = [[LTTabBar alloc]init];
    tabBarView.delegate = self;
    tabBarView.frame = rect;
    self.tabBar.hidden = YES;
    [self.view addSubview:tabBarView];
    
    //为控制器添加按钮
    [tabBarView addButtonWithTitle:@"稿件列表"];
    [tabBarView addButtonWithTitle:@"我的任务"];
    [tabBarView addButtonWithTitle:@"审核记录"];
    
}

#pragma mark - LTTabBarDelegate
- (void)tabBar:(LTTabBar *)tabBar selectedFrom:(NSInteger)fromIndex to:(NSInteger)toIndex {
    self.selectedIndex = toIndex;
}
@end
