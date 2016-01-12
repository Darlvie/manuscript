//
//  LTManuscriptItem.h
//  InewsAudit
//
//  Created by hooper on 12/30/15.
//  Copyright © 2015 BGXT. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LTManuscriptItem : NSObject

@property (nonatomic,assign) int manuscriptId;

@property(nonatomic,strong) NSDictionary *md;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *status;

@property (nonatomic,assign) int taskId;

@property (nonatomic,copy) NSString *updateTime;

@property (nonatomic,copy) NSString *userName;

+ (instancetype)itemWithDict:(NSDictionary *)dict;

@end
