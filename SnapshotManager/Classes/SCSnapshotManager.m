//
//  SCSnapshotManager.m
//  SCSnapshotDemo
//
//  Created by ShannonChen on 2017/3/19.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCSnapshotManager.h"

#import "SCSnapshotWebView.h"

// Model
#import "SCSnapshotContent.h"

// Components
#import "SCQRCodeGenerator.h"
#import "SCSnapshotImageDownloader.h"
#import "SCSnapshotContentView.h"
#import "SCSnapshotGenerator.h"

#import <MBProgressHUD.h>

#import "UIView+Layout.h"

#define UIApplicationKeyWindow   [UIApplication sharedApplication].keyWindow

#ifndef SCSnapshotBlockCallback
#define SCSnapshotBlockCallback(__BLOCK_NAME__, ...)   \
if (__BLOCK_NAME__) {\
__BLOCK_NAME__(__VA_ARGS__);\
}
#endif


static NSUInteger const kSnapshotImageDataLengthMax = 4 * 1024 * 1024; // 最大 4 M
static NSString * const kSnapshotFailureMessage = @"快照生成失败，请重新生成!";


@interface SCSnapshotManager ()

@property (strong, nonatomic) SCSnapshotContent *content;
@property (strong, nonatomic) SCSnapshotWebView *webView; 

@end

@implementation SCSnapshotManager


- (void)dealloc {
    
}

+ (instancetype)sharedManager {
    static id sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[SCSnapshotManager alloc] init];
    });
    return sharedManager;
}

#pragma mark - Main Logic

// 根据 content 生成快照
+ (void)generateSnapshotWithContent:(SCSnapshotContent *)content completionHander:(nullable SCSnapshotCompletionHander)completionHander{
    SCSnapshotManager *snapshotManager = [SCSnapshotManager sharedManager];
    [snapshotManager generateSnapshotWithContent:content completionHander:completionHander];
}

/// 根据 h5 的 url 生成快照
- (void)generateSnapshotWithContent:(SCSnapshotContent *)content completionHander:(nullable SCSnapshotCompletionHander)completionHander {
    self.content = content;
    
    
    // 加载 loading
    [MBProgressHUD showHUDAddedTo:UIApplicationKeyWindow animated:YES];
    
    if (!content.shareUrl || ![content.shareUrl isKindOfClass:[NSString class]]) {
        SCSnapshotBlockCallback(completionHander,
                                nil,
                                [NSError errorWithDomain:@"com.scsnapshot.shareurl.error" code:103 userInfo:nil]);
        return;
    }
    
    
    
    // 生成二维码
    self.content.qrCodeImage = [SCQRCodeGenerator generateQRCodeImageWithString:self.content.shareUrl size:CGSizeMake(POINT_FROM_PIXEL(220), POINT_FROM_PIXEL(220))];
    
    // 2. 下载图片
    SCSnapshotImageDownloader *imageDownloader = [[SCSnapshotImageDownloader alloc] init];
    [imageDownloader downloadWithAvatarURLString:self.content.posterAvatarURLString
                                 photoURLStrings:self.content.picUrls
                               completionHandler:^(UIImage * _Nullable avatar, NSArray<UIImage *> * _Nullable photos, BOOL success) {
                                   
                                   // 停止 loading 动画
                                   [MBProgressHUD hideHUDForView:UIApplicationKeyWindow animated:YES];
                                   
                                   if (!success) {
                                       SCSnapshotBlockCallback(completionHander, nil, [NSError errorWithDomain:@"com.scsnapshot.download.error" code:100 userInfo:nil]);
                                   } else {
                                       self.content.posterAvatarImage = avatar;
                                       self.content.downloadedImages = photos;
                                       
                                       // 创建 view、排版内容
                                       SCSnapshotContentView *contentView = [[SCSnapshotContentView alloc] initWithContent:self.content];
                                       
                                       // 生成图片
                                       UIImage *snapshot = [SCSnapshotGenerator generateSnapshotWithView:contentView maxDataLength:kSnapshotImageDataLengthMax];
                                       
                                       // 回调
                                       SCSnapshotBlockCallback(completionHander, snapshot, nil);
                                       
                                   }
                               }];

}

/// 根据 h5 的 url 生成快照
+ (void)generateSnapshotWithURLString:(NSString *)urlString completionHander:(SCSnapshotCompletionHander)completionHander {
    SCSnapshotManager *snapshotManager = [SCSnapshotManager sharedManager];
    [snapshotManager generateSnapshotWithURLString:urlString completionHander:completionHander];
}


/// 根据 h5 的 url 生成快照
- (void)generateSnapshotWithURLString:(NSString *)urlString completionHander:(SCSnapshotCompletionHander)completionHander {
    
    // 加载 loading
    [MBProgressHUD showHUDAddedTo:UIApplicationKeyWindow animated:YES];
    
    if (!urlString.length || ![urlString isKindOfClass:[NSString class]]) {
        SCSnapshotBlockCallback(completionHander,
                                nil,
                                [NSError errorWithDomain:@"com.scsnapshot.url.error" code:101 userInfo:nil]);
        return;
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    self.webView = [[SCSnapshotWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    
    [UIApplicationKeyWindow addSubview:self.webView]; // 必须要把 webView 添加到一个 superview 上，否则加载完成时，拿不到正确的 contentSize；当然，也许有更好的方式
    self.webView.hidden = YES;
    
    __weak typeof(self) weakSelf = self;
    self.webView.completionHandler = ^void(NSError *error) {
        
        // 停止 loading 动画
        [MBProgressHUD hideHUDForView:UIApplicationKeyWindow animated:YES];
        
        if (error) {
            SCSnapshotBlockCallback(completionHander, nil, error);
        } else {
            
            // 更新尺寸
            weakSelf.webView.size = weakSelf.webView.scrollView.contentSize;
            
            // 生成图片
            [weakSelf.webView removeFromSuperview];
            weakSelf.webView.hidden = NO;  // 生成图片前还是需要显示 webView 的
            UIImage *snapshot = [SCSnapshotGenerator generateSnapshotWithView:weakSelf.webView maxDataLength:kSnapshotImageDataLengthMax];
            
            // 销毁 webView，节省内存开销
            weakSelf.webView = nil;
            
            // 回调
            SCSnapshotBlockCallback(completionHander, snapshot, nil);
            
        }
    };
    
}

@end
