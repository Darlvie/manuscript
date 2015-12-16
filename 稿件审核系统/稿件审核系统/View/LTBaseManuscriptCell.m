//
//  LTBaseManuscriptCell.m
//  稿件审核系统
//
//  Created by zyq on 15/11/3.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import "LTBaseManuscriptCell.h"
#import "LTManuscript.h"
#import "AppDelegate.h"

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
    
    [NOTIFICATION_CENTER addObserver:self selector:@selector(tintColorDidChange:) name:TINTCOLOR_DID_CHANGED object:nil];
   
}

- (void)tintColorDidChange:(NSNotification *)noti {
    UIColor *color = noti.userInfo[@"tintColor"];
    [self.stateButton setBackgroundColor:color];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setManuscript:(LTManuscript *)manuscript {
    _manuscript = manuscript;
    
    //标题
    _headlineLabel.text = manuscript.title;
    
    //状态标签
    switch (manuscript.state) {
        case ManuscriptStateEntering:
            [_stateButton setTitle:NSLocalizedString(@"Saving", @"saving") forState:UIControlStateNormal];
            break;
        case ManuscriptStateFailPass:
            [_stateButton setTitle:NSLocalizedString(@"Failed", @"failed") forState:UIControlStateNormal];
            break;
        case ManuscriptStatePassed:
            [_stateButton setTitle:NSLocalizedString(@"Passed", @"passed") forState:UIControlStateNormal];
            break;
        case ManuscriptStateUnfinished:
            [_stateButton setTitle:NSLocalizedString(@"Unfinished", @"unfinished") forState:UIControlStateNormal];
            break;
        case ManuscriptStateVerifying:
            [_stateButton setTitle:NSLocalizedString(@"Reviewing", @"reviewing") forState:UIControlStateNormal];
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
