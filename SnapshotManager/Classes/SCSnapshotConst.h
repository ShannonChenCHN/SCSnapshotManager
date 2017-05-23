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

#define POINT_FROM_PIXEL(__VALUE_IN_POINT__)    (__VALUE_IN_POINT__ / [UIScreen mainScreen].scale)

#define kSingleImageHWRatioMax                  2.0  // 单张图片的最大高宽比
#define kSnapshotWidth                          POINT_FROM_PIXEL(640.0)
#define kLeftRightPadding                       POINT_FROM_PIXEL(43)

#define kTitleViewHeight                        POINT_FROM_PIXEL(180)
#define kContentWidth                           POINT_FROM_PIXEL(552)
#define kQRCodeWH                               POINT_FROM_PIXEL(204)
#define kShareDescLabelWidth                    POINT_FROM_PIXEL(350)
#define ImageViewHeightFor(__IMGAE__)  (kContentWidth * __IMGAE__.size.height / (__IMGAE__.size.width > 0 ? __IMGAE__.size.width : 1)) // 防止出现除以 0 的情况
#define ImageViewLimitedHeightFor(__IMGAE__)    (ImageViewHeightFor(__IMGAE__) > kContentWidth * kSingleImageHWRatioMax ?\
                                                kContentWidth * kSingleImageHWRatioMax :\
                                                ImageViewHeightFor(__IMGAE__))  //  限制图片高宽比


static NSUInteger const kSnapshotImageDataLengthMax = 4 * 1024 * 1024; // 最大 4 M
static NSString * const kSnapshotFailureMessage = @"快照生成失败，请重新生成!";


static NSString * const kSnapshotPostShareDescDefault = @"长按识别二维码，加入时髦人士\n最爱的吃喝玩乐社区";
static NSString * const kSnapshotMerchantShareDescDefault = @"长按二维码，看更多人气好店";
static NSString * const kSnapshotShareUrlDefault = @"https://github.com/ShannonChenCHN";


// http://stackoverflow.com/questions/4654653/how-can-i-use-nserror-in-my-iphone-app
static NSString * const SCSnapshotErrorDomain = @"com.yhouse.snapshot.ErrorDomain";

typedef NS_ENUM(NSInteger, SCSnapshotErrorCode) {
    SCSnapshotContentEmptyError           = 100,
    SCSnapshotQRCodeGeneratingFailedError = 101,
    SCSnapshotImageDownloadingFailedError = 102,
    SCSnapshotViewGeneratingFailedError   = 103,
    SCSnapshotSharingFailedError          = 104,
};

#endif /* SCSnapshotConst_h */
