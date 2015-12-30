//
//  LTManuscriptDetail.m
//  InewsAudit
//
//  Created by zyq on 15/12/29.
//  Copyright © 2015年 BGXT. All rights reserved.
//

#import "LTManuscriptDetail.h"
#import "MJExtension.h"

@implementation LTManuscriptDetail


+ (instancetype)manuscriptWithDict:(NSDictionary *)dict {
    return [LTManuscriptDetail objectWithKeyValues:dict];
}

@end
