//
//  SCSnapshotPostProvider.m
//  SCSnapshotDemo
//
//  Created by ShannonChen on 17/5/18.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCSnapshotPostProvider.h"
#import "SCSnapshotPostContent.h"
#import "SCSnapshotModelTransformer.h"
#import "SCSnapshotPostContentView.h"

@implementation SCSnapshotPostProvider

#pragma mark - <SCSnapshotProviderProtocol>

// model 转换
- (id <SCSnapshotModel>)snapshotContentWithModel:(id)model {
    return [SCSnapshotModelTransformer transformModel:model];
}

// 完成分享
- (void)snapshotManager:(SCSnapshotManager *)manager didFinishSharingSnapshot:(BOOL)success {
    if (success) {
        
    }
    
}

// 要下载的图片的 URL
- (NSArray <NSArray <NSString *> *> *)imageURLsForDownloadingWithContent:(id<SCSnapshotModel>)content {
    SCSnapshotPostContent *model = (SCSnapshotPostContent *)content;
    return @[@[model.posterAvatarURLString], model.picUrls];
}

// 图片下载完成后创建 view
- (UIView *)snapshotViewWithDowloadedImages:(NSArray<NSArray<UIImage *> *> *)imageArrays content:(nonnull id<SCSnapshotModel>)content {
    
    SCSnapshotPostContent *model = (SCSnapshotPostContent *)content;
    
    if (imageArrays.count > 1 && imageArrays.firstObject.count > 0) {
        
        model.posterAvatarImage = imageArrays.firstObject.firstObject;
        model.downloadedImages = imageArrays[1];
        
        return [[SCSnapshotPostContentView alloc] initWithContent:content];
    } else {
        return nil;
    }
}


@end
