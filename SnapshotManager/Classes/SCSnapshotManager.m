//
//  SCSnapshotManager.m
//  SCSnapshotDemo
//
//  Created by ShannonChen on 2017/3/19.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCSnapshotManager.h"
#import "SCSnapshotConst.h"


// Components
#import "SCSnapshotPostProvider.h"
#import "SCQRCodeGenerator.h"
#import "SCSnapshotImageDownloader.h"
#import "SCSnapshotGenerator.h"
#import <MBProgressHUD.h>

// View
#import "SCSnapshotWebView.h"

// Helper
#import "UIView+Layout.h"


@interface SCSnapshotManager ()


@property (strong, nonatomic) SCSnapshotWebView *webView;
@property (strong, nonatomic) id <SCSnapshotProviderProtocol> provider;

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
+ (void)shareSnapshotWithModel:(id)model completionHandler:(SCSnapshotCompletionHandler)completionHandler {
    
    SCSnapshotManager *manager = [[SCSnapshotManager alloc] init];
    
    // 1. 生成快照
    [manager generateSnapshotWithModel:model completionHandler:^(UIImage * _Nullable snapshot, NSError * _Nullable error) {
        
        if (error == nil && snapshot != nil) {
            
            SCSnapshotBlockCallback(completionHandler, snapshot, nil);
            // 2. 分享
//            [SCShareManager shareWithShareType:SSDKPlatformSubTypeWechatTimeline image:image text:nil success:^{
//                // MARK: 这里为什么不用 __weak？如果用 weak，block 不会持有 manager，manager 在这个函数执行完，manager 不被任何对象持有，所以马上就销毁了，等到 block 回调时，manager 为 nil。 （block 作为函数参数的情况）
//                if ([manager.provider respondsToSelector:@selector(snapshotManager:didFinishSharingSnapshot:)]) {
//                    [manager.provider snapshotManager:manager didFinishSharingSnapshot:YES];
//                }
//                
//                SCSnapshotBlockCallback(completionHandler, nil, image);
//                
//            } failture:^{
//                NSError *shareError = [NSError errorWithDomain:SCSnapshotErrorDomain
//                                                          code:SCSnapshotSharingFailedError
//                                                      userInfo:@{@"ShareType" : @"SSDKPlatformSubTypeWechatTimeline",
//                                                                 @"image" : image}];
//                SCSnapshotBlockCallback(completionHandler, shareError, image);
//                [SCCoreUtil showHUDMessageInWindow:kSnapshotShareFailureMessage];  // 提示分享照片失败
//                
//                [SCBugReporter reportError:shareError withType:SCBugReporterErrorTypeSnapshot];
//            } cancel:^{
//                // 取消则不作任何处理...
//            }];
            
        } else {
            SCSnapshotBlockCallback(completionHandler, nil, error);
        }
        
    }];
}


- (void)generateSnapshotWithModel:(id)model completionHandler:(SCSnapshotCompletionHandler)completionHandler {
    
    // 1. 创建 provider
    self.provider = [[SCSnapshotPostProvider alloc] init];
    
    // 2. 转换 content
    id <SCSnapshotModel> content = [self.provider snapshotContentWithModel:model];
    
    if (content == nil) {
        NSError *modelError = [NSError errorWithDomain:SCSnapshotErrorDomain
                                                  code:SCSnapshotContentEmptyError
                                              userInfo:nil];
        SCSnapshotBlockCallback(completionHandler, nil, modelError);

        return;
    }
    
    
    // 3. 加载 loading
    [MBProgressHUD showHUDAddedTo:UIApplicationKeyWindow animated:YES];
    
    // 5. 生成二维码
    content.qrCodeImage = [SCQRCodeGenerator generateQRCodeImageWithString:content.shareUrl size:CGSizeMake(POINT_FROM_PIXEL(220), POINT_FROM_PIXEL(220))];
    if (content.qrCodeImage == nil) {
        NSError *qrCodeImageError = [NSError errorWithDomain:SCSnapshotErrorDomain
                                                        code:SCSnapshotQRCodeGeneratingFailedError
                                                    userInfo:@{@"shareUrl" : content.shareUrl ? : @""}];
        
    }
    
    // 6. 下载图片
    SCSnapshotImageDownloader *imageDownloader = [[SCSnapshotImageDownloader alloc] init];
    [imageDownloader downloadWithImageURLArrays:[self.provider imageURLsForDownloadingWithContent:content]
                              completionHandler:^(NSArray<NSArray<UIImage *> *> * _Nullable imageArrays, BOOL success) {
                                  
                                  // 停止 loading
                                  [MBProgressHUD hideHUDForView:UIApplicationKeyWindow animated:YES];
                                  
                                  if (success == NO) {
                                      NSError *downloadError = [NSError errorWithDomain:SCSnapshotErrorDomain
                                                                                   code:SCSnapshotImageDownloadingFailedError
                                                                               userInfo:nil];
                                      SCSnapshotBlockCallback(completionHandler, nil, downloadError);
                                      
                                  } else {
                                      // 7. 创建 view、排版内容
                                      __kindof UIView * contentView = [self.provider snapshotViewWithDowloadedImages:imageArrays content:content];
                                      
                                      if (contentView) {
                                          // 8. 生成快照
                                          UIImage *snapshot = [SCSnapshotGenerator generateSnapshotWithView:contentView maxDataLength:kSnapshotImageDataLengthMax];
                                          
                                          // 9. 回调
                                          SCSnapshotBlockCallback(completionHandler, snapshot, nil);
                                          
                                      } else {
                                          NSError *viewError = [NSError errorWithDomain:SCSnapshotErrorDomain
                                                                                   code:SCSnapshotViewGeneratingFailedError
                                                                               userInfo:nil];
                                          SCSnapshotBlockCallback(completionHandler, nil, viewError);
                                      }
                                      
                                  }
                              }];
    
}


/// 根据 h5 的 url 生成快照
+ (void)generateSnapshotWithURLString:(NSString *)urlString completionHandler:(SCSnapshotCompletionHandler)completionHandler {
    SCSnapshotManager *snapshotManager = [SCSnapshotManager sharedManager];
    [snapshotManager generateSnapshotWithURLString:urlString completionHandler:completionHandler];
}


/// 根据 h5 的 url 生成快照
- (void)generateSnapshotWithURLString:(NSString *)urlString completionHandler:(SCSnapshotCompletionHandler)completionHandler {
    
    // 加载 loading
    [MBProgressHUD showHUDAddedTo:UIApplicationKeyWindow animated:YES];
    
    if (!urlString.length || ![urlString isKindOfClass:[NSString class]]) {
        SCSnapshotBlockCallback(completionHandler,
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
            SCSnapshotBlockCallback(completionHandler, nil, error);
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
            SCSnapshotBlockCallback(completionHandler, snapshot, nil);
            
        }
    };
    
}

@end
