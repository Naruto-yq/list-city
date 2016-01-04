//
//  QJPhotosView.m
//  SinaProj
//
//  Created by 杨丽娟 on 16/1/1.
//  Copyright © 2016年 Qin.Yu. All rights reserved.
//

#import "QJPhotosView.h"
#import "QJPhoto.h"
#import "QJStatusFrame.h"
#import "QJPhotoView.h"
#import "UIImageView+WebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@implementation QJPhotosView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self SetupSubviews];
    }
    return self;
}

- (void)SetupSubviews
{
    for (int i = 0; i < 9; i++) {
        QJPhotoView *photoView= [[QJPhotoView alloc]init];
        photoView.contentMode = UIViewContentModeScaleAspectFill;
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PhotosView_photoClick:)];
        [photoView addGestureRecognizer:recognizer];
        photoView.tag = i;
        [self addSubview:photoView];
    }
}


- (void)PhotosView_photoClick:(UITapGestureRecognizer *)recognizer
{
    int count = (int)self.pic_urls.count;
    NSMutableArray *photosArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        MJPhoto *mjPhoto = [[MJPhoto alloc]init];
        QJPhoto *qjPhoto = self.pic_urls[i];
        NSString *midPhotoUrl = [qjPhoto.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        mjPhoto.url = [NSURL URLWithString:midPhotoUrl];
        mjPhoto.srcImageView = self.subviews[i];
        [photosArray addObject:mjPhoto];
    }
    
    MJPhotoBrowser *photoBrowser = [[MJPhotoBrowser alloc]init];
    photoBrowser.currentPhotoIndex = recognizer.view.tag;
    photoBrowser.photos = photosArray;
    [photoBrowser show];
}

- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    
    for (int i = 0; i < self.subviews.count; i++) {
        QJPhotoView *photoView = self.subviews[i];
        
        if(i < _pic_urls.count){
            photoView.hidden = NO;
            photoView.photo = _pic_urls[i];
            [photoView setImageWithURL:[NSURL URLWithString:photoView.photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            photoView.clipsToBounds = YES;
        }else{
            photoView.hidden = YES;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat imageViewX = 0;
    CGFloat imageViewY = 0;
    CGFloat imageViewWH = QJStatusPhotoW;
    int cols = (self.pic_urls.count == 4)? 2: 3;
    
    for (int i = 0; i < self.pic_urls.count; i++) {
        QJPhotoView *photoView = self.subviews[i];
        int col = i%cols;
        int rol = i / cols;
        imageViewX = col * (imageViewWH + QJStatueCellMargin);
        imageViewY = rol * (imageViewWH + QJStatueCellMargin);
        photoView.frame = CGRectMake(imageViewX, imageViewY, imageViewWH, imageViewWH);
    }
}

@end
