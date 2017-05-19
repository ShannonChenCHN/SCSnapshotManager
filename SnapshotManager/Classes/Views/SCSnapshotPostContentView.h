//
//  SCSnapshotPostContentView.h
//  SCSnapshotDemo
//
//  Created by ShannonChen on 2017/3/19.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SCSnapshotPostContent;

#define POINT_FROM_PIXEL(__VALUE_IN_POINT__)    (__VALUE_IN_POINT__ / [UIScreen mainScreen].scale)



NS_ASSUME_NONNULL_BEGIN

/**
 生成快照的 view
 */
@interface SCSnapshotPostContentView : UIView


@property (strong, nonatomic) SCSnapshotPostContent *content; ///< 要生成快照的内容


/**
 根据内容，创建一个新的 SCSnapshotPostContentView 对象
 
 @param content 要生成快照的内容
 @return 一个新的 SCSnapshotPostContentView 对象
 */
- (instancetype)initWithContent:(SCSnapshotPostContent *)content;




@end

NS_ASSUME_NONNULL_END
