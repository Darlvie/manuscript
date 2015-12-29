//
//  LTAccountTool.m
//  InewsAudit
//
//  Created by zyq on 15/11/3.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import "LTAccountTool.h"
#import "LTAccount.h"

#define ACCOUNT_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

@implementation LTAccountTool

+ (LTAccount *)account {
    LTAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:ACCOUNT_PATH];
    
    if (!account) {
        return nil;
    }
    return account;
}

+ (void)saveAccount:(LTAccount *)account {
    [NSKeyedArchiver archiveRootObject:account toFile:ACCOUNT_PATH];
}
@end
