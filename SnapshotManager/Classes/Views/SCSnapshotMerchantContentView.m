//
//  SCSnapshotMerchantContentView.m
//  SCSnapshotDemo
//
//  Created by ShannonChen on 2017/5/23.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCSnapshotMerchantContentView.h"
#import "SCSnapshotConst.h"

#import "SCSnapshotMerchantContent.h"

#import "SCCustomButton.h"


#import "UIView+Layout.h"
#import "UIColor+SCExtension.h"
#import "NSString+SCExtension.h"


@interface SCSnapshotMerchantContentView ()

@property (strong, nonatomic) SCSnapshotMerchantContent *content;

@end


@implementation SCSnapshotMerchantContentView


- (instancetype)initWithContent:(SCSnapshotMerchantContent *)content {
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
    
    // 大标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLeftRightPadding, POINT_FROM_PIXEL(118), kContentWidth, POINT_FROM_PIXEL(35))];
    titleLabel.numberOfLines = 1;
    titleLabel.font = [UIFont boldSystemFontOfSize:POINT_FROM_PIXEL(32)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = UIColorHex(0x111111);
    titleLabel.text = self.content.title;
    [self addSubview:titleLabel];
    
    __block UIView *lastView = titleLabel;
    
    // 商户名
    if (self.content.hostName.length > 0) {
        SCCustomButton *hostNameButton = [[SCCustomButton alloc] initWithFrame:CGRectMake(kLeftRightPadding,
                                                                                          lastView.bottom + POINT_FROM_PIXEL(34),
                                                                                          kContentWidth,
                                                                                          POINT_FROM_PIXEL(30))];
        [hostNameButton setTitle:self.content.hostName forState:UIControlStateNormal];
        [hostNameButton setTitleColor:UIColorHex(0x111111) forState:UIControlStateNormal];
        hostNameButton.titleLabel.font = [UIFont systemFontOfSize:POINT_FROM_PIXEL(26)];
        [hostNameButton setImage:[UIImage imageNamed:@"snapshot_merchant_icon"] forState:UIControlStateNormal];
        hostNameButton.interTitleImageSpacing = POINT_FROM_PIXEL(8);
        hostNameButton.imagePosition = SCCustomButtonImagePositionLeft;
        [self addSubview:hostNameButton];
        
        lastView = hostNameButton;
    }
    
    
    // 拔草数
    if (self.content.sales.length > 0) {
        UILabel *salesLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLeftRightPadding,
                                                                        lastView.bottom + POINT_FROM_PIXEL(17),
                                                                        kContentWidth,
                                                                        POINT_FROM_PIXEL(28))];
        salesLabel.numberOfLines = 1;
        salesLabel.font = [UIFont systemFontOfSize:POINT_FROM_PIXEL(20)];
        salesLabel.textAlignment = NSTextAlignmentCenter;
        salesLabel.textColor = UIColorHex(0x555555);
        salesLabel.text = self.content.sales;
        [self addSubview:salesLabel];
        
        lastView = salesLabel;
    }
    
    
        // 有图文推荐详情
        
        [self.content.recommendationDetails enumerateObjectsUsingBlock:^(SCSnapshotMerchantDetailItem *aDetailItem, NSUInteger idx, BOOL *stop) {
            CGFloat originY = (idx == 0) ? (lastView.bottom + POINT_FROM_PIXEL(68.0)) :
            (lastView.bottom + POINT_FROM_PIXEL(34.0));
            if (aDetailItem.contentType == SCSnapshotMerchantDetailItemTypeImage) { // 图片
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kLeftRightPadding,
                                                                                       originY,
                                                                                       kContentWidth,
                                                                                       ImageViewLimitedHeightFor(aDetailItem.downloadedImage))];  // “显示”时限制高度
                imageView.image = aDetailItem.downloadedImage;
                imageView.contentMode = UIViewContentModeScaleAspectFill;  // 图片内容撑满 view
                imageView.layer.cornerRadius = POINT_FROM_PIXEL(4);
                imageView.layer.masksToBounds = YES;
                [self addSubview:imageView];
                
                lastView = imageView;
            }
            else if (aDetailItem.contentType == SCSnapshotMerchantDetailItemTypeText) { // 文字
                CGFloat originY = (idx == 0) ? (lastView.bottom + POINT_FROM_PIXEL(68.0)) :
                (lastView.bottom + POINT_FROM_PIXEL(34.0));
                
                UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLeftRightPadding,
                                                                                            originY,
                                                                                            kContentWidth,
                                                                                            POINT_FROM_PIXEL(28))];
                textLabel.text = aDetailItem.text;
                textLabel.numberOfLines = 0;
                textLabel.font = [UIFont systemFontOfSize:POINT_FROM_PIXEL(24)];
                textLabel.textColor = UIColorHex(0x111111);
                textLabel.height = [textLabel.text sc_heightForFont:textLabel.font width:kContentWidth];;
                [self addSubview:textLabel];
                
                lastView = textLabel;
            }
        }];
    
    
    // 二维码
    CGFloat qrCodeImageViewY = lastView.bottom + POINT_FROM_PIXEL(77.0);
    UIImageView *qrCodeImageView = [[UIImageView alloc] initWithImage:self.content.qrCodeImage];
    qrCodeImageView.frame = CGRectMake((kSnapshotWidth - kQRCodeWH) / 2.0, qrCodeImageViewY, kQRCodeWH, kQRCodeWH);
    qrCodeImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:qrCodeImageView];
    
    
    // 底部分享文字说明
    UILabel *shareDescLabel = [[UILabel alloc] initWithFrame:CGRectMake((kSnapshotWidth - kShareDescLabelWidth) / 2.0,
                                                                        qrCodeImageView.bottom + POINT_FROM_PIXEL(28),
                                                                        kShareDescLabelWidth,
                                                                        0)];
    shareDescLabel.numberOfLines = 0;
    shareDescLabel.font = [UIFont systemFontOfSize:POINT_FROM_PIXEL(24)];
    shareDescLabel.textAlignment = NSTextAlignmentCenter;
    shareDescLabel.textColor = UIColorHex(0x111111);
    shareDescLabel.text = self.content.shareDescription;
    [self addSubview:shareDescLabel];
    shareDescLabel.height = [shareDescLabel.text sc_heightForFont:shareDescLabel.font width:shareDescLabel.width];
    
    
    // 更新高度
    self.height = shareDescLabel.bottom + POINT_FROM_PIXEL(148);
    
    
}

@end
