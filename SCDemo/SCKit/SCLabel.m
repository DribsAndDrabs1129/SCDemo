//
//  SCLabel.m
//  SCLabel
//
//  Created by Channe Sun on 2017/12/1.
//  Copyright © 2017年 University of Leeds. All rights reserved.
//

#import "SCLabel.h"


@implementation SCLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - NSCoding

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self)
        return nil;
    [self doInitWork];
    return self;
}

- (instancetype)init{
    self = [super initWithFrame:CGRectZero];
    if (!self)
        return nil;
    [self doInitWork];
    return self;
}

- (void)doInitWork{
    [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    _adjustsFitWidthToFontSize = NO;
    _notifyWhenSizeChanged = YES;
    _useMinmumSize = NO;
    _edgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
}

- (void)layoutSubviews{
    NSLog(@"%@,layoutSubviews",[self class]);
    if (_corner) {
        [self addBezierPath:_corner];
    }
    else{
        [self addBezierPath:UIRectCornerAllCorners];
    }
}

#pragma mark - Draw
- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines{
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds,
                                                                 self.edgeInsets) limitedToNumberOfLines:numberOfLines];
    rect.origin.x -= self.edgeInsets.left;
    rect.origin.y -= self.edgeInsets.top;
    rect.size.width += self.edgeInsets.left + self.edgeInsets.right;
    rect.size.height += self.edgeInsets.top + self.edgeInsets.bottom;
    return rect;
}

