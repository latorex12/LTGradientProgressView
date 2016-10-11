//
//  ViewController.m
//  GradientLayer&MaskLayer
//
//  Created by 梁天 on 16/10/9.
//  Copyright © 2016年 梁天. All rights reserved.
//

#import "ViewController.h"
#import "LTGradientProgressView.h"

@interface ViewController ()
@property (nonatomic, strong) LTGradientProgressView *progressView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    
}

- (IBAction)action:(id)sender {
    [self performSelector:@selector(configProgressView) withObject:nil afterDelay:2.0];
}

- (void)configProgressView {
    self.progressView = [[LTGradientProgressView alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 10.0)];
    [self.view addSubview:self.progressView];
    
    [self changeProgressAuto];
}

- (void)changeProgressAuto {
    CGFloat progress = self.progressView.progress + 0.05;
    
    if (progress > 1.01) {
        return;
    }
    self.progressView.progress = progress;
    NSLog(@"---->%f",self.progressView.progress);
    
    [self performSelector:@selector(changeProgressAuto) withObject:nil afterDelay:0.2];
}

@end
