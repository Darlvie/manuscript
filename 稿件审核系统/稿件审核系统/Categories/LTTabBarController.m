//
//  LTTabBarController.m
//  稿件审核系统
//
//  Created by zyq on 15/11/2.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import "LTTabBarController.h"
#import "LTTabBar.h"

@interface LTTabBarController () <LTTabBarDelegate>
@property(nonatomic,weak) LTTabBar *tabBarView;
@end

@implementation LTTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTabBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTabBar {
    CGRect rect = self.tabBar.bounds;
    
    //添加自定义tabBar
    LTTabBar *tabBar = [[LTTabBar alloc]init];
    tabBar.delegate = self;
//    tabBar.frame = rect;
//    [self.tabBarView addSubview:tabBar];
//    self.tabBarView = tabBar;
    [self setValue:tabBar forKeyPath:@"tabBar"];

    
    //为控制器添加按钮
    [self.tabBarView addButtonWithTitle:@"稿件列表"];
    [self.tabBarView addButtonWithTitle:@"稿件审核"];
    [self.tabBarView addButtonWithTitle:@"我的任务"];
    
}


- (void)tabBar:(LTTabBar *)tabBar selectedFrom:(NSInteger)fromIndex to:(NSInteger)toIndex {
    self.selectedIndex = toIndex;
}
@end
