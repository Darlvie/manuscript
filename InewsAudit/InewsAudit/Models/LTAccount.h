//
//  LTAccount.h
//  InewsAudit
//
//  Created by zyq on 15/11/3.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTAccount : NSObject <NSCoding>

@property(nonatomic,copy) NSString *userName;
@property(nonatomic,copy) NSString *password;

@property(nonatomic,assign,getter=isAutoLogin) BOOL autoLogin;
@end
