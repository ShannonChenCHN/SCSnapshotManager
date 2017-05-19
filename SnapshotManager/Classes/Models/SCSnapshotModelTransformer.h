//
//  SCSnapshotModelTransformer.h
//  SCSnapshotDemo
//
//  Created by ShannonChen on 17/5/18.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCSnapshotModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SCSnapshotModelTransformer : NSObject

/// 校验 model，并将 model 统一转换成 <YHSnapshotModel> 协议的 model
+ (nullable id <SCSnapshotModel>)transformModel:(id)model;

@end

NS_ASSUME_NONNULL_END
