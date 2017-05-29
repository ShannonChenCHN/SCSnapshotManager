//
//  SCSnapshotMerchantContent.m
//  SCSnapshotDemo
//
//  Created by ShannonChen on 2017/5/22.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCSnapshotMerchantContent.h"
#import "SCSnapshotConst.h"

@implementation SCSnapshotMerchantContent

@synthesize shareUrl = _shareUrl, qrCodeImage = _qrCodeImage;


+ (instancetype)defaultContent {
    
    SCSnapshotMerchantContent *content = [[SCSnapshotMerchantContent alloc] init];
    content.title = @"开在画廊里的法餐厅";
    content.hostName = @"Le Rivage";
    content.sales = @"7059 人拔草";
    
    NSArray *rawData = @[
                         @{@"type" : @"0",
                           @"text" : @"LeRivage，法语里“岸”的意思，开在外滩的黄浦公园，人民英雄纪念碑脚下。餐厅背后的男人是我们都熟悉的，前8½OttoeMezzo上海、香港餐厅前行政总厨ChefAlanYu。餐厅藏身于外滩黄埔公园的一家艺术画廊内，特别的低调私密。共设3个包房，布置得很典雅大气，做的是人均千元的私房法餐，菜单每月更新，想吃必须提前一周预订。"},
                         @{@"type" : @"1",
                           @"imageURL" : @"http://p.yhres.com/file/2017/01/17/1484639269950931.jpg-q75"},
                         @{@"type" : @"0",
                           @"text" : @"桌椅是经得起时间推敲的古董货，酒杯用的是德国Riedel，餐盘挑的是法国LEGLE水墨款…一旦接受了这种中西混搭的设定，内里透出来的品质和高级，都显得难以挑剔起来。"},
                         @{@"type" : @"1",
                           @"imageURL" : @"http://p.yhres.com/file/2017/01/17/1484639288716777.jpg-q75"},
                         @{@"type" : @"0",
                           @"text" : @"全世界唯一用九宫格呈现的西式前菜，看到就已经被美翻了…9款造型各异的鎏金瓷花碟，盛放着9款同样精巧的匠心前菜，颜值高到相机手机都喂满了它不同角度的写真照。"},
                         @{@"type" : @"1",
                           @"imageURL" : @"http://p.yhres.com/file/2017/01/17/1484639301333522.jpg-q75"}];
    
    NSMutableArray *recommendationDeatails = [NSMutableArray array];
    for (NSDictionary *aDetailItem in rawData) {
            
            SCSnapshotMerchantDetailItem *itemModel = [[SCSnapshotMerchantDetailItem alloc] init];
            if ([aDetailItem[@"type"] integerValue] == SCSnapshotMerchantDetailItemTypeImage) {
                
                itemModel.contentType = SCSnapshotMerchantDetailItemTypeImage;
                itemModel.imageURL = aDetailItem[@"imageURL"];
                
            } else if ([aDetailItem[@"type"] integerValue] == SCSnapshotMerchantDetailItemTypeText) {
                
                itemModel.contentType = SCSnapshotMerchantDetailItemTypeText;
                itemModel.text = aDetailItem[@"text"];
            }
        
            [recommendationDeatails addObject:itemModel];
    }
    content.recommendationDetails = recommendationDeatails;
    
  ;
    
    content.shareDescription = kSnapshotMerchantShareDescDefault;
    content.shareUrl = kSnapshotShareUrlDefault;
    
    return content;
}

@end


@implementation SCSnapshotMerchantDetailItem



@end
