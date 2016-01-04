//
//  QJRetweetStatusView.m
//  SinaProj
//
//  Created by 杨丽娟 on 15/12/31.
//  Copyright © 2015年 Qin.Yu. All rights reserved.
//

#import "QJRetweetStatusView.h"
#import "QJStatusFrame.h"
#import "QJStatus.h"
#import "QJUser.h"
#import "QJStatusFrame.h"
#import "QJPhoto.h"
#import "QJPhotosView.h"
#import "UIImageView+WebCache.h"

@interface QJRetweetStatusView ()

@property(nonatomic, weak) UILabel *retweetNameLabel;
@property(nonatomic, weak) UILabel *retweetContentLabel;
@property(nonatomic, weak) QJPhotosView *retweetPhotoView;

@end
@implementation QJRetweetStatusView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage resizedImageWithName:@"timeline_retweet_background"];
        self.userInteractionEnabled = YES;
        [self SetupSubviews];
    }
    return self;
}

- (void)SetupSubviews
{
    UILabel *retweetNameLabel = [[UILabel alloc]init];
    retweetNameLabel.font = QJStatusNameFont;
    retweetNameLabel.textColor = [UIColor blueColor];
    retweetNameLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:retweetNameLabel];
    self.retweetNameLabel = retweetNameLabel;
    
    UILabel *retweetContentLabel = [[UILabel alloc]init];
    retweetContentLabel.font = QJStatusContentFont;
    retweetContentLabel.textColor = RGB(39, 39, 39);
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    QJPhotosView *retweetPhotoView = [[QJPhotosView alloc]init];
    [self addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
}

- (void)setStatusFrame:(QJStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    QJStatus *retweetStatus = statusFrame.status.retweeted_status;
    
    self.retweetNameLabel.text = [NSString stringWithFormat:@"@%@", retweetStatus.user.name];
    self.retweetNameLabel.frame = statusFrame.retweetNameLabelF;
    
    self.retweetContentLabel.text = retweetStatus.text;
    self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
    
    if(retweetStatus.pic_urls){
        self.retweetPhotoView.hidden = NO;
        //QJPhoto *photo = retweetStatus.pic_urls[0];
        //[self.retweetPhotoView setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.retweetPhotoView.pic_urls = statusFrame.status.retweeted_status.pic_urls;
        self.retweetPhotoView.frame = statusFrame.retweetPhotoViewF;
    }else{
        self.retweetPhotoView.hidden = YES;
    }
}
@end
