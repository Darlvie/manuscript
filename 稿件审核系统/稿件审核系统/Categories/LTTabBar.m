//
//  LTTabBar.m
//  稿件审核系统
//
//  Created by zyq on 15/11/2.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import "LTTabBar.h"
#import "LTTabBarItem.h"
#import "AppDelegate.h"

@interface LTTabBar ()
//设置之前选中的按钮
@property (nonatomic,weak) UIButton *selectedButton;
@property (nonatomic,strong) AppDelegate *app;
@end

@implementation LTTabBar

- (instancetype)init {
    if (self = [super init]) {
        [NOTIFICATION_CENTER addObserver:self selector:@selector(tintColorDidChange:) name:TINTCOLOR_DID_CHANGED object:nil];
    }
    return self;
}

//接收颜色改变通知后改变tabBar主题颜色
- (void)tintColorDidChange:(NSNotification *)noti {
    UIColor *color = noti.userInfo[@"tintColor"];
    
    for (LTTabBarItem *item in self.subviews) {
        [item setBackgroundColor:[UIColor whiteColor]];
        [item setTitleColor:color forState:UIControlStateNormal];
        if (item.tag  == self.selectedButton.tag) {
            [item setBackgroundColor:color];
            [item setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        }
    }
    
}

//添加tabBarItem
- (void)addButtonWithTitle:(NSString *)title {
    LTTabBarItem *btn = [[LTTabBarItem alloc]init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]];
    
    self.app = APPDELEGATE;
    [btn setTitleColor:self.app.tintColor forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
    //如果是第一个按钮，则选中
    if (self.subviews.count == 1) {
        [self buttonClick:btn];
    }
}


- (void)buttonClick:(UIButton *)btn {    
    //先将之前选中的按钮设置为未选中
    self.selectedButton.selected = NO;    
    self.selectedButton = btn;
    
    //将当前按钮设置为选中
    btn.selected = YES;
    [btn setBackgroundColor:self.app.tintColor];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    for (LTTabBarItem *button in self.subviews) {
        if (button != btn) {
            [button setBackgroundColor:[UIColor whiteColor]];
            [button setTitleColor:self.app.tintColor forState:UIControlStateSelected];
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(tabBar:selectedFrom:to:)]) {
        [self.delegate tabBar:self selectedFrom:self.selectedButton.tag to:btn.tag];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    
    for (int i = 0; i < count; i ++) {
        //取得按钮
        LTTabBarItem *btn = self.subviews[i];
        btn.tag = i;
        CGFloat btnX = i * self.bounds.size.width / count;
        CGFloat btnY = 0;
        CGFloat btnW = self.bounds.size.width / count;
        CGFloat btnH = self.bounds.size.height;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}

- (void)dealloc {
    [NOTIFICATION_CENTER removeObserver:self];
}

@end
