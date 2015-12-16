//
//  LTManuscriptListController.m
//  稿件审核系统
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
    self.title = NSLocalizedString(@"LTTabBarItemStrManuscriptList", @"Manuscript List");
    // Do any additional setup after loading the view.
   
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
