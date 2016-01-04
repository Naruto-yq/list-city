//
//  QJStatusFrame.m
//  SinaProj
//
//  Created by 杨丽娟 on 15/12/29.
//  Copyright © 2015年 Qin.Yu. All rights reserved.
//

#import "QJStatusFrame.h"
#import "QJStatus.h"
#import "QJUser.h"

#define MAX(a,b) ((a)>(b)? a:b)
@implementation QJStatusFrame
- (void)setStatus:(QJStatus *)status
{
    _status = status;
    
    //cell width
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    //1.topView
    CGFloat topViewH = 0;
    CGFloat topViewW = cellW;
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    
    //2.icon
    CGFloat iconViewWH = 35;
    CGFloat iconViewX = QJStatusCellBorder;
    CGFloat iconViewY = QJStatusCellBorder;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    //3.user name
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + QJStatusCellBorder;
    CGFloat nameLabelY = QJStatusCellBorder;
    NSMutableDictionary *nameAttrs = [NSMutableDictionary dictionary];
    TextAttribute(nameAttrs, QJStatusNameFont);
    CGSize nameLabelSize = [status.user.name sizeWithAttributes:nameAttrs];
    _nameLabelF = (CGRect){nameLabelX, nameLabelY, nameLabelSize};
    
    //4.vip
    if (status.user.mbtype > 2) {
        CGFloat vipViewX = CGRectGetMaxX(_nameLabelF)+QJStatusCellBorder;
        CGFloat vipViewY = nameLabelY;
        CGFloat vipViewW = 14;
        CGFloat vipViewH = nameLabelSize.height;
        _vipViewF = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    }
    
    //5.time
    CGFloat timeLabelX = nameLabelX;//CGRectGetMaxX(_iconViewF) + QJStatusCellBorder;
    CGFloat timeLabelY = CGRectGetMaxY(_nameLabelF) + QJStatusCellBorder*0.5;
    NSMutableDictionary *timeAttrs = [NSMutableDictionary dictionary];
    TextAttribute(timeAttrs, QJStatusTimeFont);
    CGSize timeLabelSize = [status.created_at sizeWithAttributes:timeAttrs];
    _timeLabelF = (CGRect){timeLabelX, timeLabelY, timeLabelSize};
    
    //6.source
    CGFloat sourceLabelX = CGRectGetMaxX(_timeLabelF)+QJStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    NSMutableDictionary *sourceAttrs = [NSMutableDictionary dictionary];
    TextAttribute(sourceAttrs, QJStatusSourceFont);
    CGSize sourceLabelSize = [status.source sizeWithAttributes:sourceAttrs];
    _sourceLabelF = (CGRect){sourceLabelX, sourceLabelY, sourceLabelSize};
    
    //7.status content
    CGFloat contentLabelX = QJStatusCellBorder;
    CGFloat contentLabelY = MAX(CGRectGetMaxY(_iconViewF), CGRectGetMaxY(_timeLabelF)) + QJStatusCellBorder;
    CGFloat contentLabelMaxW = topViewW - 2*QJStatusCellBorder;
    NSMutableDictionary *contentAttrs = [NSMutableDictionary dictionary];
    TextAttribute(contentAttrs, QJStatusContentFont);
    CGSize contentLabelSize = [status.text boundingRectWithSize:CGSizeMake(contentLabelMaxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:contentAttrs context:nil].size;
    _contentLabelF = (CGRect){contentLabelX, contentLabelY, contentLabelSize};
    
    topViewH = CGRectGetMaxY(_contentLabelF);
    //8.photo
    if (status.pic_urls.count) {
        CGFloat photoViewX = contentLabelX;
        CGFloat photoViewY = CGRectGetMaxY(_contentLabelF) + QJStatusCellBorder;
        CGSize photoSize = [self PhotosSizeWithCount:(int)status.pic_urls.count];
        _photoViewF = (CGRect){photoViewX, photoViewY, photoSize};
        topViewH = CGRectGetMaxY(_photoViewF);
    }
    
    
    //9.retweet view
    if (status.retweeted_status) {
        //9.retweet view
        CGFloat retweetViewH = 0;
        CGFloat retweetViewW = contentLabelMaxW;
        CGFloat retweetViewX = contentLabelX;
        CGFloat retweetViewY = CGRectGetMaxY(_contentLabelF) + QJStatusCellBorder;
        
        //10. retweet user name
        CGFloat retweetNameLabelX = QJStatusCellBorder;
        CGFloat retweetNameLabelY = QJStatusCellBorder;
        NSMutableDictionary *retweetNameAttrs = [NSMutableDictionary dictionary];
        TextAttribute(retweetNameAttrs, QJStatusNameFont);
        CGSize retweetNameLabelSize = [[NSString stringWithFormat:@"@%@", status.retweeted_status.user.name] sizeWithAttributes:retweetNameAttrs];
        _retweetNameLabelF = (CGRect){retweetNameLabelX, retweetNameLabelY, retweetNameLabelSize};
        
        //11.retweet content
        CGFloat retweetContentLabelX = retweetNameLabelX;
        CGFloat retweetContentLabelY = CGRectGetMaxY(_retweetNameLabelF) + QJStatusCellBorder*0.5;
        CGFloat retweetContentLabelMaxW = retweetViewW - 2*QJStatusCellBorder;
        NSMutableDictionary *retweetContentAttrs = [NSMutableDictionary dictionary];
        TextAttribute(retweetContentAttrs, QJStatusContentFont);
        CGSize retweetContentLabelSize = [status.retweeted_status.text boundingRectWithSize:CGSizeMake(retweetContentLabelMaxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:retweetContentAttrs context:nil].size;
        _retweetContentLabelF = (CGRect){retweetContentLabelX, retweetContentLabelY, retweetContentLabelSize};
        
        retweetViewH = CGRectGetMaxY(_retweetContentLabelF);
        //12.retweet photo
        if (status.retweeted_status.pic_urls.count) {
            CGFloat retweetPhotoViewX = retweetContentLabelX;
            CGFloat retweetPhotoViewY = CGRectGetMaxY(_retweetContentLabelF) + QJStatusCellBorder;
            CGSize retweetPhotoViewSize = [self PhotosSizeWithCount:(int)status.retweeted_status.pic_urls.count];
            _retweetPhotoViewF = (CGRect){retweetPhotoViewX, retweetPhotoViewY, retweetPhotoViewSize};

            retweetViewH = CGRectGetMaxY(_retweetPhotoViewF);
        }
        
        retweetViewH += QJStatusCellBorder;
        _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        topViewH = CGRectGetMaxY(_retweetViewF);
    }
    //calc topViewF
    topViewH += QJStatusCellBorder;
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    //13.tool bar
    CGFloat toolBarX = topViewX;
    CGFloat toolBarY = CGRectGetMaxY(_topViewF)+ 1;
    CGFloat toolBarW = topViewW;
    CGFloat toolBarH = 40;
    _statusToolbarF = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    //calc cell height
    _cellHeight = CGRectGetMaxY(_statusToolbarF) + QJStatueCellMargin;
}

- (CGSize)PhotosSizeWithCount:(int)count
{
    int cols = (count == 4)? 2: 3;
    int rols = (count - 1)/cols + 1;
    
    CGFloat photoWH = QJStatusPhotoW;
    CGFloat photoW = cols * photoWH + (cols - 1) * QJStatueCellMargin;
    CGFloat photoH = rols * photoWH + (rols - 1) * QJStatueCellMargin;
    
    return CGSizeMake(photoW, photoH);
}
@end
