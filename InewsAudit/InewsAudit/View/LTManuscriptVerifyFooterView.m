//
//  LTManuscriptVerifyFooterView.m
//  InewsAudit
//
//  Created by zyq on 15/11/5.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import "LTManuscriptVerifyFooterView.h"
#import "AppDelegate.h"

@implementation LTManuscriptVerifyFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)manuscriptVerifyFooterView {
    AppDelegate *app = APPDELEGATE;
    LTManuscriptVerifyFooterView *MVFV = [[[NSBundle mainBundle] loadNibNamed:@"LTManuscriptVerifyFooterView" owner:nil options:nil] lastObject];
    
    [MVFV.passButton setBackgroundColor:app.tintColor];
    return MVFV;
}


@end
