//
//  SCSnapshotGenerator.m
//  SCSnapshotDemo
//
//  Created by ShannonChen on 2017/3/19.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCSnapshotGenerator.h"

@implementation SCSnapshotGenerator



/// 生成内容图片
+ (UIImage *)generateSnapshotWithView:(UIView *)view maxDataLength:(NSUInteger)length {
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0.0); // 不透明
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(currentContext, - CGRectGetMinX(view.frame), -CGRectGetMinY(view.frame));
    [view.layer renderInContext:currentContext];
    
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // 图片压缩
    return [self p_compressImage:snapshot maxDataLength:length];
}

/// 体积限制
+ (UIImage *)p_compressImage:(UIImage *)image maxDataLength:(NSUInteger)length {
    
    NSData *jpegData = UIImageJPEGRepresentation(image, 0.8);
    UIImage *newImage = image;
    
    
    if (jpegData.length > length) {
#if DEBUG
        NSLog(@"图片大小：%li, 图片尺寸：w-%g,h-%g", jpegData.length, image.size.width, image.size.height);
#endif
        jpegData = UIImageJPEGRepresentation(newImage, 0.5); // 压缩
        newImage = [UIImage imageWithData:jpegData];
        
    }
    
    
    return newImage;
}


@end
