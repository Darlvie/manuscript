//
//  LTFileLocationHelper.m
//  InewsAudit
//
//  Created by hooper on 12/31/15.
//  Copyright © 2015 BGXT. All rights reserved.
//

#import "LTFileLocationHelper.h"

@implementation LTFileLocationHelper

+ (NSString *)getUserInfoDocumentPath {
    static NSString *userInfoDocumentPath = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *userId = [NSString stringWithFormat:@"%ld",(long)[USERDEFAULT integerForKey:USERINFO_USERID]];
        NSString *appDocumentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject];
        userInfoDocumentPath = [[NSString alloc] initWithFormat:@"%@/%@/",appDocumentPath,userId];
        if (![[NSFileManager defaultManager] fileExistsAtPath:userInfoDocumentPath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:userInfoDocumentPath
                                      withIntermediateDirectories:NO
                                                       attributes:nil
                                                            error:nil];
        }
    });
    return userInfoDocumentPath;
}



@end
