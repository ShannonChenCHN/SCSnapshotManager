//
//  SCSnapshotMerchantContent.h
//  SCSnapshotDemo
//
//  Created by ShannonChen on 2017/5/22.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCSnapshotModel.h"

@class SCSnapshotMerchantDetailItem;

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, SCSnapshotMerchantDetailItemType) {
    SCSnapshotMerchantDetailItemTypeText  = 0,
    SCSnapshotMerchantDetailItemTypeImage = 1,
};


/**
 生成商户快照的数据模型
 */
@interface SCSnapshotMerchantContent : NSObject <SCSnapshotModel>

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *hostName;
@property (copy, nonatomic) NSString *sales;
@property (strong, nonatomic) NSArray <SCSnapshotMerchantDetailItem *> *recommendationDetails;

@property (copy, nonatomic) NSString *shareDescription;

+ (instancetype)defaultContent;

@end




/**
 商户快照中的图文详情
 */
@interface SCSnapshotMerchantDetailItem : NSObject

@property (assign, nonatomic) SCSnapshotMerchantDetailItemType contentType;
@property (strong, nonatomic, nullable) NSString *text;
@property (strong, nonatomic, nullable) NSString *imageURL;
@property (strong, nonatomic, nullable) UIImage *downloadedImage;

@end


NS_ASSUME_NONNULL_END
