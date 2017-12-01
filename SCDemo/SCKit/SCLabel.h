//
//  SCLabel.h
//  SCLabel
//
//  Created by Channe Sun on 2017/12/1.
//  Copyright © 2017年 University of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCLabelSizeChanged @"SCLabelSizeChanged"

typedef NS_ENUM(NSUInteger, LabelProperty) {
    //common propert
    SC_CommonPorperty                = 1 << 0,
    SC_Font                          = 1 << 1,
    SC_TextColor                     = 1 << 2,
    SC_BackgroundColor               = 1 << 3,
    //format property
    SC_FormatPorperty                = 1 << 4,
    SC_TextAlignment                 = 1 << 5,
    SC_LineBreakMode                 = 1 << 6,
    SC_NumberOfLines                 = 1 << 7,
    SC_HighlightedTextColor          = 1 << 8,
    SC_AdjustsFontSizeToFitWidth     = 1 << 9,
    //layer property
    SC_LayerPorperty                 = 1 << 10,
    SC_CornerRadius                  = 1 << 11,
    SC_BorderWidth                   = 1 << 12,
    SC_BorderColor                   = 1 << 13,
};

typedef void(^textChangeCallBack)(CGFloat newWidth, CGFloat newHeight, NSString *newText);

@interface SCLabel : UILabel

- (void)copyFrom:(UILabel *)targetLabel;
- (void)deepCopyFrom:(UILabel *)targetLabel;
- (void)customCopyFrom:(UILabel *)targetLabel custom:(LabelProperty)property;

- (void)copyFrom:(UILabel *)targetLabel withFrame:(CGRect)frame;
- (void)deepCopyFrom:(UILabel *)targetLabel withFrame:(CGRect)frame;
- (void)customCopyFrom:(UILabel *)targetLabel custom:(LabelProperty)property withFrame:(CGRect)frame ;

@property (nonatomic)CGSize restrictSize;
@property (nonatomic)CGFloat restrictFont;
@property (nonatomic)UIRectCorner corner;
@property (nonatomic)BOOL adjustsFitWidthToFontSize;//default is NO
@property (nonatomic)BOOL notifyWhenSizeChanged;//default is YES
@property (nonatomic)BOOL useMinmumSize;//default is No

@property (nonatomic)CGFloat top;
@property (nonatomic)CGFloat bottom;
@property (nonatomic)CGFloat left;
@property (nonatomic)CGFloat right;

@property (nonatomic)UIEdgeInsets edgeInsets;// default is 5;

@property (nonatomic, copy)textChangeCallBack textChangeCB;

@end
