//
//  SCCustomButton.h
//  SCCustomButton
//
//  Created by ShannonChen on 17/4/20.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 图片和文字的相对位置
typedef NS_ENUM(NSInteger, SCCustomButtonImagePosition) {
    SCCustomButtonImagePositionTop,     // 图片在文字顶部
    SCCustomButtonImagePositionLeft,    // 图片在文字左侧
    SCCustomButtonImagePositionBottom,  // 图片在文字底部
    SCCustomButtonImagePositionRight    // 图片在文字右侧
};


/**
 自定义按钮，可控制图片文字间距
 */
@interface SCCustomButton : UIButton

@property (assign, nonatomic) CGFloat interTitleImageSpacing;  ///< 图片文字间距
@property (assign, nonatomic) SCCustomButtonImagePosition imagePosition;     ///< 图片和文字的相对位置
@property (assign, nonatomic) CGFloat imageCornerRadius;                     ///< 图片圆角半径

@end
