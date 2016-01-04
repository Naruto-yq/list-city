//
//  QJComposeToolbar.h
//  SinaProj
//
//  Created by 杨丽娟 on 16/1/2.
//  Copyright © 2016年 Qin.Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QJComposeToolbar;
#define QJCompeseToolbarBaseTag 90
typedef enum {
    QJComposeToolbarButtonTypeCamera = QJCompeseToolbarBaseTag,
    QJComposeToolbarButtonTypePicture,
    QJComposeToolbarButtonTypeMention,
    QJComposeToolbarButtonTypeTrend,
    QJComposeToolbarButtonTypeEmotion
} QJComposeToolbarButtonType;

@protocol QJComposeToolbarDelegate <NSObject>
@optional
- (void)composeToolbar:(QJComposeToolbar *)toolbar didClickedButton:(QJComposeToolbarButtonType)buttonType;
@end

@interface QJComposeToolbar : UIView
@property (weak, nonatomic) id<QJComposeToolbarDelegate> delegate;
@end
