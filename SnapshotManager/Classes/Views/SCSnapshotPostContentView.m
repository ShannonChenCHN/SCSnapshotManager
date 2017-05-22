//
//  SCSnapshotPostContentView.m
//  SCSnapshotDemo
//
//  Created by ShannonChen on 2017/3/19.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCSnapshotPostContentView.h"
#import "SCSnapshotConst.h"

#import "SCSnapshotPostContent.h"

#import "UIView+Layout.h"
#import "UIColor+SCExtension.h"
#import "NSString+SCExtension.h"

#define kAvatarWH                               POINT_FROM_PIXEL(90)

/**
 图文按钮（上图下文）
 */
@interface SCImageTitleButton : UIButton

@property (assign, nonatomic) CGFloat interTitleImageSpacing; ///< 图文间距，默认为 4
@property (assign, nonatomic) CGFloat roundImageRadius;       ///< 圆形图片半径，默认为 0，当需要将图片裁剪为圆形时设置该属性

@end

@implementation SCImageTitleButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _interTitleImageSpacing = 4;
        _roundImageRadius = 0;
    }
    return self;
}

- (void)setRoundImageRadius:(CGFloat)roundImageRadius {
    _roundImageRadius = roundImageRadius;
    
    [self layoutIfNeeded];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 圆角
    if (self.roundImageRadius) {
        self.imageView.width = self.roundImageRadius * 2;
        self.imageView.height = self.imageView.width;
        self.imageView.layer.cornerRadius = self.roundImageRadius;
        self.imageView.layer.masksToBounds = YES;
    }
    
    self.imageView.y = 0;
    self.imageView.centerX = self.width / 2.0;
    
    self.titleLabel.y = self.imageView.bottom + self.interTitleImageSpacing;
    self.titleLabel.centerX = self.imageView.centerX;
}

@end

@interface SCSnapshotPostContentView ()

@end

@implementation SCSnapshotPostContentView

- (instancetype)initWithContent:(SCSnapshotPostContent *)content {
    self = [super initWithFrame:CGRectMake(0, 0, kSnapshotWidth, 0)];
    if (self) {
        
        _content = content;
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self p_addSubviews];
    }
    return self;
}

