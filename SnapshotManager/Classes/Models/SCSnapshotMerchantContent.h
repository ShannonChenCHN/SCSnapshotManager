//
//  SCSnapshotMerchantContent.h
//  SCSnapshotDemo
//
//  Created by ShannonChen on 2017/5/22.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCSnapshotModel.h"



NS_ASSUME_NONNULL_BEGIN

/**
 生成商户快照的数据模型
 */
@interface SCSnapshotMerchantContent : NSObject <SCSnapshotModel>

+ (instancetype)defaultContent;

@end

NS_ASSUME_NONNULL_END
