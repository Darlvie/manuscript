//
//  LTSettingViewController.m
//  InewsAudit
//
//  Created by zyq on 15/11/4.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import "LTSettingViewController.h"
#import "LTModifyAccountController.h"
#import "LTLoginViewController.h"
#import "LTColorPickerController.h"

@interface LTSettingViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation LTSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    [self setupTableView];
}

- (void)setupTableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
}

#pragma mark - controlTabBarView
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
        return 2;
    } else{
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const reuseIdentifier = @"settingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                cell.textLabel.text = @"修改账户";
            } else {
                cell.textLabel.text = @"主题颜色";
            }
            break;
        case 1:
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.text = @"登出";
            cell.textLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                LTModifyAccountController *modifyVC = [[LTModifyAccountController alloc]initWithNibName:@"LTModifyAccountController" bundle:nil];
                [self.navigationController pushViewController:modifyVC animated:YES];
            } else {
                LTColorPickerController *colorPickerVC = [[LTColorPickerController alloc] initWithNibName:@"LTColorPickerController" bundle:nil];
                [self.navigationController pushViewController:colorPickerVC animated:YES];
            }
            break;
        case 1:
        {
            LTLoginViewController *loginVC = [[LTLoginViewController alloc] initWithNibName:@"LTLoginViewController" bundle:nil];
            [self presentViewController:loginVC animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}

@end
