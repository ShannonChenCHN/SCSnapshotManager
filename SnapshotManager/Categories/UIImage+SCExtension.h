//
//  UIImage+SCExtension.h
//  SCSnapshotDemo
//
//  Created by ShannonChen on 2017/3/19.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SCExtension)

/// 根据 CIImge 生成指定大小的 UIImage
+ (UIImage *)sc_imageWithCIImage:(CIImage *)image size:(CGSize)size;

@end
