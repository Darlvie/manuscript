//
//  LTManuscriptVerifyFooterView.h
//  稿件审核系统
//
//  Created by zyq on 15/11/5.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTManuscriptVerifyFooterView : UIView
@property (weak, nonatomic) IBOutlet UIButton *noPassButton;
@property (weak, nonatomic) IBOutlet UIButton *passButton;


+ (instancetype)manuscriptVerifyFooterView;
@end
