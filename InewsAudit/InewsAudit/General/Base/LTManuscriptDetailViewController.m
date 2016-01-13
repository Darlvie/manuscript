//
//  LTManuscriptDetailViewController.m
//  InewsAudit
//
//  Created by zyq on 15/11/4.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import "LTManuscriptDetailViewController.h"
#import "MJExtension.h"
#import "LTManuscriptVerifyFooterView.h"
#import "LTFailPassFooterView.h"
#import "LTPassedFooterView.h"
#import "LTManuscriptItem.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "UIView+Toast.h"
#import "LTManuscriptDetail.h"
#import "LTNetworkingHelper.h"
#import "Masonry.h"
#import "UIView+Toast.h"

@interface LTManuscriptDetailViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *titleArray;
@property(nonatomic,strong) id footerView;
@property(nonatomic,strong) LTManuscriptDetail *manuscriptDetail;
@property(nonatomic,strong) UIView *bottomBar;
@end

@implementation LTManuscriptDetailViewController

#pragma mark - 懒加载
- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"状态",
                        @"稿件ID",
                        @"作者",
                        @"入库用户",
                        @"部门",
                        @"发稿时间",
                        @"稿件通道",
                        @"稿件设备号"
                        ];
    }
    return _titleArray;
}

- (id)footerView {
    
    if (!_footerView) {
        if ([self.manuscriptItem.status isEqualToString:@"COMPLETE"]) {
            if ([self.manuscriptItem.md[@"status"] isEqualToString:@"MOVE"]) {
                _footerView = [LTPassedFooterView passedFooterView];
            } else if ([self.manuscriptItem.md[@"status"] isEqualToString:@"DISCARD"]) {
                _footerView = [LTFailPassFooterView failPassFooterView];
            }
            
        } else {
            _footerView = [LTManuscriptVerifyFooterView manuscriptVerifyFooterView];
        }
    }
    return _footerView;
}

#pragma mark - 初始化视图

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"稿件详情";
    
    if (self.showUnlockedItem) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"解锁"
                                                                                  style:UIBarButtonItemStyleDone
                                                                                 target:self
                                                                                 action:@selector(unLockedAction)];
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    [self setupBottomBar];
    [self setupTableView];
    [_bottomBar addSubview:self.footerView];
    [self setupRestraint];
    
    // Do any additional setup after loading the view from its nib.
    [NOTIFICATION_CENTER addObserver:self
                            selector:@selector(passButtonDidClick:)
                                name:MANUSCRIPT_VERIFY_PASS
                              object:nil];
    [NOTIFICATION_CENTER addObserver:self
                            selector:@selector(noPassButtonClick:)
                                name:MANUSCRIPT_VERIFY_NOPASS
                              object:nil];
}

- (void)setupBottomBar {
    if (!_bottomBar) {
        _bottomBar = [[UIView alloc] initWithFrame:CGRectZero];
    }
//    CGFloat height = 50;
//    _bottomBar.frame = CGRectMake(0, SCREEN_HEIGTH - height, SCREEN_WIDTH, height);
    _bottomBar.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_bottomBar];
}

- (void)setupTableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    _tableView.tableFooterView = self.footerView;
//    _tableView.tableFooterView.userInteractionEnabled = YES;
    [self.view addSubview:_tableView];
}

- (void)setupRestraint {
    [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@50);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(64);
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.bottomBar.mas_top);
    }];
    
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomBar.mas_top);
        make.right.equalTo(self.bottomBar.mas_right);
        make.bottom.equalTo(self.bottomBar.mas_bottom);
        make.left.equalTo(self.bottomBar.mas_left);
    }];
}

- (void)unLockedAction {
    LTNetworkingHelper *helper = [LTNetworkingHelper sharedManager];
    if ([self.manuscriptItem.status isEqualToString:@"LOCKED"]) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"token"] = [USERDEFAULT objectForKey:MANUSCRIPT_TOKEN];
        param[@"status"] = @"TOBE";
        param[@"taskId"] = @(self.manuscriptItem.taskId);
        __weak typeof(self) weakSelf = self;
        [helper updateManuscript:param success:^(id responseDic) {
            if (responseDic) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
            
        } fail:^(NSError *error) {
            [weakSelf.navigationController.view makeToast:error.description
                                                 duration:2.0
                                                 position:CSToastPositionCenter];
        }];
        
    }
    
}

#pragma mark - 控制tabBar显示隐藏
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSArray *array = self.tabBarController.view.subviews;
    UIView *tabBarView = array.lastObject;
    tabBarView.frame = CGRectMake(0, SCREEN_HEIGTH, SCREEN_WIDTH, 49);
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSArray *array = self.tabBarController.view.subviews;
    UIView *tabBarView = array.lastObject;
    tabBarView.frame = CGRectMake(0, SCREEN_HEIGTH - 49, SCREEN_WIDTH, 49);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [NOTIFICATION_CENTER removeObserver:self];
}

