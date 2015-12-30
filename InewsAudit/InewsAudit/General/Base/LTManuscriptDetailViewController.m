//
//  LTManuscriptDetailViewController.m
//  InewsAudit
//
//  Created by zyq on 15/11/4.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import "LTManuscriptDetailViewController.h"
#import "LTManuscript.h"
#import "MJExtension.h"
#import "LTManuscriptVerifyFooterView.h"
#import "LTFailPassFooterView.h"
#import "LTPassedFooterView.h"
#import "LTManuscriptItem.h"

@interface LTManuscriptDetailViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *titleArray;
@property(nonatomic,strong) id footerView;
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
        switch (self.manuscriptItem.state) {
            case ManuscriptStateEntering:
            case ManuscriptStatePassed:
            {
                _footerView = [LTPassedFooterView passedFooterView];
            }
                break;
            case ManuscriptStateFailPass:
            {
                _footerView = [LTFailPassFooterView failPassFooterView];
            }
                break;
            case ManuscriptStateUnfinished:
            case ManuscriptStateVerifying:
            {
                _footerView = [LTManuscriptVerifyFooterView manuscriptVerifyFooterView];
            }
            default:
                break;
        }
          
    }
    return _footerView;
}

#pragma mark - 初始化视图

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"稿件详情";
    
    [self setupTableView];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupTableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.tableFooterView = self.footerView;
    _tableView.tableFooterView.userInteractionEnabled = YES;
    [self.view addSubview:_tableView];
    
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
            headLineLabel.text = self.manuscriptItem.title;
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
         
            cell.detailTextLabel.text = [self detailStringWithIndexPath:indexPath];
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
            return [self stringWithManuscriptState:self.manuscript.state];
            break;
        case 1:
            return self.manuscript.sID;
            break;
        case 2:
            return self.manuscript.author;
            break;
        case 3:
            return self.manuscript.enterUser;
            break;
        case 4:
            return self.manuscript.department;
            break;
        case 5:
            return self.manuscript.timeStamp;
            break;
        case 6:
            return self.manuscript.channel;
            break;
        case 7:
            return self.manuscript.device;
            break;
        default:
            return nil;
            break;
    }
}

//判断稿件状态，转换成中文显示
- (NSString *)stringWithManuscriptState:(NSUInteger)state {
    switch (state) {
        case ManuscriptStateEntering:
            return @"入库中";
            break;
        case ManuscriptStateFailPass:
            return @"未通过";
            break;
        case ManuscriptStatePassed:
            return @"已通过";
            break;
        case ManuscriptStateUnfinished:
            return @"未完成";
            break;
        case ManuscriptStateVerifying:
            return @"审核中";
            break;
        default:
            return nil;
            break;
    }
}

@end