/// 创建、排版 views
- (void)p_addSubviews {
    
    
    // 头像、昵称
    SCImageTitleButton *userInfoButton = [[SCImageTitleButton alloc] initWithFrame:CGRectMake(kLeftRightPadding,
                                                                                              POINT_FROM_PIXEL(100),
                                                                                              kContentWidth,
                                                                                              POINT_FROM_PIXEL(134))];
    userInfoButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    userInfoButton.roundImageRadius = kAvatarWH * 0.5;
    [userInfoButton setImage:self.content.posterAvatarImage forState:UIControlStateNormal];
    [userInfoButton setTitle:self.content.posterName forState:UIControlStateNormal];
    userInfoButton.titleLabel.font = [UIFont boldSystemFontOfSize:POINT_FROM_PIXEL(24)];
    userInfoButton.titleLabel.numberOfLines = 1;
    [userInfoButton setTitleColor:UIColorHex(0x111111) forState:UIControlStateNormal];
    userInfoButton.interTitleImageSpacing = POINT_FROM_PIXEL(17);
    [self addSubview:userInfoButton];
    
    // 身份标签
    UILabel *tagLabel = nil;
    if (self.content.userTagDescription) {
        tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLeftRightPadding, userInfoButton.bottom + POINT_FROM_PIXEL(11), kContentWidth, POINT_FROM_PIXEL(23))];
        tagLabel.numberOfLines = 1;
        tagLabel.font = [UIFont systemFontOfSize:POINT_FROM_PIXEL(20)];
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.textColor = UIColorHex(0x555555);
        tagLabel.text = self.content.userTagDescription;
        [self addSubview:tagLabel];
    }
    
    
    // 文本
    CGFloat textLabelY = tagLabel ? tagLabel.bottom + POINT_FROM_PIXEL(45) : userInfoButton.bottom + POINT_FROM_PIXEL(45);
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLeftRightPadding,
                                                                   textLabelY,
                                                                   kContentWidth,
                                                                   POINT_FROM_PIXEL(32))];
    textLabel.numberOfLines = 0;
    textLabel.font = [UIFont systemFontOfSize:POINT_FROM_PIXEL(24)];
    textLabel.textColor = UIColorHex(0x111111);
    textLabel.text = self.content.textContent;
    [self addSubview:textLabel];
    
    textLabel.height = [textLabel.text sc_heightForFont:textLabel.font width:kContentWidth];
    
    
    // 图片
    __block UIImageView *lastImageView = nil;
    [self.content.downloadedImages enumerateObjectsUsingBlock:^(UIImage * _Nonnull anImage, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat originY = lastImageView ? lastImageView.bottom + POINT_FROM_PIXEL(43) : textLabel.bottom + POINT_FROM_PIXEL(51);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kLeftRightPadding,
                                                                               originY,
                                                                               kContentWidth,
                                                                               ImageViewLimitedHeightFor(anImage))];  // “显示”时限制高度
        imageView.image = anImage;
        imageView.contentMode = UIViewContentModeScaleAspectFill;  // 图片内容撑满 view
        imageView.layer.cornerRadius = POINT_FROM_PIXEL(4);
        imageView.layer.masksToBounds = YES;
        
        [self addSubview:imageView];
        lastImageView = imageView;
    }];
    
    // 点赞（点赞数超过10个才进行显示）
    SCImageTitleButton *likeButton = nil;
    if (self.content.likeCount.integerValue > 10) {
        likeButton = [[SCImageTitleButton alloc] initWithFrame:CGRectMake(kLeftRightPadding,
                                                                          lastImageView.bottom + POINT_FROM_PIXEL(45),
                                                                          kContentWidth,
                                                                          POINT_FROM_PIXEL(90))];
        [likeButton setTitle:[NSString stringWithFormat:@"%@人点赞", self.content.likeCount] forState:UIControlStateNormal];
        [likeButton setTitleColor:UIColorHex(0x111111) forState:UIControlStateNormal];
        [likeButton setImage:[UIImage imageNamed:@"snapshot_like_icon"] forState:UIControlStateNormal];
        likeButton.titleLabel.font = [UIFont systemFontOfSize:POINT_FROM_PIXEL(24)];
        likeButton.interTitleImageSpacing = POINT_FROM_PIXEL(15);
        [self addSubview:likeButton];
    }
    
    // 二维码
    CGFloat qrCodeImageViewY = likeButton ? likeButton.bottom + POINT_FROM_PIXEL(70) : lastImageView.bottom + POINT_FROM_PIXEL(70);
    UIImageView *qrCodeImageView = [[UIImageView alloc] initWithImage:self.content.qrCodeImage];
    qrCodeImageView.frame = CGRectMake((kSnapshotWidth - kQRCodeWH) / 2.0, qrCodeImageViewY, kQRCodeWH, kQRCodeWH);
    qrCodeImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:qrCodeImageView];
    
    
    // 底部分享文字说明
    UILabel *shareDescLabel = [[UILabel alloc] initWithFrame:CGRectMake((kSnapshotWidth - kShareDescLabelWidth) / 2.0,
                                                                        qrCodeImageView.bottom + POINT_FROM_PIXEL(28),
                                                                        kShareDescLabelWidth,
                                                                        0)];
    shareDescLabel.numberOfLines = 2;
    shareDescLabel.font = [UIFont systemFontOfSize:POINT_FROM_PIXEL(24)];
    shareDescLabel.textAlignment = NSTextAlignmentCenter;
    shareDescLabel.textColor = UIColorHex(0x111111);
    shareDescLabel.text = self.content.shareDescription;
    [self addSubview:shareDescLabel];
    shareDescLabel.height = [shareDescLabel.text sc_heightForFont:shareDescLabel.font
                                                          maxSize:CGSizeMake(shareDescLabel.width, POINT_FROM_PIXEL(65))]; // 最多两行
    
    // 更新高度
    self.height = shareDescLabel.bottom + POINT_FROM_PIXEL(148);
    
}

@end
