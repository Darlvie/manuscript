//
//  LTManuscriptVerifyController.m
//  InewsAudit
//
//  Created by zyq on 15/11/3.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import "LTManuscriptAuditController.h"

@interface LTManuscriptAuditController ()

@end

@implementation LTManuscriptAuditController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"稿件审核";
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)baseManuscriptWithArray:(ManuscriptBlock)manuscriptBlock {
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"manuscriptReview.plist" ofType:nil]];
    manuscriptBlock(array);
}

@end
