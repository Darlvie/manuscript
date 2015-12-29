//
//  LTManuscriptVerifyFooterView.h
//  InewsAudit
//
//  Created by zyq on 15/11/5.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  LTManuscriptVerifyFooterViewDelegate <NSObject>

- (void)passButtonDidClick:(id)sender;
- (void)noPassButtonClick:(id)sender;

@end

@interface LTManuscriptVerifyFooterView : UIView
@property (weak, nonatomic) IBOutlet UIButton *noPassButton;
@property (weak, nonatomic) IBOutlet UIButton *passButton;
@property (nonatomic,assign) id<LTManuscriptVerifyFooterViewDelegate> delegate;

+ (instancetype)manuscriptVerifyFooterView;
@end
