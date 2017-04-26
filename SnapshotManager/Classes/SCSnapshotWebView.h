//
//  SCSnapshotWebView.h
//  SCSnapshotDemo
//
//  Created by ShannonChen on 17/4/26.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SCSnapshotWebViewCompletionHandler)(NSError *error);


/**
 生成快照的 webView
 */
@interface SCSnapshotWebView : UIWebView
// TODO: 换成性能更好的 WKWebView？

@property (copy, nonatomic, nonnull) SCSnapshotWebViewCompletionHandler completionHandler;

@end

NS_ASSUME_NONNULL_END
