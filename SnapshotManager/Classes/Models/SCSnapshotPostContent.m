//
//  SCSnapshotPostContent.m
//  SCSnapshotDemo
//
//  Created by ShannonChen on 2017/3/19.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCSnapshotPostContent.h"
#import "SCSnapshotConst.h"

@implementation SCSnapshotPostContent

@synthesize shareUrl = _shareUrl, qrCodeImage = _qrCodeImage;
    
+ (instancetype)defaultContent {
    
    SCSnapshotPostContent *content = [[SCSnapshotPostContent alloc] init];
    content.posterName = @"Yumi";
    content.posterAvatarURLString = @"http://f.yhres.com/editUserHeaderImage/2016/09/29/496809674363284.png-ssq75";
    content.userTagDescription = @"时尚达人/娱乐记者/模特";
    content.textContent = @"这两天一直在打理微信和微博\n不得不说每天充实的生活让我有更好的睡眠\n每天也更有动力起床干活";
    content.likeCount = @"187";
    content.picUrls = @[@"http://f.yhres.com/share_webcastEKZlZmtlAQNkZwuinSx/2017/03/25/512132450675479_0.png-q75",
                        @"http://f.yhres.com/share_webcastEKZlZmtlAQNkZwuinSx/2017/03/25/512132450731901_4.png-q75",
                        @"http://f.yhres.com/share_webcastEKZlZmtlAQNkZwuinSx/2017/03/25/512132450772668_1.png-q75",
                        @"http://f.yhres.com/share_webcastEKZlZmtlAQNkZwuinSx/2017/03/25/512132450790422_2.png-q75",
                        @"http://f.yhres.com/share_webcastEKZlZmtlAQNkZwuinSx/2017/03/25/512132450806057_3.png-q75",
                        @"http://f.yhres.com/share_webcastEKZlZmtlAQNkZwuinSx/2017/03/25/512132450822778_5.png-q75",
                        @"http://f.yhres.com/share_webcastEKZlZmtlAQNkZwuinSx/2017/03/25/512132450846813_6.png-q75",
                        @"http://f.yhres.com/share_webcastEKZlZmtlAQNkZwuinSx/2017/03/25/512132450866713_8.png-q75",
                        @"http://f.yhres.com/share_webcastEKZlZmtlAQNkZwuinSx/2017/03/25/512132450880938_7.png-q75"];
    content.shareUrl = kSnapshotShareUrlDefault;
    content.shareDescription = kSnapshotPostShareDescDefault;
    
    return content;
}

@end
