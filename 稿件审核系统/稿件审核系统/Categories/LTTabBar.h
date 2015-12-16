//
//  LTTabBar.h
//  稿件审核系统
//
//  Created by zyq on 15/11/2.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LTTabBar;
@protocol LTTabBarDelegate <NSObject>
/** 工具栏按钮被选中, 记录从哪里跳转到哪里 */
- (void)tabBar:(LTTabBar *)tabBar selectedFrom:(NSInteger)fromIndex to:(NSInteger)toIndex;

@end


@interface LTTabBar : UIView
@property (nonatomic,weak) id<LTTabBarDelegate> delegate;

- (void)addButtonWithTitle:(NSString *)title;
@end
