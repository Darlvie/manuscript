//
//  LTManuscriptModel.m
//  InewsAudit
//
//  Created by zyq on 15/12/29.
//  Copyright © 2015年 BGXT. All rights reserved.
//

#import "LTManuscriptModel.h"
#import "MJExtension.h"

@implementation LTManuscriptModel


+ (instancetype)manuscriptWithDict:(NSDictionary *)dict {
    return [LTManuscriptModel objectWithKeyValues:dict];
}

@end
