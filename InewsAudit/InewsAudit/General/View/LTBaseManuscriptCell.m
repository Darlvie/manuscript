//
//  LTBaseManuscriptCell.m
//  InewsAudit
//
//  Created by zyq on 15/11/3.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import "LTBaseManuscriptCell.h"
#import "LTManuscript.h"
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
        if ([manuscriptItem.status isEqualToString:@"AVAILABLE"]) {
            statusStr = @"可 用";
        } else if ([manuscriptItem.status isEqualToString:@"APPROVING"]) {
            statusStr = @"审批中";
        } else if ([manuscriptItem.status isEqualToString:@"INSTORAGE"]) {
            statusStr = @"入 库";
        } else if ([manuscriptItem.status isEqualToString:@"CREATE"]) {
            statusStr = @"转码中";
        } else if ([manuscriptItem.status isEqualToString:@"DISCARD"]) {
            statusStr = @"废 弃";
        } else if ([manuscriptItem.status isEqualToString:@"MOVE"]) {
            statusStr = @"待 签";
        } else if([manuscriptItem.status isEqualToString:@"COMPLETE"]){
            statusStr = @"已完成";
        } else if ([manuscriptItem.status isEqualToString:@"TOBE"]) {
            statusStr = @"未完成";
        } else {
            statusStr = manuscriptItem.status;
        }
        [_stateButton setTitle:statusStr forState:UIControlStateNormal];

    }
    
    //稿件类型图标
    [_firstTypeButton setImage:[UIImage imageNamed:@"atta_txt"] forState:UIControlStateNormal];
    [_secondTypeButton setImage:[UIImage imageNamed:@"atta_photos"] forState:UIControlStateNormal];

}

- (void)setManuscript:(LTManuscript *)manuscript {
    
    //标题
    _headlineLabel.text = manuscript.title;
    
    //状态标签
    switch (manuscript.state) {
        case ManuscriptStateEntering:
            [_stateButton setTitle:@"入库中" forState:UIControlStateNormal];
            break;
        case ManuscriptStateFailPass:
            [_stateButton setTitle:@"未通过" forState:UIControlStateNormal];
            break;
        case ManuscriptStatePassed:
            [_stateButton setTitle:@"已通过" forState:UIControlStateNormal];
            break;
        case ManuscriptStateUnfinished:
            [_stateButton setTitle:@"未完成" forState:UIControlStateNormal];
            break;
        case ManuscriptStateVerifying:
            [_stateButton setTitle:@"审核中" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    
    //稿件类型图标
    switch (manuscript.type) {
        case ManuscriptTypeTxt:
            [_firstTypeButton setImage:[UIImage imageNamed:@"atta_txt"] forState:UIControlStateNormal];
            break;
        case ManuscriptTypePhoto:
            [_firstTypeButton setImage:[UIImage imageNamed:@"atta_photos"] forState:UIControlStateNormal];
            break;
        case ManuscriptTypeRecord:
            [_firstTypeButton setImage:[UIImage imageNamed:@"atta_record"] forState:UIControlStateNormal];
            break;
        case ManuscriptTypeVideo:
            [_firstTypeButton setImage:[UIImage imageNamed:@"atta_video"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}


- (void)dealloc {    
    [NOTIFICATION_CENTER removeObserver:self];
}
@end
