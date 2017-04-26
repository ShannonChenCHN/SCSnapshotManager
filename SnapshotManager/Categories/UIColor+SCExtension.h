//
//  UIColor+SCExtension.h
//  SCSnapshotDemo
//
//  Created by ShannonChen on 2017/3/19.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


#ifndef UIColorHex
#define UIColorHex(_hex_)   [UIColor sc_colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]
#endif

@interface UIColor (SCExtension)

/**
 Creates and returns a color object from hex string.
 
 @discussion
 Valid format: #RGB #RGBA #RRGGBB #RRGGBBAA 0xRGB ...
 The `#` or "0x" sign is not required.
 The alpha will be set to 1.0 if there is no alpha component.
 It will return nil when an error occurs in parsing.
 
 Example: @"0xF0F", @"66ccff", @"#66CCFF88"
 
 @param hexStr  The hex string value for the new color.
 
 @return        An UIColor object from string, or nil if an error occurs.
 
 参考 YYKit <https://github.com/ibireme/YYKit>
 */
+ (nullable UIColor *)sc_colorWithHexString:(NSString *)hexStr;

@end

NS_ASSUME_NONNULL_END
