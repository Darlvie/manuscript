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
#define kLoginUrl @"http://ipaddress:portNumber/tms/api/userApi!login.action"
//待审核稿件列表请求api
#define kGetCheckManuscriptList @"http://ipaddress:portNumber/tmc/api/manuscriptApi!getCheckManuscriptList.action"
//稿件单个实例请求api
#define kGetManuscript @"http://ipaddress:portNumber/api/manuscriptApi!getManuscript.action"
//修改稿件信息请求api
#define kGetManuscriptUpdate @"http://ipaddress:portNumber/api/manuscriptApi!getManuscriptUpdate.action"
//稿件审核请求api
#define kGetCheckManuscript @"http://ipaddress:portNumber/tmc/api/!getCheckManuscript.action"
//我的审核记录请求api
#define kGetAuditTask @"http://ipaddress:portNumber/tmc/ap/auditTasktApi!getAuditTask.action"
//我的任务请求api
#define kGetAuditTask @"http://ipaddress:portNumber/tmc/api/auditTasktApi!getAuditTask.action"
//获取稿件附件请求api
#define kGetManuscriptAttachmeny @"http://ipaddress:portNumber/tms/api/attachmentApi!getAttaByManuId.action"


















#endif /* NetworkConfig_h */
