//
//  QJTextView.h
//  SinaProj
//
//  Created by 杨丽娟 on 16/1/1.
//  Copyright © 2016年 Qin.Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QJTextView : UITextView
@property(nonatomic, copy)NSString *placeholder;
@property (nonatomic,strong) UIColor *placeholderColor;
@property(nonatomic, strong)UIFont *placeholderFont;
@end
