//
//  ViewController.m
//  SCSnapshotDemo
//
//  Created by ShannonChen on 2017/3/19.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "ViewController.h"

#import "SCContentViewController.h"
#import "SCURLViewController.h"

static NSString * const kCellPropertyTitleKey = @"title";
static NSString * const kCellPropertyControllerKey = @"controller";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
    
@property (strong, nonatomic) NSArray *cellProperties;

@end

@implementation ViewController

    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cellProperties = @[@{kCellPropertyTitleKey : @"Generate from custom view 1",
                              kCellPropertyControllerKey : @"SCContentViewController"},
                            @{kCellPropertyTitleKey : @"Generate from web view",
                              kCellPropertyControllerKey : @"SCURLViewController"}
                        ];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellProperties.count;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.cellProperties[indexPath.row][kCellPropertyTitleKey];
    
    return cell;
}
    
#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *className = self.cellProperties[indexPath.row][kCellPropertyControllerKey];
    
    if (className && NSClassFromString(className)) {
        [self.navigationController pushViewController:[NSClassFromString(className) new] animated:YES];
    }
}


@end
