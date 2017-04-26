//
//  SCPreviewViewController.m
//  SCSnapshotDemo
//
//  Created by ShannonChen on 2017/3/19.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCPreviewViewController.h"
#import "UIView+Layout.h"

#define kLeftRightPadding    15
#define kTopBottomPadding    10

@interface SCPreviewViewController ()

@property (strong, nonatomic) UIImage *snapshot;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation SCPreviewViewController

- (instancetype)initWithSnapshot:(UIImage *)snapshot {
    
    self = [super initWithNibName:@"SCPreviewViewController" bundle:nil];
    if (self) {
        _snapshot = snapshot;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.image = self.snapshot;
    
    self.navigationItem.title = @"Snapshot Preview";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    
    self.imageView.width = self.view.width - 2 * kLeftRightPadding;
    self.imageView.y = kTopBottomPadding;
    self.imageView.x = kLeftRightPadding;
    self.imageView.height = self.imageView.width * self.snapshot.size.height / self.snapshot.size.width;
    
    self.scrollView.contentSize = CGSizeMake(self.view.width, self.imageView.height + 2 * kTopBottomPadding);
    self.scrollView.frame = self.view.bounds;
}

- (void)done:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
