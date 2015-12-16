//
//  LTBaseManuscriptCell.h
//  稿件审核系统
//
//  Created by zyq on 15/11/3.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LTManuscript;
@interface LTBaseManuscriptCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (weak, nonatomic) IBOutlet UILabel *headlineLabel;
@property (weak, nonatomic) IBOutlet UIButton *stateButton;

@property (nonatomic,strong) LTManuscript *manuscript;
@end
