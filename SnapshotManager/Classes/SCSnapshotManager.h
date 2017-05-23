//
//  SCSnapshotManager.h
//  SCSnapshotDemo
//
//  Created by ShannonChen on 2017/3/19.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCSnapshotModel.h"
@class SCSnapshotManager;

NS_ASSUME_NONNULL_BEGIN


/**
 生成长图文快照的回调

 @param snapshot 图文快照，失败则返回 nil
 @param error    失败则返回错误，成功则返回 nil
 */
typedef void(^SCSnapshotCompletionHandler)(UIImage * _Nullable snapshot, NSError * _Nullable error);


/**
 这个协议用于针对不同的快照类型进行自定义配置
 */
@protocol SCSnapshotProviderProtocol <NSObject>

@required

/// 校验 model，并将传进来的 model 统一转换成 遵循 SCSnapshotModel 协议的 model
- (nullable id <SCSnapshotModel>)snapshotContentWithModel:(id)model;

/// 要下载的图片 URL，是一个二维数组
- (NSArray <NSArray <NSString *> *> *)imageURLsForDownloadingWithContent:(id <SCSnapshotModel>)content;

/// 图片下载完成后，获取生成的 view
- (nullable __kindof UIView *)snapshotViewWithDowloadedImages:(NSArray <NSArray <UIImage *> *> *)imageArrays content:(id <SCSnapshotModel>)content;


@optional

/// 完成分享快照
- (void)snapshotManager:(SCSnapshotManager *)manager didFinishSharingSnapshot:(BOOL)success;

@end


/**
 根据 Model 数据生成长图文快照
 */
@interface SCSnapshotManager : NSObject


/// 生成并分享快照
+ (void)shareSnapshotWithModel:(id)model completionHandler:(nullable SCSnapshotCompletionHandler)completionHandler;

/// 根据 h5 的 url 生成快照
+ (void)generateSnapshotWithURLString:(NSString *)urlString completionHandler:(nullable SCSnapshotCompletionHandler)completionHander;

@end

NS_ASSUME_NONNULL_END
