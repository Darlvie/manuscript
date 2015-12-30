//
//  LTBaseManuscriptController.m
//  InewsAudit
//
//  Created by zyq on 15/11/3.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import "LTBaseManuscriptController.h"
#import "LTSettingViewController.h"
#import "LTBaseManuscriptCell.h"
#import "LTManuscriptDetailViewController.h"
#import "LTManuscriptItem.h"
#import "MJRefresh.h"

@interface LTBaseManuscriptController ()

@end

@implementation LTBaseManuscriptController

static NSString * const reuseIdentifier = @"baseManuscriptCell";

- (void)setManuscriptArray:(NSMutableArray *)manuscriptArray {
    _manuscriptArray = manuscriptArray;
    
    if (manuscriptArray.count >= 20) {
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                        refreshingAction:@selector(footerRefreshAction)];
        
    } else {
        self.tableView.mj_footer = nil;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.manuscriptArray = [NSMutableArray array];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting"]
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(settingItemClick)];
    [self.tableView setBackgroundColor:RGB(236, 236, 236)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LTBaseManuscriptCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    
    self.tableView.rowHeight = 100;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                                refreshingAction:@selector(headRefreshAction)];

    
    
}


- (void)settingItemClick {
   
    LTSettingViewController *settingVC = [[LTSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.manuscriptArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LTBaseManuscriptCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    LTManuscriptItem *item = self.manuscriptArray[indexPath.row];
    cell.manuscriptItem = item;
//    NSLog(@"type: %@",item.type);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Action
- (void)headRefreshAction {
   
    [self.tableView.mj_header beginRefreshing];
    [self refreshDataSource];
    [self.tableView.mj_header endRefreshing];
   
}

- (void)footerRefreshAction {

    [self.tableView.mj_footer beginRefreshing];
    [self loadMoreData];
    [self.tableView.mj_footer endRefreshing];
    
}


- (void)refreshDataSource  {
    
}

- (void)loadMoreData {
    
}

@end
