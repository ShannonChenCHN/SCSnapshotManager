//
//  NSString+SCExtension.h
//  SCSnapshotDemo
//
//  Created by ShannonChen on 2017/3/19.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (SCExtension)

#pragma mark - size calculation

- (CGSize)sc_sizeForFont:(UIFont *)font;
- (CGSize)sc_sizeForFont:(UIFont *)font maxSize:(CGSize)size;

- (CGFloat)sc_widthForFont:(UIFont *)font;
- (CGFloat)sc_widthForFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;

- (CGFloat)sc_heightForFont:(UIFont *)font width:(CGFloat)width;
- (CGFloat)sc_heightForFont:(UIFont *)font maxSize:(CGSize)size;
- (CGFloat)sc_heightForFont:(UIFont *)font width:(CGFloat)width lineSpacing:(CGFloat)lineSpacing;

@end
