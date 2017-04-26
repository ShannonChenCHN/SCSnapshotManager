//
//  SCSnapshotManager.h
//  SCSnapshotDemo
//
//  Created by ShannonChen on 2017/3/19.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SCSnapshotContent;

NS_ASSUME_NONNULL_BEGIN


/**
 生成长图文快照的回调

 @param snapshot 图文快照，失败则返回 nil
 @param error    失败则返回错误，成功则返回 nil
 */
typedef void(^SCSnapshotCompletionHander)(UIImage * _Nullable snapshot, NSError * _Nullable error);


/**
 长图文分享，根据帖子内容生成长图文
 */
@interface SCSnapshotManager : NSObject

/// 根据 content 生成快照
+ (void)generateSnapshotWithContent:(SCSnapshotContent *)content completionHander:(nullable SCSnapshotCompletionHander)completionHander;

/// 根据 h5 的 url 生成快照
+ (void)generateSnapshotWithURLString:(NSString *)urlString completionHander:(nullable SCSnapshotCompletionHander)completionHander;

@end

NS_ASSUME_NONNULL_END
