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

- (id <SCSnapshotModel>)snapshotContentWithModel:(id)model {
    return [SCSnapshotModelTransformer transformModel:model];
}

- (void)snapshotManager:(SCSnapshotManager *)manager didFinishSharingSnapshot:(BOOL)success {
    if (success) {
        
    }
    
}

- (NSArray <NSArray <NSString *> *> *)imageURLsForDownloadingWithContent:(id<SCSnapshotModel>)content {
    SCSnapshotPostContent *model = (SCSnapshotPostContent *)content;
    return @[@[model.posterAvatarURLString], model.picUrls];
}

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

/// 埋点
- (void)trackEventWithContent:(id<SCSnapshotModel>)content behavior:(NSString *)behavior {
    SCSnapshotPostContent *model = (SCSnapshotPostContent *)content;
    

}

@end
