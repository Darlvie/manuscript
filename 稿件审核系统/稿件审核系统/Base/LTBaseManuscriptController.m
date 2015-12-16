//
//  LTBaseManuscriptController.m
//  稿件审核系统
//
//  Created by zyq on 15/11/3.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import "LTBaseManuscriptController.h"
#import "LTSettingViewController.h"
#import "LTBaseManuscriptCell.h"
#import "LTManuscriptDetailViewController.h"
#import "LTManuscript.h"

@interface LTBaseManuscriptController ()
@property (nonatomic,strong) NSArray *manuscriptArray;
@end

@implementation LTBaseManuscriptController

static NSString * const reuseIdentifier = @"baseManuscriptCell";

- (NSArray *)manuscriptArray {
    if (!_manuscriptArray) {
        __block NSArray *array = [NSArray array];        
        [self baseManuscriptWithArray:^(NSArray *manuscriptArray) {
            array = manuscriptArray;
        }];
        
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            LTManuscript *manuscript = [LTManuscript manuscriptWithDict:dict];
            [arrayM addObject:manuscript];
        }
        _manuscriptArray = arrayM;
    }
    return _manuscriptArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting"]
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(settingItemClick)];
    [self.tableView setBackgroundColor:RGB(236, 236, 236)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LTBaseManuscriptCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    
    self.tableView.rowHeight = 100;
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
    LTManuscript *manuscript = self.manuscriptArray[indexPath.row];
    cell.manuscript = manuscript;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LTManuscript *manuscript = self.manuscriptArray[indexPath.row];
    LTManuscriptDetailViewController *manuscriptDetailVC = [[LTManuscriptDetailViewController alloc] init];
    manuscriptDetailVC.manuscript = manuscript;
    [self.navigationController pushViewController:manuscriptDetailVC animated:YES];
}







@end
