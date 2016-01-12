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
#import "LTManuscriptListController.h"
#import "LTNetworkingHelper.h"
#import "LTMyTaskController.h"
#import "UIView+Toast.h"

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
    
    NSShadow *noDataShadow = [[NSShadow alloc] init];
    noDataShadow.shadowColor = RGBA(0, 0, 0, 0.8);
    noDataShadow.shadowOffset = CGSizeMake(0, 1);
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:@"没有更多数据!"
                                                                 attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,noDataShadow,NSShadowAttributeName,nil]];
    
    self.noDataLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    CGRect rect = CGRectZero;
    rect.size = CGSizeMake(320, 64);
    self.noDataLabel.frame = rect;
    self.noDataLabel.center = self.view.center;
    self.noDataLabel.backgroundColor = [UIColor clearColor];
    [self.noDataLabel setTextAlignment:NSTextAlignmentCenter];
    self.noDataLabel.attributedText = attStr;
    self.tableView.tableHeaderView = self.noDataLabel;
    
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
    LTManuscriptItem *item = self.manuscriptArray[indexPath.row];
    LTManuscriptDetailViewController *detailVC = [[LTManuscriptDetailViewController alloc] init];
    detailVC.manuscriptItem = item;
    
    //[detailVC getManuscriptWithManuscriptId:item.manuscriptId];
    if ([self isKindOfClass:[LTManuscriptListController class]]) {
        LTNetworkingHelper *helper = [LTNetworkingHelper sharedManager];
//        [helper updateManuscriptStateWithToken:[USERDEFAULT objectForKey:MANUSCRIPT_TOKEN]
//                                        status:@"LOCKED"
//                                        taskId:item.taskId];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"token"] = [USERDEFAULT objectForKey:MANUSCRIPT_TOKEN];
        param[@"status"] = @"LOCKED";
        param[@"taskId"] = @(item.taskId);
        __weak typeof(self) weakSelf = self;
        [helper updateManuscript:param success:^(id responseDic) {
            if (responseDic) {
                detailVC.showUnlockedItem = NO;
                [self.navigationController pushViewController:detailVC animated:YES];
            }
            
        } fail:^(NSError *error) {
            [weakSelf.view makeToast:error.description duration:2.0 position:CSToastPositionCenter];
        }];

        
    } else if ([self isKindOfClass:[LTMyTaskController class]]){
        detailVC.showUnlockedItem = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
    } else {
        detailVC.showUnlockedItem = NO;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    
    
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
