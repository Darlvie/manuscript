//
//  LTFailPassFooterView.m
//  InewsAudit
//
//  Created by zyq on 15/11/5.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import "LTFailPassFooterView.h"

@implementation LTFailPassFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)failPassFooterView {
    return [[[NSBundle mainBundle] loadNibNamed:@"LTFailPassFooterView" owner:nil options:nil] lastObject];
    
}

@end
