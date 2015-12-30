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
    
    self.token = [USERDEFAULT objectForKey:MANUSCRIPT_TOKEN];
    if (self.token && [self.token length]) {
        [self refreshDataSource];
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshDataSource {
    
    self.currentPage = 1;
    self.resultArray = nil;
    
    [self loadData];
}

- (void)loadMoreData {
    self.currentPage ++;
    [self loadData];
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
    parameter[@"status"] = @"TOBE";
    parameter[@"userId"] = @(1720);
    parameter[@"pageSize"] = @(self.pageSize);
    parameter[@"currentPage"] = @(self.currentPage);
    
    [SVProgressHUD show];
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *dataTask = [manager POST:kGetAuditTask parameters:parameter constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        //        NSLog(@"%@",task.response);
        NSError *error = nil;
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject
                                                               options:NSJSONReadingMutableContainers
                                                                 error:&error];
        if (error) {
            [weakSelf.view makeToast:@"数据序列化失败！" duration:2.0 position:CSToastPositionCenter];
            return;
        }
        
        NSArray *array = [LTManuscriptTool manuscriptItemArrayWithDict:result];
        
        if (array.count == 0) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        
        [weakSelf.resultArray addObjectsFromArray:array];
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.manuscriptArray = self.resultArray;
            [weakSelf.tableView reloadData];
            weakSelf.tableView.scrollEnabled = YES;
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        
        [weakSelf.view makeToast:error.localizedDescription duration:2.0 position:CSToastPositionCenter];
        weakSelf.tableView.scrollEnabled = YES;
    }];
    
    [dataTask resume];
}

@end
