//
//  QJSearchBar.m
//  SinaProj
//
//  Created by 杨丽娟 on 15/12/27.
//  Copyright © 2015年 Qin.Yu. All rights reserved.
//

#import "QJSearchBar.h"

@interface QJSearchBar ()
@property(nonatomic, weak) UIImageView *iconView;
@end

@implementation QJSearchBar

+ (instancetype)searchBar
{
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:13];
        self.background = [UIImage resizedImageWithName:@"searchbar_textfield_background"];
        UIImageView *iconView = [[UIImageView alloc]initWithImage:[UIImage imageWithName:@"searchbar_textfield_search_icon"]];
        iconView.contentMode = UIViewContentModeCenter;
        self.iconView = iconView;
        self.leftView = iconView;//self.iconView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.placeholder = @"搜索";
        self.returnKeyType = UIReturnKeySearch;
        self.enablesReturnKeyAutomatically = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    ALog(@"%f", self.iconView.image.size.width+15);
    self.leftView.frame = CGRectMake(0, 0, self.iconView.image.size.width+15, self.frame.size.height);
}
@end
