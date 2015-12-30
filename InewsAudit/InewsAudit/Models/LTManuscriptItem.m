//
//  LTManuscriptItem.m
//  InewsAudit
//
//  Created by hooper on 12/30/15.
//  Copyright © 2015 BGXT. All rights reserved.
//

#import "LTManuscriptItem.h"
#import "MJExtension.h"



@implementation LTManuscriptItem

+ (instancetype)itemWithDict:(NSDictionary *)dict {
    return [LTManuscriptItem objectWithKeyValues:dict];
}

@end
