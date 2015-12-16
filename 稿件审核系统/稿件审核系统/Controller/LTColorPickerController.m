//
//  LTColorPickerController.m
//  稿件审核系统
//
//  Created by zyq on 15/11/5.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import "LTColorPickerController.h"
#import "HRColorPickerView.h"

@interface LTColorPickerController ()
@property (nonatomic,strong) UIColor *color;
@property (weak, nonatomic) IBOutlet HRColorPickerView *colorPickerView;
@end

@implementation LTColorPickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Theme color", @"Theme color");
    // Do any additional setup after loading the view from its nib.
    self.colorPickerView.color = self.color;
    [self.colorPickerView addTarget:self action:@selector(colorDidChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                           target:self
                                                                                           action:@selector(saveTintColor)];
}

#pragma mark - controlTabBarView
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSArray *array = self.tabBarController.view.subviews;
    UIView *tabBarView = array.lastObject;
    tabBarView.frame = CGRectMake(0, SCREEN_HEIGTH, SCREEN_WIDTH, 49);
    
    //修复右滑导航不返回
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
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

- (void)colorDidChanged:(HRColorPickerView *)colorPickerView {    
    self.color = colorPickerView.color;
}

//保存主题颜色
- (void)saveTintColor {
    [self.navigationController.navigationBar setBarTintColor:self.color];
    
    //存储更改的颜色
    NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:self.color];
    [USERDEFAULT setObject:colorData forKey:TINTCOLOR];
    [USERDEFAULT synchronize];

    //发出颜色修改通知
    [NOTIFICATION_CENTER postNotificationName:TINTCOLOR_DID_CHANGED object:nil userInfo:@{@"tintColor":self.color}];
    
}


@end
