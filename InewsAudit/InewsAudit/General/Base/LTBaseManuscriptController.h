//
//  LTBaseManuscriptController.h
//  InewsAudit
//
//  Created by zyq on 15/11/3.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import <UIKit/UIKit.h>

//定义block
typedef void(^ManuscriptBlock)(NSArray *manuscriptArray);
@interface LTBaseManuscriptController : UITableViewController
@property (nonatomic,copy) NSString *token;
@property (nonatomic,copy) NSMutableArray *manuscriptArray;

- (void)refreshDataSource;

- (void)loadMoreData;

@end
