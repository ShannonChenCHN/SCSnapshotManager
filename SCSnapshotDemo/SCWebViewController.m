//
//  SCWebViewController.m
//  SCSnapshotDemo
//
//  Created by ShannonChen on 17/4/26.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCWebViewController.h"

@interface SCWebViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (copy, nonatomic) NSString *urlString;

@end

@implementation SCWebViewController

- (instancetype)initWithURLString:(NSString *)urlString {
    self = [super initWithNibName:@"SCWebViewController" bundle:nil];
    if (self) {
        _urlString = [urlString copy];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    self.navigationItem.title = @"Web Content";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
}

- (void)done:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
