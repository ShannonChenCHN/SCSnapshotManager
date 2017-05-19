//
//  SCSnapshotImageDownloader.h
//  SCSnapshotDemo
//
//  Created by ShannonChen on 2017/3/19.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCSnapshotPostContent;

NS_ASSUME_NONNULL_BEGIN




/**
 图片下载完全后回调

 @param imageArrays 成功则返回图片数组，失败则返回 nil
 @param success 下载成功的标志
 */
typedef void(^SCSnapshotImageDownloadCompletionHander)(NSArray <NSArray <UIImage *> *> * _Nullable imageArrays, BOOL success);


/**
 在生成快照前负责下载好所有图片
 */
@interface SCSnapshotImageDownloader : NSObject


/**
 下载图片
 
 @param imageURLArrays   要下载的图片 url，二维数组
 @param comletionHandler 图片下载完成后的回调
 */
- (void)downloadWithImageURLArrays:(NSArray <NSArray <NSString *> *> *)imageURLArrays completionHandler:(SCSnapshotImageDownloadCompletionHander)comletionHandler;


@end


NS_ASSUME_NONNULL_END
