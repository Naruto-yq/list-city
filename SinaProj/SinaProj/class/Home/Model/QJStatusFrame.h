//
//  QJStatusFrame.h
//  SinaProj
//
//  Created by 杨丽娟 on 15/12/29.
//  Copyright © 2015年 Qin.Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

//name font
#define  QJStatusNameFont  [UIFont systemFontOfSize:15]
#define  QJStatusTimeFont  [UIFont systemFontOfSize:12]
#define  QJStatusSourceFont  [UIFont systemFontOfSize:12]
#define  QJStatusContentFont  [UIFont systemFontOfSize:13]

#define QJStatueCellMargin 8
//间距
#define  QJStatusCellBorder 8


#define QJStatusPhotoW 70//([UIScreen mainScreen].bounds.size.width - 4*QJStatusCellBorder)/4
#define  TextAttribute(textAttrs, font) do{\
                                            textAttrs[NSFontAttributeName] = font;\
                                          }while(0)
@class QJStatus;
@interface QJStatusFrame : NSObject
@property(nonatomic, strong)QJStatus *status;

//original view
@property(nonatomic, assign, readonly ) CGRect topViewF;
@property(nonatomic, assign, readonly ) CGRect iconViewF;
@property(nonatomic, assign, readonly ) CGRect vipViewF;
@property(nonatomic, assign, readonly ) CGRect photoViewF;
@property(nonatomic, assign, readonly ) CGRect nameLabelF;
@property(nonatomic, assign, readonly ) CGRect timeLabelF;
@property(nonatomic, assign, readonly ) CGRect sourceLabelF;
@property(nonatomic, assign, readonly ) CGRect contentLabelF;


//retweet view
@property(nonatomic, assign, readonly ) CGRect retweetViewF;
@property(nonatomic, assign, readonly ) CGRect retweetNameLabelF;
@property(nonatomic, assign, readonly ) CGRect retweetContentLabelF;
@property(nonatomic, assign, readonly ) CGRect retweetPhotoViewF;


//tool bar
@property(nonatomic, assign, readonly ) CGRect statusToolbarF;


//cell height
@property (nonatomic,assign, readonly) CGFloat cellHeight;

@end
