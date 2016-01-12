//
//  LTUserInfo.h
//  InewsAudit
//
//  Created by hooper on 12/31/15.
//  Copyright © 2015 BGXT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTUserInfo : NSObject <NSCoding>

/** 用户id **/
@property (nonatomic,assign) int userId;
/** 身份证号 **/
@property (nonatomic,copy) NSString *idCard;
/** 密码 **/
@property (nonatomic,copy) NSString *password;
/** 姓 **/
@property (nonatomic,copy) NSString *lastName;
/** 名 **/
@property (nonatomic,copy) NSString *firstName;
/** 邮箱 **/
@property (nonatomic,copy) NSString *email;
/** 电话 **/
@property (nonatomic,copy) NSString *phone;
/** 手机 **/
@property (nonatomic,copy) NSString *mobile;
/** 用户类型（B2B/B2C） **/
@property (nonatomic,copy) NSString *userType;
/** 描述 **/
@property (nonatomic,copy) NSString *desc;
/** 头衔 **/
@property (nonatomic,copy) NSString *honour;

+ (instancetype)userInfoWithDict:(NSDictionary *)dict;

@end
