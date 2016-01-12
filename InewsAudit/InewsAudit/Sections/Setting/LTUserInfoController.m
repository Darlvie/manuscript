//
//  LTUserInfoController.m
//  InewsAudit
//
//  Created by hooper on 12/31/15.
//  Copyright © 2015 BGXT. All rights reserved.
//

#import "LTUserInfoController.h"
#import "LTUserInfo.h"
#import "LTFileLocationHelper.h"

@interface LTUserInfoController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) LTUserInfo *userInfo;
@property (nonatomic,copy) NSArray *userInfoArray;
@property (nonatomic,copy) NSArray *keys;
@end

@implementation LTUserInfoController

- (NSArray *)userInfoArray {
    if (!_userInfoArray) {
        _userInfoArray = @[@"用户ID",@"身份证号",
                           @"密码",@"姓",
                           @"名",@"邮箱",
                           @"电话",@"手机",
                           @"用户类型",@"描述",
                           @"头衔"];
    }
    return _userInfoArray;
}

- (NSArray *)keys {
    if (!_keys) {
        _keys = @[@"userId",@"idCard",
                  @"password",@"lastName",
                  @"firstName",@"email",
                  @"phone",@"mobile",
                  @"userType",@"desc",
                  @"honour"];
    }
    return _keys;
}

- (instancetype)init {
    if (self = [super init]) {
        NSString *filePath = [[LTFileLocationHelper getUserInfoDocumentPath] stringByAppendingPathComponent:@"userInfo.archiver"];
//        NSLog(@"%@",filePath);
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            //[[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:NO attributes:nil error:nil];
            NSMutableData *data = [NSMutableData dataWithContentsOfFile:filePath];
            NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
            LTUserInfo *userInfo = [unarchiver decodeObjectForKey:USERINFO];
            if (userInfo) {
//                NSLog(@"%@",userInfo);
                self.userInfo = userInfo;
            }
            

        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"用户信息";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.tableView];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
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

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    NSString *text = self.userInfoArray[indexPath.row];
    NSString *key = self.keys[indexPath.row];
    NSString *detailText = [NSString stringWithFormat:@"%@",[self.userInfo valueForKey:key]];
    cell.textLabel.text = text;
    cell.detailTextLabel.text = detailText;
    
    return cell;
}
















@end
