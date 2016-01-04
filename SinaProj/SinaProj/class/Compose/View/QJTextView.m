//
//  QJTextView.m
//  SinaProj
//
//  Created by 杨丽娟 on 16/1/1.
//  Copyright © 2016年 Qin.Yu. All rights reserved.
//

#import "QJTextView.h"

@interface QJTextView ()
@property(nonatomic, weak) UILabel *placeholderLabel;
@end

@implementation QJTextView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *placeholderLabel = [[UILabel alloc]init];
        placeholderLabel.textColor = [UIColor lightGrayColor];
        placeholderLabel.font = self.font;
        placeholderLabel.hidden = YES;
        [self addSubview:placeholderLabel];
        self.placeholderLabel = placeholderLabel;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Compose_TextDidChang) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)Compose_TextDidChang
{
    if (self.text.length) {
        self.placeholder = nil;
    }else{
        self.placeholder = @"分享新鲜事...";
    }
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    if (_placeholder.length) {
        _placeholderLabel.hidden = NO;
        _placeholderLabel.text = _placeholder;
        _placeholderLabel.frame = CGRectMake(10, 1, self.frame.size.width, 30);
    }else{
        _placeholderLabel.hidden = YES;
    }
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = _placeholderColor;
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont
{
    _placeholderFont = placeholderFont;
    self.placeholderLabel.font = _placeholderFont;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
