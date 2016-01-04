//
//  QJPhotoView.m
//  SinaProj
//
//  Created by 杨丽娟 on 16/1/1.
//  Copyright © 2016年 Qin.Yu. All rights reserved.
//

#import "QJPhotoView.h"
#include "QJPhoto.h"
#import "UIImageView+WebCache.h"

@interface QJPhotoView ()
@property(nonatomic, weak) UIImageView *gifView;
@end

@implementation QJPhotoView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self SetupSubviews];
    }
    return self;
}

- (void)SetupSubviews
{
    UIImage *image = [UIImage imageWithName:@"timeline_image_gif"];
    UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:gifView];
    self.gifView = gifView;
}

-(void)setPhoto:(QJPhoto *)photo
{
    _photo = photo;
    self.gifView.hidden = ![_photo.thumbnail_pic hasSuffix:@"gif"];
    [self setImageWithURL:[NSURL URLWithString:_photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.gifView.layer.anchorPoint = CGPointMake(1, 1);
    self.gifView.layer.position = CGPointMake(self.frame.size.width, self.frame.size.height);
}

@end
