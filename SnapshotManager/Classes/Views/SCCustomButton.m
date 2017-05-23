//
//  SCCustomButton.m
//  SCCustomButton
//
//  Created by ShannonChen on 17/4/20.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCCustomButton.h"
#import "UIView+Layout.h"

@implementation SCCustomButton

#pragma mark - Initialization
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    _interTitleImageSpacing = 4;
    _imagePosition = SCCustomButtonImagePositionLeft;
    _imageCornerRadius = 0;
}

#pragma mark - Setter
- (void)setImagePosition:(SCCustomButtonImagePosition)imagePosition {
    _imagePosition = imagePosition;
    
    [self setNeedsLayout];
}

- (void)setInterTitleImageSpacing:(CGFloat)interTitleImageSpacing {
    _interTitleImageSpacing = interTitleImageSpacing;
    
    [self setNeedsLayout];
}

- (void)setImageCornerRadius:(CGFloat)imageCornerRadius {
    _imageCornerRadius = imageCornerRadius;
    
    self.imageView.layer.cornerRadius = imageCornerRadius;
    self.imageView.layer.masksToBounds = YES;
}

#pragma mark - Layout subviews
- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (CGRectIsEmpty(self.bounds)) {
        return;
    }
    
    [self p_resizeSubviews];
    
    if (self.imagePosition == SCCustomButtonImagePositionLeft) { // 图片在左侧：🏝+文字
        
        [self p_layoutSubViewsForImagePositionLeft];
        
    } else if (self.imagePosition == SCCustomButtonImagePositionRight) { // 图片在右侧：文字+🏔
        
        [self p_layoutSubViewsForImagePositionRight];
        
    } else if (self.imagePosition == SCCustomButtonImagePositionTop) { // 图片在顶部
        
        [self p_layoutSubViewsForImagePositionTop];
    } else if (self.imagePosition == SCCustomButtonImagePositionBottom) { // 图片在底部
        
        [self p_layoutSubViewsForImagePositionBottom];
    }
}

/// 计算尺寸
- (void)p_resizeSubviews {
    self.imageView.size = self.imageView.image.size;
    [self.titleLabel sizeToFit];
    
    if (self.imagePosition == SCCustomButtonImagePositionRight ||   // 图片在右侧：文字+🏔
        self.imagePosition == SCCustomButtonImagePositionLeft) {    // 图片在左侧：🏝+文字
        if (self.titleLabel.width > (self.width - self.interTitleImageSpacing - self.imageView.width)) {
            self.titleLabel.width = self.width;
        }
    } else if (self.imagePosition == SCCustomButtonImagePositionTop ||      // 图片在顶部
               self.imagePosition == SCCustomButtonImagePositionBottom) {   // 图片在底部
        if (self.titleLabel.width > self.width) {
            self.titleLabel.width = self.width;
        }
    }
}

/// 图片在左侧
- (void)p_layoutSubViewsForImagePositionLeft {
    if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight) {   // 整体靠右
        
        self.titleLabel.x = self.width - self.titleLabel.width;
        self.titleLabel.y = (self.height - self.titleLabel.height) * 0.5;
        
        self.imageView.x = self.width - self.titleLabel.width - self.interTitleImageSpacing - self.imageView.width;
        self.imageView.y = (self.height - self.imageView.height) * 0.5;
        
    } else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft) { // 整体靠左
        self.imageView.x = 0;
        self.imageView.y = (self.height - self.imageView.height) * 0.5;
        
        self.titleLabel.x = self.imageView.right + self.interTitleImageSpacing;
        self.titleLabel.y = (self.height - self.titleLabel.height) * 0.5;
        
    } else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentCenter) { // 整体居中
        self.imageView.x = self.width * 0.5 - (self.titleLabel.width + self.interTitleImageSpacing + self.imageView.width) * 0.5;
        self.imageView.y = (self.height - self.imageView.height) * 0.5;
        
        self.titleLabel.x = self.interTitleImageSpacing + self.imageView.right;
        self.titleLabel.y = (self.height - self.titleLabel.height) * 0.5;
    }
}

