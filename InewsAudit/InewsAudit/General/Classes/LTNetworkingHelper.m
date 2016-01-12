//
//  LTNetworkingHelper.m
//  InewsAudit
//
//  Created by hooper on 1/4/16.
//  Copyright © 2016 BGXT. All rights reserved.
//

#import "LTNetworkingHelper.h"
#import "AFNetworkReachabilityManager.h"
#import "AFNetworking.h"

@interface LTNetworkingHelper ()

@property (nonatomic,assign) BOOL isConnectionNet;

@end


@implementation LTNetworkingHelper

+ (instancetype)sharedManager {
    static LTNetworkingHelper *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LTNetworkingHelper alloc] init];
        
    });
    return instance;
}


- (void)startCheckingNetwork {

    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    __weak typeof(self) weakSelf = self;
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未识别网络");
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"不可达的网络（未连接）");
                weakSelf.isConnectionNet = NO;
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"2G,3G,4G...网络");
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi网络");
                weakSelf.isConnectionNet = YES;
                break;
                
            default:
                break;
        }
    }];
    
    [manager startMonitoring];
}

- (BOOL)isReachable {
    return self.isConnectionNet;
}

- (void)updateManuscriptStateWithToken:(NSString *)token status:(NSString *)status taskId:(int)taskId {
    if (token == nil || status == nil || taskId < 0) {
        return;
    }
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"token"] = token;
    parameter[@"status"] = status;
    parameter[@"taskId"] = @(taskId);
    
    NSURLSessionDataTask *dataTask = [manager GET:kUpdateAuditTaskStaus parameters:parameter progress:nil success:nil failure:nil];
 
    [dataTask resume];
}

- (void)updateManuscript:(NSDictionary *)param success:(void (^)(id))success fail:(void (^)(NSError *))fail {
    if (param == nil) {
        return;
    }
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURLSessionDataTask *dataTask = [manager GET:kUpdateAuditTaskStaus parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
        
    }];
    [dataTask resume];
}

- (void)auditManuscriptWithToken:(NSString *)token status:(NSString *)status taskId:(int)taskId {
    
    if (token == nil || status <= 0 || taskId < 0) {
        return;
    }
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"token"] = token;
    parameter[@"status"] = status;
    parameter[@"taskId"] = @(taskId);
    
    NSURLSessionDataTask *dataTask = [manager GET:kAuditManuscript parameters:parameter progress:nil success:nil failure:nil];
    [dataTask resume];
}

- (void)dealloc {
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
    NSLog(@"LTNetworkingHelper dealloc");
}

@end
