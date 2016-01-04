//
//  QJStatusCell.m
//  SinaProj
//
//  Created by 杨丽娟 on 15/12/29.
//  Copyright © 2015年 Qin.Yu. All rights reserved.
//

#import "QJStatusCell.h"
#import "QJStatus.h"
#import "QJUser.h"
#import "QJStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "QJStatusToolbar.h"
#import "QJStatusTobView.h"

@interface QJStatusCell ()
//original Top view
@property(nonatomic, weak) QJStatusTobView *topView;
//tool bar
@property(nonatomic, weak) QJStatusToolbar *statusToolbar;

@end

@implementation QJStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellID = @"statusCell";
    QJStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[QJStatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectedBackgroundView = [[UIView alloc]init];
        self.backgroundColor = [UIColor clearColor];
        //1.添加原创微博的内部子控件
        [self SetupOriginalSubViews];
        //2.添加被转发微博的内部子控件
        //[self SetupRetweetSubViews];
        //3.添加原创微博的底部工具条
        [self SetupStatusToolBar];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    //frame.origin.x = QJStatueCellMargin;
    frame.origin.y += QJStatueCellMargin;
    //frame.size.width -= 2*QJStatueCellMargin;
    frame.size.height -= QJStatueCellMargin;
    [super setFrame:frame];
}

- (void)SetupOriginalSubViews
{
    QJStatusTobView *topView = [[QJStatusTobView alloc]init];
    [self.contentView addSubview:topView];
    self.topView = topView;
    
}



- (void)SetupStatusToolBar
{
    QJStatusToolbar *statusToolbar = [[QJStatusToolbar alloc]init];
    [self.contentView addSubview:statusToolbar];
    self.statusToolbar = statusToolbar;
}

- (void)setStatusFrame:(QJStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    [self SetupOriginalData];
    
    [self SetupStatusToolbarData];
}

- (void)SetupOriginalData
{
    self.topView.frame = self.statusFrame.topViewF;
    self.topView.statusFrame = self.statusFrame;
}

- (void)SetupStatusToolbarData
{
    self.statusToolbar.frame = self.statusFrame.statusToolbarF;
    self.statusToolbar.status = self.statusFrame.status;
}
@end
