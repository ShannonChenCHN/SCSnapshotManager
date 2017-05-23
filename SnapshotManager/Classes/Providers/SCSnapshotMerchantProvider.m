//
//  SCSnapshotMerchantProvider.m
//  SCSnapshotDemo
//
//  Created by ShannonChen on 2017/5/23.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCSnapshotMerchantProvider.h"

#import "SCSnapshotMerchantContent.h"
#import "SCSnapshotModelTransformer.h"

#import "SCSnapshotMerchantContentView.h"

@implementation SCSnapshotMerchantProvider



- (void)dealloc {
    
}

#pragma mark - <SCSnapshotProviderProtocol>

- (id <SCSnapshotModel>)snapshotContentWithModel:(id)model {
    return [SCSnapshotModelTransformer transformModel:model];
}

- (NSArray <NSArray <NSString *> *> *)imageURLsForDownloadingWithContent:(id<SCSnapshotModel>)content {
    
    SCSnapshotMerchantContent *model = (SCSnapshotMerchantContent *)content;
    
    NSMutableArray <NSArray <NSString *> *> *imageURLsForDownloading = [NSMutableArray array];
    
    NSMutableArray *recommendationImageURLs = [NSMutableArray array];
    
    for (SCSnapshotMerchantDetailItem *aDetailItem in model.recommendationDetails) {
        
        if ([aDetailItem.imageURL isKindOfClass:[NSString class]] &&
            aDetailItem.imageURL.length != 0) {
            
            [recommendationImageURLs addObject:aDetailItem.imageURL];
        }
    }
    
    if (recommendationImageURLs.count) {
        [imageURLsForDownloading addObject:recommendationImageURLs];
    }
    
    
    return imageURLsForDownloading;
}

- (UIView *)snapshotViewWithDowloadedImages:(NSArray<NSArray<UIImage *> *> *)imageArrays content:(nonnull id<SCSnapshotModel>)content {
    
    SCSnapshotMerchantContent *model = (SCSnapshotMerchantContent *)content;
    
    if (imageArrays.count > 0) { // 有图片
        
        // 将 recommendationDetails 中 image 一个一个“填满”
        __block NSInteger indexForImageArray = 0;
        [model.recommendationDetails enumerateObjectsUsingBlock:^(SCSnapshotMerchantDetailItem * aDetailItem, NSUInteger idx, BOOL *stop) {
            if (aDetailItem.contentType == SCSnapshotMerchantDetailItemTypeImage &&  // 如果是图片
                imageArrays.firstObject.count > indexForImageArray) { // 取亮点详情的图片
                aDetailItem.downloadedImage = imageArrays.firstObject[indexForImageArray];  // 取对应位置的图片
                indexForImageArray++;
                
            }
            
        }];
        
        
        return [[SCSnapshotMerchantContentView alloc] initWithContent:model];
        
    } else {
        
        return nil;
    }
    
}


@end
