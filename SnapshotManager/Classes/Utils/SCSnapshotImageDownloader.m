//
//  SCSnapshotImageDownloader.m
//  SCSnapshotDemo
//
//  Created by ShannonChen on 2017/3/19.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCSnapshotImageDownloader.h"
#import "SCSnapshotConst.h"

#import "SCSnapshotPostContent.h"
#import <SDWebImageManager.h>

@interface SCSnapshotImageDownloader ()

@property (strong, nonatomic) NSMutableArray <NSMutableArray <UIImage *> *> *imageArrays;
@property (strong, nonatomic) NSMutableArray <id <SDWebImageOperation>> *operations; // 保存所有的下载操作，用于取消

@end

@implementation SCSnapshotImageDownloader

#pragma mark - Life cycle
- (void)dealloc {
    
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _imageArrays = [NSMutableArray array];
        _operations = [NSMutableArray array];
    }
    return self;
}

#pragma mark - Public methods
// 下载二维数组中的图片
- (void)downloadWithImageURLArrays:(NSArray<NSArray<NSString *> *> *)imageURLArrays completionHandler:(SCSnapshotImageDownloadCompletionHander)comletionHandler {
    
    if (imageURLArrays.count == 0) {
        SCSnapshotBlockCallback(comletionHandler, [self downloadedImages], NO);
    }
    
    [self resetImageArraysWithURLArrays:imageURLArrays];
    [self.operations removeAllObjects];
    
    [imageURLArrays enumerateObjectsUsingBlock:^(NSArray<NSString *> * _Nonnull urlStrings, NSUInteger idx, BOOL * _Nonnull stop) {
        [self downloadImagesWithPhotoURLStrings:urlStrings inSection:idx completionHandler:comletionHandler];
    }];
    
}

// 下载一维数组中的图片
- (void)downloadImagesWithPhotoURLStrings:(NSArray <NSString *> *)urlStrings inSection:(NSInteger)section completionHandler:(SCSnapshotImageDownloadCompletionHander)comletionHandler {
    
    
    // 下载大图
    [urlStrings enumerateObjectsUsingBlock:^(id  _Nonnull urlString, NSUInteger idx, BOOL * _Nonnull stop) {
        
        id <SDWebImageOperation> operation =
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:urlString]
                                                        options:SDWebImageHighPriority
                                                       progress:NULL
                                                      completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                          
                                                          dispatch_main_sync_safe(^{
                                                              if (idx >= 0 && idx < self.operations.count) { // 每下载完成一个，就移除一个
                                                                  [self.operations removeObjectAtIndex:idx];
                                                              }
                                                              
                                                              if (image) {
                                                                  
                                                                  [self updateImage:image atIndexPath:[NSIndexPath indexPathForRow:idx inSection:section]]; // 保存图片
                                                                  
                                                                  if ([self hasFinishedAllDownloadTask]) { // 所有图片下载结束
                                                                      SCSnapshotBlockCallback(comletionHandler, [self downloadedImages], YES);
                                                                  }
                                                              }
                                                              else {
                                                                  
                                                                  [self.operations makeObjectsPerformSelector:@selector(cancel)]; // 取消并移除剩余的 operation
                                                                  [self.operations removeAllObjects];
                                                                  
                                                                  SCSnapshotBlockCallback(comletionHandler, nil, NO);
                                                                  
                                                                  *stop = YES;
                                                              }
                                                          });
                                                          
                                                      }];
        
        if (operation) { // 理论上这里是不会为 nil，但还是加上非空保护，防止意外崩溃
            [self.operations addObject:operation];
        }
        
        
    }];
}


#pragma mark - Image array process
/// 重置图片数组
- (void)resetImageArraysWithURLArrays:(NSArray *)URLArrays {
    [self.imageArrays removeAllObjects];
    
    
    for (NSArray <NSString *> *URLStrings in URLArrays) {
        
        NSMutableArray *subImageArray = [NSMutableArray array];
        
        // Filling NSMutableArray for later use in obj-c
        // http://stackoverflow.com/questions/13224779/filling-nsmutablearray-for-later-use-in-obj-c
        for (NSString *anURLString in URLStrings) {
            [subImageArray addObject:[NSNull null]];
        }
        
        [self.imageArrays addObject:subImageArray];
    }
    
}

/// 插入下载好的图片
- (void)updateImage:(nonnull UIImage *)image atIndexPath:(NSIndexPath *)indexPath {
    
    if (image && indexPath.section < self.imageArrays.count) {
        
        NSMutableArray *subImageArray = self.imageArrays[indexPath.section];
        
        if (indexPath.row < subImageArray.count) {
            [subImageArray replaceObjectAtIndex:indexPath.row withObject:image];
        }
    }
}

/// 所有下载好的图片
- (NSArray <NSArray <UIImage *> *> *)downloadedImages {
    // TODO: return deep copied immutable array？
    return [self hasFinishedAllDownloadTask] ? self.imageArrays : [NSArray array];
}

/// 是否已经全部下载好
- (BOOL)hasFinishedAllDownloadTask {
    
    BOOL containsNull = NO;
    for (NSMutableArray <UIImage *> *subImageArray in self.imageArrays) {
        
        if ([subImageArray containsObject:[NSNull null]]) { // 只要有一个子数组包含 NSNull，就说明没下载完
            containsNull = YES;
            break;
        } else {
            containsNull = NO;
        }
    }
    
    return (containsNull == NO);
}
@end