- (void)drawTextInRect:(CGRect)rect{
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

#pragma mark - Copy property

- (void)copyFrom:(UILabel *)targetLabel{
    [self copyFrom:targetLabel withFrame:CGRectZero];
}

- (void)deepCopyFrom:(UILabel *)targetLabel{
    [self deepCopyFrom:targetLabel withFrame:CGRectZero];
}

- (void)customCopyFrom:(UILabel *)targetLabel custom:(LabelProperty)property{
    [self customCopyFrom:targetLabel custom:property withFrame:CGRectZero];
}

- (void)copyFrom:(UILabel *)targetLabel withFrame:(CGRect)frame{
    if (frame.size.width != 0 || frame.size.height != 0) {
        self.frame = frame;
    }
    self.font = targetLabel.font;
    self.textColor = targetLabel.textColor;
    self.backgroundColor = targetLabel.backgroundColor;
}

- (void)deepCopyFrom:(UILabel *)targetLabel withFrame:(CGRect)frame{
    if (frame.size.width != 0 || frame.size.height != 0) {
        self.frame = frame;
    }
    self.font = targetLabel.font;
    self.textColor = targetLabel.textColor;
    self.backgroundColor = targetLabel.backgroundColor;
    self.textAlignment = targetLabel.textAlignment;
    self.numberOfLines = targetLabel.numberOfLines;
    self.lineBreakMode = targetLabel.lineBreakMode;
    self.highlightedTextColor = targetLabel.highlightedTextColor;
    self.adjustsFontSizeToFitWidth = targetLabel.adjustsFontSizeToFitWidth;
}

- (void)customCopyFrom:(UILabel *)targetLabel custom:(LabelProperty)property withFrame:(CGRect)frame{
    if (frame.size.width != 0 || frame.size.height != 0) {
        self.frame = frame;
    }
    if (property & SC_CommonPorperty) {
        self.font = targetLabel.font;
        self.textColor = targetLabel.textColor;
        self.backgroundColor = targetLabel.backgroundColor;
    }
    else{
        if (property & SC_Font) {
            self.font = targetLabel.font;
        }
        if (property & SC_TextColor) {
            self.textColor = targetLabel.textColor;
        }
        if (property & SC_BackgroundColor) {
            self.backgroundColor = targetLabel.backgroundColor;
        }
    }
    
    if (property & SC_FormatPorperty) {
        self.numberOfLines = targetLabel.numberOfLines;
        self.lineBreakMode = targetLabel.lineBreakMode;
        self.highlightedTextColor = targetLabel.highlightedTextColor;
        self.adjustsFontSizeToFitWidth = targetLabel.adjustsFontSizeToFitWidth;
        self.textAlignment = targetLabel.textAlignment;
    }
    else{
        if (property & SC_NumberOfLines) {
            self.numberOfLines = targetLabel.numberOfLines;
        }
        if (property & SC_LineBreakMode) {
            self.lineBreakMode = targetLabel.lineBreakMode;
        }
        if (property & SC_HighlightedTextColor) {
            self.highlightedTextColor = targetLabel.highlightedTextColor;
        }
        if (property & SC_AdjustsFontSizeToFitWidth) {
            self.adjustsFontSizeToFitWidth = targetLabel.adjustsFontSizeToFitWidth;
        }
        if (property & SC_TextAlignment) {
            self.textAlignment = targetLabel.textAlignment;
        }
    }
    
    if (property & SC_LayerPorperty) {
        self.layer.cornerRadius = targetLabel.layer.cornerRadius;
        self.layer.borderColor = targetLabel.layer.borderColor;
        self.layer.borderWidth = targetLabel.layer.borderWidth;
    }
    else{
        if (property & SC_CornerRadius) {
            self.layer.cornerRadius = targetLabel.layer.cornerRadius;
        }
        if (property & SC_BorderColor) {
            self.layer.borderColor = targetLabel.layer.borderColor;
        }
        if (property & SC_BorderWidth) {
            self.layer.borderWidth = targetLabel.layer.borderWidth;
        }
    }
}

- (void)addBezierPath:(UIRectCorner)corner{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(self.layer.cornerRadius, self.layer.cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];        maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask  = maskLayer;
}

#pragma mark - Setter

- (void)setRestrictFont:(CGFloat)restrictFont{
    _restrictFont = restrictFont;
    self.font = [UIFont systemFontOfSize:restrictFont];
}

- (void)setRestrictSize:(CGSize)restrictSize{
    _restrictSize = restrictSize;
}

- (void)setAdjustsFitWidthToFontSize:(BOOL)adjustsFitWidthToFontSize{
    _adjustsFitWidthToFontSize = adjustsFitWidthToFontSize;
    if (adjustsFitWidthToFontSize) {
        self.numberOfLines = 0;
        [self updateSize];
    }
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets{
    _edgeInsets = edgeInsets;
}

- (void)setCorner:(UIRectCorner)corner{
    _corner = corner;
    [self setNeedsLayout];
}

#pragma mark - getter

- (CGFloat)top{
    CGFloat temTop = self.frame.origin.y;
#ifdef DEBUG
    NSLog(@"%@: top :%f",[self class], temTop);
#endif
    return self.frame.origin.y;
}

- (CGFloat)bottom{
    CGFloat temBottom = self.frame.origin.y + self.frame.size.height;
#ifdef DEBUG
    NSLog(@"%@: top :%f",[self class], temBottom);
#endif
    return temBottom;
}

- (CGFloat)left{
    CGFloat temLeft = self.frame.origin.x;
#ifdef DEBUG
    NSLog(@"%@: top :%f",[self class], temLeft);
#endif
    return temLeft;
}

- (CGFloat)right{
    CGFloat temRight = self.frame.origin.x + self.frame.size.width;
#ifdef DEBUG
    NSLog(@"%@: top :%f",[self class], temRight);
#endif
    return temRight;
}

#pragma mark - private

- (void)updateSize{
    CGSize targetSize = CGSizeZero;
    if (_restrictSize.width) {
        targetSize = _restrictSize;
    }
    else {
        targetSize = CGSizeMake(self.frame.size.width, MAXFLOAT);
    }
    
    if (!targetSize.width) {
        return;
    }
    
    CGRect originalRect = self.frame;
    if (self.text.length > 0) {
        CGSize size = [self sizeThatFits:targetSize];
        if (!_useMinmumSize) {
            if (targetSize.height == MAXFLOAT) {
                size.width = targetSize.width;
            }
            else if (targetSize.width == MAXFLOAT){
                size.height = targetSize.height;
            }
        }
        self.frame = CGRectMake(originalRect.origin.x, originalRect.origin.x, size.width, size.height);
        if (_notifyWhenSizeChanged) {
            CGFloat newWidth = size.width;
            CGFloat newHeight = size.height;
            NSString *newText = self.text;
            if (_textChangeCB) {
                _textChangeCB(newWidth, newHeight, newText);
            }
            else{
                [[NSNotificationCenter defaultCenter] postNotificationName:SCLabelSizeChanged object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithFloat:size.width],@"with",[NSNumber numberWithFloat:size.height],@"height",self.text,@"text",nil]];
            }
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    NSString *oldText = [change objectForKey:NSKeyValueChangeOldKey];
    NSString *newText = [change objectForKey:NSKeyValueChangeNewKey];
    if (![oldText isEqualToString:newText]) {
        if (_adjustsFitWidthToFontSize) {
#ifdef DEBUG
            NSLog(@"%@: label text changed",[self class]);
#endif
            [self updateSize];
        }
    }
}

- (void)dealloc{
#ifdef DEBUG
    NSLog(@"%@: delloc",[self class]);
#endif
    @try {
        [self removeObserver:self forKeyPath:@"text"];
    }
    @catch (NSException *exception) {
#ifdef DEBUG
        NSLog(@"%@: deletion done",[self class]);
#endif
    }
}

@end
