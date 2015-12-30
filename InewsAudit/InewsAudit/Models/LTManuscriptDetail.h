//
//  LTManuscriptDetail.h
//  InewsAudit
//
//  Created by zyq on 15/12/29.
//  Copyright © 2015年 BGXT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTManuscriptDetail : NSObject
/** 稿件ID */
@property (nonatomic,assign) int manuscriptId;
/** 作者 */
@property (nonatomic,copy) NSString *author;
/** 联系电话 */
@property (nonatomic,copy) NSString *contact;
/** 邮箱 */
@property (nonatomic,copy) NSString *email;
/** 部门 */
@property (nonatomic,copy) NSString *department;
/** 分类 */
@property (nonatomic,copy) NSString *category;
/** 发稿地址 */
@property (nonatomic,copy) NSString *sendLocation;
/** 事发时间 */
@property (nonatomic,strong) NSDate *occurTime;
/** 标题 */
@property (nonatomic,copy) NSString *title;
/** 内容 */
@property (nonatomic,copy) NSString *content;
/** 接收时间 */
@property (nonatomic,strong) NSDate *reciveTime;
/** 状态 */
@property (nonatomic,copy) NSString *status;
/** 类型 */
@property (nonatomic,copy) NSString *type;
/** 栏目名称 */
@property (nonatomic,copy) NSString *columnName;


@end
