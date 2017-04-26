//
//  SCQRCodeGenerator.m
//  SCSnapshotDemo
//
//  Created by ShannonChen on 2017/3/19.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCQRCodeGenerator.h"

#import "UIImage+SCExtension.h"

@implementation SCQRCodeGenerator


+ (UIImage *)generateQRCodeImageWithString:(NSString *)string size:(CGSize)size {
    NSAssert(string.length, @"String cannot be empty!");
    
    // 创建滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
#if DEBUG
    NSLog(@"%@", filter.inputKeys);
    /**
     (
     inputMessage,
     inputCorrectionLevel
     )
     */
#endif
    
    [filter setDefaults];
    
    // 将字符串转成 NSData 二进制数据
    NSData *shareURLData = [string dataUsingEncoding:NSISOLatin1StringEncoding];
    [filter setValue:shareURLData forKeyPath:@"InputMessage"];
    
    
    CIImage *qrCodeImage = filter.outputImage;
    
    // 图片放大
    return [UIImage sc_imageWithCIImage:qrCodeImage size:size];
}


@end
