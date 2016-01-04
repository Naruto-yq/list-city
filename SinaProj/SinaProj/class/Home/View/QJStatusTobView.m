//
//  QJStatusTobView.m
//  SinaProj
//
//  Created by 杨丽娟 on 15/12/31.
//  Copyright © 2015年 Qin.Yu. All rights reserved.
//

#import "QJStatusTobView.h"
#import "QJStatusFrame.h"
#import "QJStatus.h"
#import "QJUser.h"
#import "QJStatusFrame.h"
#import "QJRetweetStatusView.h"
#import "QJPhoto.h"
#import "QJPhotosView.h"
#import "UIImageView+WebCache.h"


@interface QJStatusTobView ()
@property(nonatomic, weak) UIImageView *iconView;
@property(nonatomic, weak) UIImageView *vipView;
@property(nonatomic, weak) QJPhotosView *photoView;
@property(nonatomic, weak) UILabel *nameLabel;
@property(nonatomic, weak) UILabel *timeLabel;
@property(nonatomic, weak) UILabel *sourceLabel;
@property(nonatomic, weak) UILabel *contentLabel;
//retweet view
@property(nonatomic, weak) QJRetweetStatusView *retweetView;
@end

@implementation QJStatusTobView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizedImageWithName:@"timeline_card_top_background"];
        self.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_top_background_highlighted"];
        [self SetupSubviews];
    }
    return self;
}

- (void)SetupSubviews
{
    UIImageView *iconView = [[UIImageView alloc]init];
    [self addSubview:iconView];
    self.iconView = iconView;
    
    UIImageView *vipView = [[UIImageView alloc]init];
    vipView.contentMode = UIViewContentModeCenter;
    [self addSubview:vipView];
    self.vipView = vipView;
    
    QJPhotosView *photoView = [[QJPhotosView alloc]init];
    [self addSubview:photoView];
    self.photoView = photoView;
    
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.font = QJStatusNameFont;
    nameLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.font = QJStatusTimeFont;
    timeLabel.textColor = RGB(240, 140, 19);
    timeLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UILabel *sourceLabel = [[UILabel alloc]init];
    sourceLabel.font = QJStatusSourceFont;
    sourceLabel.backgroundColor = [UIColor clearColor];
    sourceLabel.textColor = RGB(135, 135, 135);
    [self addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.font = QJStatusContentFont;
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.textColor = RGB(39, 39, 39);
    contentLabel.numberOfLines = 0;
    [self addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    QJRetweetStatusView *retweetView = [[QJRetweetStatusView alloc]init];
    retweetView.userInteractionEnabled = YES;
    [self addSubview:retweetView];
    self.retweetView = retweetView;
}

- (void)setStatusFrame:(QJStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    QJStatus *status = statusFrame.status;
    QJUser *user = status.user;
    
    [self.iconView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    self.iconView.frame = statusFrame.iconViewF;
    
    self.nameLabel.text = user.name;
    self.nameLabel.frame = statusFrame.nameLabelF;
    
    if(user.mbtype > 2){
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageWithName:[NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank]];
        self.nameLabel.textColor = [UIColor orangeColor];
        self.vipView.frame = statusFrame.vipViewF;
    }else{
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    self.timeLabel.text = status.created_at;
    CGFloat timeLabelX = self.nameLabel.frame.origin.x;
    CGFloat timeLabelY = CGRectGetMaxY(self.nameLabel.frame) + QJStatusCellBorder*0.5;
    NSMutableDictionary *timeAttrs = [NSMutableDictionary dictionary];
    TextAttribute(timeAttrs, QJStatusTimeFont);
    CGSize timeLabelSize = [status.created_at sizeWithAttributes:timeAttrs];
    self.timeLabel.frame = (CGRect){timeLabelX, timeLabelY, timeLabelSize};
    
    self.sourceLabel.text = status.source;
    CGFloat sourceLabelX = CGRectGetMaxX(self.timeLabel.frame)+QJStatusCellBorder;
    CGFloat sourceLabelY = self.timeLabel.frame.origin.y;
    NSMutableDictionary *sourceAttrs = [NSMutableDictionary dictionary];
    TextAttribute(sourceAttrs, QJStatusSourceFont);
    CGSize sourceLabelSize = [status.source sizeWithAttributes:sourceAttrs];
    self.sourceLabel.frame = (CGRect){sourceLabelX, sourceLabelY, sourceLabelSize};
    
    self.contentLabel.text = status.text;
    self.contentLabel.frame = statusFrame.contentLabelF;
    
    if (status.pic_urls.count) {
        self.photoView.hidden = NO;
        //QJPhoto *photo = status.pic_urls[0];
        //[self.photoView setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.photoView.pic_urls = status.pic_urls;
        self.photoView.frame = statusFrame.photoViewF;
    }else{
        self.photoView.hidden = YES;
    }
    
    QJStatus *retweetStatus = statusFrame.status.retweeted_status;
    
    if(retweetStatus){
        self.retweetView.hidden = NO;
        self.retweetView.frame = statusFrame.retweetViewF;
        self.retweetView.statusFrame = statusFrame;
    }else{
        self.retweetView.hidden = YES;
    }
}

@end
