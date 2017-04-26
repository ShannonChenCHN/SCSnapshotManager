//
//  SCContentViewController.m
//  SCSnapshotDemo
//
//  Created by ShannonChen on 2017/4/26.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCContentViewController.h"
#import "SCPreviewViewController.h"

#import "SCSnapshotContent.h"
#import "SCSnapshotManager.h"

@interface SCContentViewController ()

@property (weak, nonatomic) IBOutlet UIButton *generateButton;

@end

@implementation SCContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.generateButton.layer.borderColor = [UIColor cyanColor].CGColor;
    self.generateButton.layer.borderWidth = 1;
    self.generateButton.layer.cornerRadius = 2;
    
    self.navigationItem.title = @"Generate From Content";
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.50;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.4, 1.4, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [self.generateButton.layer addAnimation:animation forKey:nil];

}

- (IBAction)generateSnapshot:(id)sender {
    
    [SCSnapshotManager generateSnapshotWithContent:[SCSnapshotContent defaultContent] completionHander:^(UIImage * _Nullable snapshot, NSError * _Nullable error) {
        if (!error) {
            SCPreviewViewController *controller = [[SCPreviewViewController alloc] initWithSnapshot:snapshot];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
            [self presentViewController:navigationController animated:YES completion:NULL];
        }
        
    }];
}

@end
