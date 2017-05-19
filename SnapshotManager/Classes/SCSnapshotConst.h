//
//  SCSnapshotConst.h
//  SCSnapshotDemo
//
//  Created by ShannonChen on 17/5/18.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#ifndef SCSnapshotConst_h
#define SCSnapshotConst_h

#define UIApplicationKeyWindow   [UIApplication sharedApplication].keyWindow

#ifndef SCSnapshotBlockCallback
#define SCSnapshotBlockCallback(__BLOCK_NAME__, ...)   \
    if (__BLOCK_NAME__) {\
        __BLOCK_NAME__(__VA_ARGS__);\
    }
#endif


static NSUInteger const kSnapshotImageDataLengthMax = 4 * 1024 * 1024; // 最大 4 M
static NSString * const kSnapshotFailureMessage = @"快照生成失败，请重新生成!";

#endif /* SCSnapshotConst_h */
