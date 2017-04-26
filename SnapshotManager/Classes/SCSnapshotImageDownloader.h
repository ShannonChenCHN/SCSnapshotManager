//
//  SCSnapshotImageDownloader.h
//  SCSnapshotDemo
//
//  Created by ShannonChen on 2017/3/19.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCSnapshotContent;

NS_ASSUME_NONNULL_BEGIN


/**
 图片下载完全后回调
 
 @param avatar 成功则返回图片，失败则返回 nil
 @param photos 成功则返回图片数组，失败则返回 nil
 @param success 成功则返回 YES
 */
typedef void(^SCSnapshotImageDownloadCompletionHander)(UIImage * _Nullable avatar, NSArray <UIImage *>  * _Nullable photos, BOOL success);


/**
 在生成快照前负责下载好所有图片
 */
@interface SCSnapshotImageDownloader : NSObject

/// 这里是按照头像 url 和大图都是必须有的情况处理
- (void)downloadWithAvatarURLString:(NSString *)urlString photoURLStrings:(NSArray <NSString *> *)urlStrings completionHandler:(SCSnapshotImageDownloadCompletionHander)comletionHandler;


@end


NS_ASSUME_NONNULL_END
