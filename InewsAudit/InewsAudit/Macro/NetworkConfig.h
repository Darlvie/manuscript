//
//  NetworkConfig.h
//  InewsAudit
//
//  Created by zyq on 15/12/29.
//  Copyright © 2015年 BGXT. All rights reserved.
//

#ifndef NetworkConfig_h
#define NetworkConfig_h

//用户登录请求api
#define kLoginUrl @"http://10.255.20.60/cm/uServices!login.action"
//待审核稿件列表请求api
#define kGetCheckManuscriptList @"http://10.255.20.60/cm/manuscriptApi!getCheckManuscriptList.action"
//稿件单个实例请求api
#define kGetManuscript @"http://10.255.20.60/cm/manuscriptApi!getManuscript.action"
//修改稿件信息请求api
#define kGetManuscriptUpdate @"http://10.255.20.60/cm/manuscriptApi!getManuscriptUpdate.action"
//稿件审核请求api
#define kGetCheckManuscript @"http://10.255.20.60/cm/manuscriptApi!getCheckManuscript.action"
//我的审核记录请求api
//#define kGetAuditTask @"http://10.255.20.60/cm/auditTaskApi!getAuditTask.action"
//我的任务请求api
#define kGetAuditTask @"http://10.255.20.60/cm/auditTaskApi!getAuditTask.action"
//获取稿件附件请求api
#define kGetManuscriptAttachmeny @"http://10.255.20.60/cm/attachmentApi!getAttaByManuId"


















#endif /* NetworkConfig_h */
