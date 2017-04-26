//
//  SCSnapshotGenerator.h
//  SCSnapshotDemo
//
//  Created by ShannonChen on 2017/3/19.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 快照生成工具，负责“截图”和压缩
 */
@interface SCSnapshotGenerator : NSObject

/// 生成内容图片
+ (UIImage *)generateSnapshotWithView:(UIView *)view maxDataLength:(NSUInteger)length;


@end

NS_ASSUME_NONNULL_END
