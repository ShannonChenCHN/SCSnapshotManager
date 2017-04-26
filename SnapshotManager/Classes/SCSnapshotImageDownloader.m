//
//  SCSnapshotImageDownloader.m
//  SCSnapshotDemo
//
//  Created by ShannonChen on 2017/3/19.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCSnapshotImageDownloader.h"


#import "SCSnapshotContent.h"
#import <SDWebImageDownloader.h>

@interface SCSnapshotImageDownloader ()

@property (strong, nonatomic) UIImage *avatar;
@property (strong, nonatomic) NSMutableArray *images;

@end

@implementation SCSnapshotImageDownloader

#pragma mark - Life cycle
- (void)dealloc {
    
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _images = [NSMutableArray array];
    }
    return self;
}

#pragma mark - Public methods
- (void)downloadWithAvatarURLString:(NSString *)urlString photoURLStrings:(NSArray<NSString *> *)urlStrings completionHandler:(SCSnapshotImageDownloadCompletionHander)comletionHandler {
    
    [self resetImageArrayWithCapacity:urlStrings.count];
    
    // 下载头像
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:urlString] options:SDWebImageDownloaderLowPriority progress:NULL completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        
        dispatch_main_sync_safe(^{
            if (image) {
                self.avatar = image; // 保存图片
                
                if ([self hasFinishedAllDownloadTask]) { // 所有图片下载结束
                    if (comletionHandler) {
                        comletionHandler(self.avatar, [self downloadedImages], YES);
                    }
                }
            }
            else {
                if (comletionHandler) {
                    comletionHandler(nil, nil, NO);
                }
                
            }
        });
        
    }];
    
    // 下载大图
    [urlStrings enumerateObjectsUsingBlock:^(id  _Nonnull urlString, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:urlString] options:SDWebImageDownloaderLowPriority progress:NULL completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            
            dispatch_main_sync_safe(^{
                if (image) {
                    [self updateImage:image atIndex:idx]; // 保存图片
                    
                    if ([self hasFinishedAllDownloadTask]) { // 所有图片下载结束
                        if (comletionHandler) {
                            comletionHandler(self.avatar, [self downloadedImages], YES);
                        }
                    }
                }
                else {
                    *stop = YES;
                    if (comletionHandler) {
                        comletionHandler(nil, nil, NO);
                    }
                    
                }
            });
            
        }];
        
    }];
}


#pragma mark - Image array process
/// 重置图片数组
- (void)resetImageArrayWithCapacity:(NSUInteger)capacity {
    [_images removeAllObjects];
    
    // Filling NSMutableArray for later use in obj-c
    // http://stackoverflow.com/questions/13224779/filling-nsmutablearray-for-later-use-in-obj-c
    for (NSInteger i = 0; i < capacity; i++) {
        [_images addObject:[NSNull null]];
    }
}

/// 插入下载好的图片
- (void)updateImage:(nonnull UIImage *)image atIndex:(NSInteger)index {
    if (image) {
        [_images replaceObjectAtIndex:index withObject:image];
    }
}

/// 所有下载好的图片
- (NSArray <UIImage *> *)downloadedImages {
    if (![_images containsObject:[NSNull null]]) {
        return _images;
    } else {
        return [NSArray array];
    }
}

/// 是否已经全部下载好
- (BOOL)hasFinishedAllDownloadTask {
    return ![_images containsObject:[NSNull null]] && self.avatar;
}

@end
