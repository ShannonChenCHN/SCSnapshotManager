//
//  SCURLViewController.m
//  SCSnapshotDemo
//
//  Created by ShannonChen on 2017/4/26.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCURLViewController.h"
#import "SCPreviewViewController.h"
#import "SCWebViewController.h"

#import "SCSnapshotManager.h"

@interface SCURLViewController ()
    
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *generateButton;
@property (weak, nonatomic) IBOutlet UIButton *openWebViewButton;

@end

@implementation SCURLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.generateButton.layer.borderColor = [UIColor cyanColor].CGColor;
    self.generateButton.layer.borderWidth = 1;
    self.generateButton.layer.cornerRadius = 2;
    
    self.openWebViewButton.layer.borderColor = [UIColor blueColor].CGColor;
    self.openWebViewButton.layer.borderWidth = 1;
    self.openWebViewButton.layer.cornerRadius = 2;
    
    
    self.textField.text = @"https://github.com/ShannonChenCHN";
    
    self.navigationItem.title = @"Generate From WebView";
}

    
- (IBAction)generateSnapshot:(id)sender {
    if (!self.textField.text.length) {
        return;
    }
    
    [SCSnapshotManager generateSnapshotWithURLString:self.textField.text completionHandler:^(UIImage * _Nullable snapshot, NSError * _Nullable error) {
    
        if (!error) {
            SCPreviewViewController *controller = [[SCPreviewViewController alloc] initWithSnapshot:snapshot];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
            [self presentViewController:navigationController animated:YES completion:NULL];
        }
        
    }];
}
    
- (IBAction)openWebView:(id)sender {
    if (!self.textField.text.length) {
        return;
    }
    
    SCWebViewController *controller = [[SCWebViewController alloc] initWithURLString:self.textField.text];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:navigationController animated:YES completion:NULL];
}
    
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


@end
