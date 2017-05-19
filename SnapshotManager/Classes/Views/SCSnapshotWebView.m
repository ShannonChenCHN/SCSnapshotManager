//
//  SCSnapshotWebView.m
//  SCSnapshotDemo
//
//  Created by ShannonChen on 17/4/26.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCSnapshotWebView.h"

@interface SCSnapshotWebView () <UIWebViewDelegate>

@property (assign, nonatomic) BOOL needsReload;

@end

@implementation SCSnapshotWebView

- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.delegate = self;
    _needsReload = YES;
}

- (void)loadRequest:(NSURLRequest *)request {
    [super loadRequest:request];
    
    self.needsReload = YES;
}

#pragma mark - <UIWebViewDelegate>
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    if (self.needsReload) {
        [self reload];  // 重新加载一次，防止页面加载不完全
        self.needsReload = NO;
        return;
    }
    
    [self p_invokeCompletionHandlerWithError:nil];
}

// TODO: 链接接不对时，但是该方法没有被调用
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self p_invokeCompletionHandlerWithError:error];
}


#pragma mark - Private Methods
- (void)p_invokeCompletionHandlerWithError:(NSError *)error {
    
    if (self.completionHandler) {
        self.completionHandler(error);
    }
    
}

@end
