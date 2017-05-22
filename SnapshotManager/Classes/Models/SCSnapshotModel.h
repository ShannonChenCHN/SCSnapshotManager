//
//  SCSnapshotModel.h
//  SCSnapshotDemo
//
//  Created by ShannonChen on 17/5/18.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SCSnapshotModelType) {
    SCSnapshotModelTypePost,
    SCSnapshotModelTypeMerchant,
};

@protocol SCSnapshotModel <NSObject>

@property (nonatomic, copy, nullable) NSString *shareUrl;   ///< 生成二维码的图文链接
@property (nonatomic, strong, nullable) UIImage *qrCodeImage;

@end


NS_ASSUME_NONNULL_END
