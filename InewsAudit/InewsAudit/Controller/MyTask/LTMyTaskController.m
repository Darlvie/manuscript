//
//  LTMyTaskController.m
//  InewsAudit
//
//  Created by zyq on 15/11/3.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import "LTMyTaskController.h"

@interface LTMyTaskController ()

@end

@implementation LTMyTaskController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的任务";
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)baseManuscriptWithArray:(ManuscriptBlock)manuscriptBlock {
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"myTasks.plist" ofType:nil]];
    manuscriptBlock(array);

}

@end
