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

//定义block回调函数，由子类实现
- (void)baseManuscriptWithArray:(ManuscriptBlock)manuscriptBlock;
@end
