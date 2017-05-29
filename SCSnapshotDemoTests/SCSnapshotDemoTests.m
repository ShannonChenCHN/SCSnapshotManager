//
//  SCSnapshotDemoTests.m
//  SCSnapshotDemoTests
//
//  Created by ShannonChen on 2017/5/29.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "SCSnapshotManager.h"
#import "SCSnapshotPostContent.h"
#import "SCSnapshotMerchantContent.h"
#import "SCSnapshotConst.h"

#import "SCSnapshotImageDownloader.h"

@interface SCSnapshotDemoTests : XCTestCase

@end

@implementation SCSnapshotDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPostShanpshotGenerating {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
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
    
    [SCSnapshotManager shareSnapshotWithModel:content completionHandler:^(UIImage * _Nullable snapshot, NSError * _Nullable error) {
        XCTAssert(snapshot != nil);
        
    }];
}

- (void)testMerchantsShanpshotGenerating {
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
    content.recommendationDetails = nil;
    
    
    
    content.shareDescription = kSnapshotMerchantShareDescDefault;
    content.shareUrl = kSnapshotShareUrlDefault;
    
    [SCSnapshotManager shareSnapshotWithModel:content completionHandler:^(UIImage * _Nullable snapshot, NSError * _Nullable error) {
        XCTAssert(snapshot == nil && error != nil);
        
    }];
}

- (void)testImageDownloader {
    
    NSArray *imageURLs = @[@[@"http://p.yhres.com/file/2017/01/17/1484639269950931.jpg-q75"],
                            @[@"http://p.yhres.com/file/2017/01/17/1484639269950931.jpg-q75"]];
    
    SCSnapshotImageDownloader *downloader1 = [[SCSnapshotImageDownloader alloc] init];
    [downloader1 downloadWithImageURLArrays:imageURLs completionHandler:^(NSArray<NSArray<UIImage *> *> * _Nullable imageArrays, BOOL success) {
        XCTAssert(success == YES, @"Download succeeded");
    }];
    
    NSArray *emptyImageURLArray1 = @[@[], @[]];
    SCSnapshotImageDownloader *downloader2 = [[SCSnapshotImageDownloader alloc] init];
    [downloader2 downloadWithImageURLArrays:emptyImageURLArray1 completionHandler:^(NSArray<NSArray<UIImage *> *> * _Nullable imageArrays, BOOL success) {
        XCTAssert(success == YES, @"Download succeeded");
    }];
    
    NSArray *emptyImageURLArray2 = @[];
    SCSnapshotImageDownloader *downloader3 = [[SCSnapshotImageDownloader alloc] init];
    [downloader3 downloadWithImageURLArrays:emptyImageURLArray2 completionHandler:^(NSArray<NSArray<UIImage *> *> * _Nullable imageArrays, BOOL success) {
        XCTAssert(success == NO, @"Download failed");
    }];
    
    NSArray *nilImageURLArray = nil;
    SCSnapshotImageDownloader *downloader4 = [[SCSnapshotImageDownloader alloc] init];
    [downloader4 downloadWithImageURLArrays:nilImageURLArray completionHandler:^(NSArray<NSArray<UIImage *> *> * _Nullable imageArrays, BOOL success) {
        XCTAssert(success == NO, @"Download failed");
    }];
}

@end
