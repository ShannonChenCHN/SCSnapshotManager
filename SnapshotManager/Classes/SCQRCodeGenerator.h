//
//  SCQRCodeGenerator.h
//  SCSnapshotDemo
//
//  Created by ShannonChen on 2017/3/19.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCQRCodeGenerator : NSObject


/**
 根据指定字符串生成指定大小的二维码图片
 */
+ (UIImage *)generateQRCodeImageWithString:(NSString *)string size:(CGSize)size;

@end

NS_ASSUME_NONNULL_END

