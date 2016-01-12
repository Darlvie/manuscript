//
//  LTBaseManuscriptCell.m
//  InewsAudit
//
//  Created by zyq on 15/11/3.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import "LTBaseManuscriptCell.h"
#import "AppDelegate.h"
#import "LTManuscriptItem.h"


@interface LTBaseManuscriptCell ()
@property (weak, nonatomic) IBOutlet UIButton *firstTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *secondTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *fourthTypeButton;


@end
@implementation LTBaseManuscriptCell

- (void)awakeFromNib {
    // Initialization code
    self.stateButton.layer.cornerRadius = 2;
    self.stateButton.layer.masksToBounds = YES;
    AppDelegate *app = APPDELEGATE;
    [self.stateButton setBackgroundColor:app.tintColor];

    
    [NOTIFICATION_CENTER addObserver:self
                            selector:@selector(tintColorDidChange:)
                                name:TINTCOLOR_DID_CHANGED
                              object:nil];
   
    
}

- (void)tintColorDidChange:(NSNotification *)noti {
    UIColor *color = noti.userInfo[@"tintColor"];
    [self.stateButton setBackgroundColor:color];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setManuscriptItem:(LTManuscriptItem *)manuscriptItem {
    _manuscriptItem = manuscriptItem;
    //标题
    if ([manuscriptItem.title length]) {
        _headlineLabel.text = manuscriptItem.title;
    } else {
        _headlineLabel.text = @"无标题";
    }
    
    
    //状态标签
    NSString *statusStr = nil;
    if ([manuscriptItem.status length]) {
        if ([manuscriptItem.status isEqualToString:@"COMPLETE"]) {
            if ([manuscriptItem.md[@"status"] isEqualToString:@"MOVE"]) {
                statusStr = @"通 过";
            } else if ([manuscriptItem.md[@"status"] isEqualToString:@"DISCARD"]) {
                statusStr = @"已废弃";
            } else {
                statusStr = @"未知";
            }
        } else {
            if ([manuscriptItem.status isEqualToString:@"AVAILABLE"]) {
                statusStr = @"可 用";
            } else if ([manuscriptItem.status isEqualToString:@"APPROVING"]) {
                statusStr = @"审批中";
            } else if ([manuscriptItem.status isEqualToString:@"INSTORAGE"]) {
                statusStr = @"入 库";
            } else if ([manuscriptItem.status isEqualToString:@"CREATE"]) {
                statusStr = @"转码中";
            } else if ([manuscriptItem.status isEqualToString:@"DISCARD"]) {
                statusStr = @"已废弃";
            } else if ([manuscriptItem.status isEqualToString:@"MOVE"]) {
                statusStr = @"通 过";
            } else if([manuscriptItem.status isEqualToString:@"COMPLETE"]){
                statusStr = @"已完成";
            } else if ([manuscriptItem.status isEqualToString:@"TOBE"]) {
                statusStr = @"待 审";
            } else if ([manuscriptItem.status isEqualToString:@"LOCKED"]) {
                statusStr = @"锁 定";
            } else {
                statusStr = @"未知";
            }
            
        }
        [_stateButton setTitle:statusStr forState:UIControlStateNormal];
    }
    
    //稿件类型图标
    [_firstTypeButton setImage:[UIImage imageNamed:@"atta_txt"] forState:UIControlStateNormal];
    [_secondTypeButton setImage:[UIImage imageNamed:@"atta_photos"] forState:UIControlStateNormal];

}



- (void)dealloc {    
    [NOTIFICATION_CENTER removeObserver:self];
}
@end
