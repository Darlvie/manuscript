//
//  LTTabBar.m
//  稿件审核系统
//
//  Created by zyq on 15/11/2.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import "LTTabBar.h"

@interface LTTabBar ()
//设置之前选中的按钮
@property (nonatomic,weak) UIButton *selectedButton;
@end

@implementation LTTabBar

- (void)addButtonWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage {
    UIButton *btn = [[UIButton alloc]init];
    
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selectedImage forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //如果是第一个按钮，则选中
    if (self.subviews.count == 1) {
        [self buttonClick:btn];
    }
}

- (void)addButtonWithTitle:(NSString *)title {
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:RGB(112, 140, 26) forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //如果是第一个按钮，则选中
    if (self.subviews.count == 1) {
        [self buttonClick:btn];
    }
}


- (void)buttonClick:(UIButton *)btn {
    LTLog(@"点击了");
    //先将之前选中的按钮设置为未选中
    self.selectedButton.selected = NO;
    
    //将当前按钮设置为选中
    btn.selected = YES;
    
    [btn setBackgroundColor:RGB(112, 140, 27)];
    
    if ([self.delegate respondsToSelector:@selector(tabBar:selectedFrom:to:)]) {
        [self.delegate tabBar:self selectedFrom:self.selectedButton.tag to:btn.tag];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    for (int i = 0; i < count; i ++) {
        //取得按钮
        UIButton *btn = self.subviews[i];
        btn.tag = i;
        CGFloat btnX = i * self.bounds.size.width / count;
        CGFloat btnY = 0;
        CGFloat btnW = self.bounds.size.width / count;
        CGFloat btnH = self.bounds.size.height;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}

@end
