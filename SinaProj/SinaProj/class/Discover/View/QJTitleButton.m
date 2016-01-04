//
//  QJTitleButton.m
//  SinaProj
//
//  Created by 杨丽娟 on 15/12/27.
//  Copyright © 2015年 Qin.Yu. All rights reserved.
//

#import "QJTitleButton.h"
#define  TextAttribute(textAttrs, font) do{\
                                            textAttrs[NSFontAttributeName] = font;\
                                          }while(0)
#define titleRatio (0.8)
@implementation QJTitleButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //高亮时不要自动调整图标
        self.adjustsImageWhenHighlighted = NO;
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self setBackgroundImage:[UIImage resizedImageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
        
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = UIBaselineAdjustmentAlignCenters;
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = self.frame.size.width*titleRatio;
    CGFloat imageY = 0;
    CGFloat imageW = self.frame.size.width-self.frame.size.width*titleRatio;
    CGFloat imageH = self.frame.size.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = self.frame.size.width*titleRatio;
    CGFloat titleH = self.frame.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    TextAttribute(textAttrs, self.titleLabel.font);
    CGSize titleSize = [title sizeWithAttributes:textAttrs];
    
    CGRect frame = self.frame;
    
    frame.size.width = titleSize.width + 30;
    self.frame = frame;
    
    [super setTitle:title forState:state];
}
@end
