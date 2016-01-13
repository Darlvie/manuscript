//
//  LTManuscriptTool.m
//  InewsAudit
//
//  Created by hooper on 12/30/15.
//  Copyright © 2015 BGXT. All rights reserved.
//

#import "LTManuscriptTool.h"
#import "LTManuscriptItem.h"
#import "LTManuscriptDetail.h"


@implementation LTManuscriptTool

+ (NSArray *)manuscriptItemArrayWithDict:(NSDictionary *)dict {
    NSArray *objArray = dict[@"obj"];
    
    if ([objArray count]) {
        NSMutableArray *itemsArray = [NSMutableArray arrayWithCapacity:objArray.count];
        
        for (NSDictionary *dic in objArray) {
            if ([dic isKindOfClass:[NSDictionary class]]) {
                LTManuscriptItem *item = [LTManuscriptItem itemWithDict:dic];
                [itemsArray addObject:item];
            }
            
        }
        return [itemsArray copy];
    }
    
    return nil;
}

@end
