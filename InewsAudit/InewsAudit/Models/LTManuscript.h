//
//  LTManuscript.h
//  InewsAudit
//
//  Created by zyq on 15/11/4.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ManuscriptType) {
    ManuscriptTypeTxt,
    ManuscriptTypePhoto,
    ManuscriptTypeRecord,
    ManuscriptTypeVideo
};

typedef NS_ENUM(NSUInteger, ManuscriptState) {
    ManuscriptStateEntering,
    ManuscriptStateVerifying,
    ManuscriptStateUnfinished,
    ManuscriptStateFailPass,
    ManuscriptStatePassed
};

@interface LTManuscript : NSObject

/** 稿件标题 */
@property(nonatomic,copy) NSString *title;
/** 稿件类型 */
@property(nonatomic,assign) ManuscriptType type;
/** 稿件状态 */
@property(nonatomic,assign) ManuscriptState state;
/** 稿件ID */
@property(nonatomic,copy) NSString *sID;
/** 稿件作者 */
@property(nonatomic,copy) NSString *author;
/** 入库用户 */
@property(nonatomic,copy) NSString *enterUser;
/** 部门 */
@property(nonatomic,copy) NSString *department;
/** 发稿时间 */
@property(nonatomic,copy) NSString *timeStamp;
/** 稿件通道 */
@property(nonatomic,copy) NSString *channel;
/** 发稿设备号 */
@property(nonatomic,copy) NSString *device;


+ (instancetype)manuscriptWithDict:(NSDictionary *)dict;
@end