/// 图片在右侧
- (void)p_layoutSubViewsForImagePositionRight {
    if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight) {   // 整体靠右
        
        self.imageView.x = self.width - self.imageView.width;
        self.imageView.y = (self.height - self.imageView.height) * 0.5;
        
        self.titleLabel.x = self.width - self.imageView.width - self.interTitleImageSpacing - self.titleLabel.width;
        self.titleLabel.y = (self.height - self.titleLabel.height) * 0.5;
        
    } else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft) { // 整体靠左
        self.titleLabel.x = 0;
        self.titleLabel.y = (self.height - self.titleLabel.height) * 0.5;
        
        self.imageView.x = self.interTitleImageSpacing + self.titleLabel.width;
        self.imageView.y = (self.height - self.imageView.height) * 0.5;
        
    } else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentCenter) { // 整体居中
        self.titleLabel.x = self.width * 0.5 - (self.titleLabel.width + self.interTitleImageSpacing + self.imageView.width) * 0.5;
        self.titleLabel.y = (self.height - self.titleLabel.height) * 0.5;
        
        self.imageView.x = self.interTitleImageSpacing + self.titleLabel.width;
        self.imageView.y = (self.height - self.imageView.height) * 0.5;
    }
}

/// 图片在顶部
- (void)p_layoutSubViewsForImagePositionTop {
    if (self.contentVerticalAlignment == UIControlContentVerticalAlignmentTop) {  // 整体靠顶部
        
        self.imageView.y = 0;
        self.imageView.centerX = self.width * 0.5;
        
        self.titleLabel.y = self.imageView.bottom + self.interTitleImageSpacing;
        self.titleLabel.centerX = self.width * 0.5;
        
    } else if (self.contentVerticalAlignment == UIControlContentVerticalAlignmentBottom) { // 整体靠底部
        
        self.titleLabel.y = self.height - self.titleLabel.height;
        self.titleLabel.centerX = self.width * 0.5;
        
        self.imageView.y = self.height - (self.imageView.height + self.titleLabel.height + self.interTitleImageSpacing);
        self.imageView.centerX = self.width * 0.5;
        
    } else if (self.contentVerticalAlignment == UIControlContentVerticalAlignmentCenter) { // 整体居中
        self.imageView.y = self.height * 0.5 - (self.imageView.height + self.titleLabel.height + self.interTitleImageSpacing) * 0.5;
        self.imageView.centerX = self.width * 0.5;
        
        self.titleLabel.y = self.imageView.bottom + self.interTitleImageSpacing;
        self.titleLabel.centerX = self.width * 0.5;
    }
}

/// 图片在底部
- (void)p_layoutSubViewsForImagePositionBottom {
    if (self.contentVerticalAlignment == UIControlContentVerticalAlignmentTop) {  // 整体靠顶部
        
        self.titleLabel.y = 0;
        self.titleLabel.centerX = self.width * 0.5;
        
        self.imageView.y = self.titleLabel.bottom + self.interTitleImageSpacing;
        self.imageView.centerX = self.width * 0.5;
        
    } else if (self.contentVerticalAlignment == UIControlContentVerticalAlignmentBottom) { // 整体靠底部
        
        self.imageView.y = self.height - self.imageView.height;
        self.imageView.centerX = self.width * 0.5;
        
        self.titleLabel.y = self.height - (self.titleLabel.height + self.interTitleImageSpacing + self.imageView.height);
        self.titleLabel.centerX = self.width * 0.5;
        
    } else if (self.contentVerticalAlignment == UIControlContentVerticalAlignmentCenter) { // 整体居中
        
        self.titleLabel.y = self.height * 0.5 - (self.imageView.height + self.titleLabel.height + self.interTitleImageSpacing) * 0.5;
        self.titleLabel.centerX = self.width * 0.5;
        
        self.imageView.y = self.titleLabel.bottom + self.interTitleImageSpacing;
        self.imageView.centerX = self.width * 0.5;

    }
}

@end
