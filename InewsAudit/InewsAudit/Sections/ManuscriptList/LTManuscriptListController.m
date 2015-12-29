//
//  LTManuscriptListController.m
//  InewsAudit
//
//  Created by zyq on 15/11/3.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import "LTManuscriptListController.h"

@interface LTManuscriptListController ()

@end

@implementation LTManuscriptListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"稿件列表";
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [[UIView alloc] init];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)baseManuscriptWithArray:(ManuscriptBlock)manuscriptBlock {
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"manuscriptList.plist" ofType:nil]];
    manuscriptBlock(array);
}

@end