#pragma mark - public
- (void)getManuscriptWithManuscriptId:(int)manuscriptId {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    NSString *token = [USERDEFAULT objectForKey:MANUSCRIPT_TOKEN];
    
    parameter[@"token"] = token;
    parameter[@"manuscriptId"] = @(manuscriptId);
    
    [SVProgressHUD show];
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *dataTask = [manager POST:kGetManuscript parameters:parameter constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
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
        if ([result[@"code"] isEqualToNumber:@(-1)] || [result[@"obj"] isEqual:[NSNull null]]) {
            [weakSelf.navigationController.view makeToast:result[@"msg"]
                                                 duration:2.0
                                                 position:CSToastPositionCenter];
            return;
        }
        
        self.manuscriptDetail = [LTManuscriptDetail manuscriptDetailWithDict:result[@"obj"]];
        
        if (self.manuscriptDetail) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
            });
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [weakSelf.navigationController.view makeToast:error.localizedDescription
                                             duration:2.0
                                             position:CSToastPositionCenter];
        
    }];
    [dataTask resume];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    } else{
        return 8;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *const reuseIdentifier = @"settingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.tintColor = [UIColor blackColor];
        
    }
    
    switch (indexPath.section) {
        case 0:
        {
            UILabel *headLineLabel = [[UILabel alloc] init];
            headLineLabel.frame = CGRectMake(10, 5, SCREEN_WIDTH - 15, 60);
            if (self.manuscriptItem) {
                headLineLabel.text = [self.manuscriptItem.title length]? self.manuscriptItem.title : @"暂无数据";
            }
            headLineLabel.numberOfLines = 0;
            headLineLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
            [cell.contentView addSubview:headLineLabel];
        }
            break;
        case 1:
        {
            NSString *titleStr = self.titleArray[indexPath.row];
            cell.textLabel.text = [NSString stringWithFormat:@"%@:",titleStr];
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
         
            if (self.manuscriptItem) {
                cell.detailTextLabel.text = [self detailStringWithIndexPath:indexPath];
            } else {
                cell.detailTextLabel.text = @"暂无数据";
            }
            
            cell.detailTextLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 70;
    }
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"标题";
    } else {
        return @"详情";
    }
}

#pragma mark - 控制稿件详情页显示内容的方法
//显示稿件详情页内容
- (NSString *)detailStringWithIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return [self.manuscriptItem.status length]? self.manuscriptItem.status : @"暂无数据";
            break;
        case 1:
            return [NSString stringWithFormat:@"%d",self.manuscriptItem.manuscriptId];
            break;
        case 2:
            return [self.manuscriptItem.md[@"author"] length]? self.manuscriptItem.md[@"author"] : @"暂无数据";
            break;
        case 3:
            return [self.manuscriptItem.userName length]? self.manuscriptItem.userName : @"暂无数据";
            break;
        case 4:
            return [self.manuscriptItem.md[@"department"] length]? self.manuscriptItem.md[@"department"] : @"暂无数据";
            break;
        case 5:
            return [self.manuscriptItem.updateTime length]? self.manuscriptItem.updateTime : @"暂无数据";
            break;
        case 6:
            return [self.manuscriptItem.md[@"columnsName"] length]? self.manuscriptItem.md[@"columnsName"] : @"暂无数据";
            break;
        case 7:
            return @"暂无数据";
            break;
        default:
            return nil;
            break;
    }
}


#pragma mark - Notification
- (void)passButtonDidClick:(id)sender {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                    message:@"确定该稿件通过审核？"
//                                                   delegate:nil
//                                          cancelButtonTitle:@"取消"
//                                          otherButtonTitles:@"确认", nil];
//    [alert show];
    
    
    LTNetworkingHelper *helper = [LTNetworkingHelper sharedManager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [USERDEFAULT objectForKey:MANUSCRIPT_TOKEN];
    param[@"status"] = @"MOVE";
    param[@"taskId"] = @(self.manuscriptItem.taskId);
    
    __weak typeof(self) weakSelf = self;
    [helper auditManuscript:param success:^(id responseDic) {
        if (responseDic) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    } fail:^(NSError *error) {
        if (error) {
            [weakSelf.navigationController.view makeToast:error.description
                                                 duration:2.0
                                                 position:CSToastPositionCenter];
        }
    }];
    
}


- (void)noPassButtonClick:(id)sender {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                    message:@"确定该稿件不通过审核？"
//                                                   delegate:nil
//                                          cancelButtonTitle:@"取消"
//                                          otherButtonTitles:@"确认", nil];
//    [alert show];
    
    LTNetworkingHelper *helper = [LTNetworkingHelper sharedManager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [USERDEFAULT objectForKey:MANUSCRIPT_TOKEN];
    param[@"status"] = @"DISCARD";
    param[@"taskId"] = @(self.manuscriptItem.taskId);
    
    __weak typeof(self) weakSelf = self;
    [helper auditManuscript:param success:^(id responseDic) {
        if (responseDic) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    } fail:^(NSError *error) {
        if (error) {
            [weakSelf.navigationController.view makeToast:error.description
                                                 duration:2.0
                                                 position:CSToastPositionCenter];
        }
    }];

}






@end
