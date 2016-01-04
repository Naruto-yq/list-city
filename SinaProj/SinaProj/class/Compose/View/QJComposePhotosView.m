//
//  QJComposePhotosView.m
//  SinaProj
//
//  Created by 杨丽娟 on 16/1/3.
//  Copyright © 2016年 Qin.Yu. All rights reserved.
//

#import "QJComposePhotosView.h"

@implementation QJComposePhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)addImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = image;
    [self addSubview:imageView];
}

- (NSArray *)photosViewTotalImages
{
    NSArray *imageArray = [[NSArray alloc]init];
    NSMutableArray *tempImages = [NSMutableArray array];
    
    for (UIImageView *imageView in self.subviews) {
        [tempImages addObject:imageView.image];
    }
    imageArray = tempImages;
    return imageArray;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat imageViewW = 80;
    CGFloat imageViewH = 80;
    int maxCol = 3;
    CGFloat margin = (self.frame.size.width - maxCol*imageViewW)/(maxCol+1);
    
    for (int i = 0; i < self.subviews.count; i++) {
        UIImageView *imageView = self.subviews[i];
        CGFloat imageViewX = margin + (i%maxCol)*(imageViewW + margin);
        CGFloat imageViewY = (i/maxCol)*(imageViewH + margin);
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    }
    
}
@end
