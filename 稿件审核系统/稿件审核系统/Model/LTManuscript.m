//
//  LTManuscript.m
//  稿件审核系统
//
//  Created by zyq on 15/11/4.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import "LTManuscript.h"
#import "MJExtension.h"

@implementation LTManuscript

//- (instancetype)initWithDict:(NSDictionary *)dict {
//    if (self = [super init]) {
//        [self setValuesForKeysWithDictionary:dict];
//    }
//    return self;
//}

+ (instancetype)manuscriptWithDict:(NSDictionary *)dict {
    return [LTManuscript objectWithKeyValues:dict];
}

@end
