//
//  LTAccountTool.h
//  InewsAudit
//
//  Created by zyq on 15/11/3.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LTAccount;
@interface LTAccountTool : NSObject
//返回账号信息
+ (LTAccount *)account;
//存储账号信息
+ (void)saveAccount:(LTAccount *)account;
@end
