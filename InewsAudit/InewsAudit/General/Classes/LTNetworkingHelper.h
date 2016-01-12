//
//  LTNetworkingHelper.h
//  InewsAudit
//
//  Created by hooper on 1/4/16.
//  Copyright © 2016 BGXT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTNetworkingHelper : NSObject

+ (instancetype)sharedManager;

- (void)startCheckingNetwork;

- (BOOL)isReachable;

- (void)updateManuscriptStateWithToken:(NSString *)token status:(NSString *)status taskId:(int)taskId;

- (void)updateManuscript:(NSDictionary *)param success:(void(^)(id responseDic))success fail:(void(^)(NSError *error))fail;

- (void)auditManuscriptWithToken:(NSString *)token status:(NSString *)status taskId:(int)taskId;

- (void)auditManuscript:(NSDictionary *)param success:(void(^)(id responseDic))success fail:(void(^)(NSError *error))fail;

@end
