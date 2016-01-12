//
//  LTMyTaskController.m
//  InewsAudit
//
//  Created by zyq on 15/11/3.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import "LTMyTaskController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "UIView+Toast.h"
#import "LTManuscriptTool.h"
#import "MJRefresh.h"
#import "LTNetworkingHelper.h"

@interface LTMyTaskController ()
@property (nonatomic,assign) int currentPage;
@property (nonatomic,assign) int pageSize;
@property (nonatomic,copy) NSMutableArray *resultArray;
@end

@implementation LTMyTaskController

- (NSMutableArray *)resultArray {
    if (!_resultArray) {
        _resultArray = [NSMutableArray array];
    }
    return _resultArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的任务";
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [[UIView alloc] init];
   
    self.pageSize = 20;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.tableView reloadData];

    self.token = [USERDEFAULT objectForKey:MANUSCRIPT_TOKEN];
    if (self.token && [self.token length]) {
        [self refreshDataSource];
    }
}

//- (void)viewDidDisappear:(BOOL)animated {
//    [super viewDidDisappear:animated];
//    
//    [self.resultArray removeAllObjects];
//    [self.manuscriptArray removeAllObjects];
//    [self.tableView reloadData];
//}

- (void)refreshDataSource {
    
    self.currentPage = 1;
    [self.resultArray removeAllObjects];
    [self.manuscriptArray removeAllObjects];

    if ([[LTNetworkingHelper sharedManager] isReachable]) {
        [SVProgressHUD show];
        [self loadData];
    } else {
        [self.navigationController.view makeToast:@"当前网络不可用，请尝试接连网络后再试"
                    duration:2.0
                    position:CSToastPositionCenter];
    }
    
}

- (void)loadMoreData {
    self.currentPage ++;
    if ([[LTNetworkingHelper sharedManager] isReachable]) {
        [self loadData];
    } else {
        [self.navigationController.view makeToast:@"当前网络不可用，请尝试接连网络后再试"
                    duration:2.0
                    position:CSToastPositionCenter];
    }
}

#pragma mark - Prevate
- (void)loadData {
    self.tableView.scrollEnabled = NO;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"token"] = self.token;
    parameter[@"status"] = @"LOCKED";
    parameter[@"pageSize"] = @(self.pageSize);
    parameter[@"currentPage"] = @(self.currentPage);
    
    __weak typeof(self) weakSelf = self;
    
    NSURLSessionDataTask *dataTask = [manager POST:kGetCheckManuscriptList parameters:parameter constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        //        NSLog(@"%@",task.currentRequest);
        NSError *error = nil;
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject
                                                               options:NSJSONReadingMutableContainers
                                                                 error:&error];
        if (error) {
            [weakSelf.navigationController.view makeToast:@"数据序列化失败！"
                                                 duration:2.0
                                                 position:CSToastPositionCenter];
            return;
        }
        
        //        NSLog(@"%@",result);
        if ([result[@"code"] isEqualToNumber:@(-1)]) {
            [weakSelf.navigationController.view makeToast:result[@"msg"]
                                                 duration:2.0
                                                 position:CSToastPositionCenter];
            return;
        }
        
        if ([result[@"obj"] isEqual:[NSNull null]]) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            [weakSelf.navigationController.view makeToast:result[@"msg"]
                                                 duration:2.0
                                                 position:CSToastPositionCenter];
            self.tableView.tableHeaderView = self.noDataLabel;
            [self.tableView reloadData];
            return;
        }
        
        NSArray *array = [LTManuscriptTool manuscriptItemArrayWithDict:result];
        if (array.count == 0) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        
        [weakSelf.resultArray addObjectsFromArray:array];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.manuscriptArray = weakSelf.resultArray;
            weakSelf.tableView.tableHeaderView = nil;
            [weakSelf.tableView reloadData];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        
        [weakSelf.navigationController.view makeToast:error.localizedDescription
                                             duration:2.0
                                             position:CSToastPositionCenter];
        weakSelf.tableView.scrollEnabled = YES;
        [weakSelf.tableView reloadData];
    }];
    
    [dataTask resume];
    
    weakSelf.tableView.scrollEnabled = YES;
    
}

@end
