//
//  LTManuscriptTool.h
//  InewsAudit
//
//  Created by hooper on 12/30/15.
//  Copyright © 2015 BGXT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LTManuscriptItem,LTManuscriptDetail;

@interface LTManuscriptTool : NSObject

+ (NSArray *)manuscriptItemArrayWithDict:(NSDictionary *)dict;

@end
