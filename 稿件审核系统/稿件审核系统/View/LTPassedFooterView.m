//
//  LTPassedFooterView.m
//  稿件审核系统
//
//  Created by zyq on 15/11/5.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import "LTPassedFooterView.h"
#import "AppDelegate.h"

@implementation LTPassedFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)passedFooterView {
    AppDelegate *app = APPDELEGATE;
    LTPassedFooterView *passedFooterView = [[[NSBundle mainBundle] loadNibNamed:@"LTPassedFooterView" owner:nil options:nil] lastObject];
    passedFooterView.backgroundColor = app.tintColor;
    return passedFooterView;
}

@end
