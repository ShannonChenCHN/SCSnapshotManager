//
//  SCSnapshotModelTransformer.m
//  SCSnapshotDemo
//
//  Created by ShannonChen on 17/5/18.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCSnapshotModelTransformer.h"

#import "SCSnapshotPostContent.h"
#import "SCSnapshotMerchantContent.h"

@implementation SCSnapshotModelTransformer

+ (id<SCSnapshotModel>)transformModel:(id)model {
    
    if ([model isKindOfClass:[NSDictionary class]]) {
        
        if ([model[@"type"] integerValue] == SCSnapshotModelTypePost) {
            
            return [SCSnapshotPostContent defaultContent];
            
        } else if ([model[@"type"] integerValue] == SCSnapshotModelTypeMerchant) {
            
            return [SCSnapshotMerchantContent defaultContent];
            
        }
        
    } else if ([model isKindOfClass:[SCSnapshotPostContent class]] ||
              [model isKindOfClass:[SCSnapshotMerchantContent class]]) {
        return model;
    }
    
    return nil;
}

@end
