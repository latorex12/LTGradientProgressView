//
//  LTGradientProgressView.m
//  GradientLayer&MaskLayer
//
//  Created by 梁天 on 16/10/9.
//  Copyright © 2016年 梁天. All rights reserved.
//

#import "LTGradientProgressView.h"

@interface LTGradientProgressView () <CAAnimationDelegate>
@property (nonatomic, strong) CALayer *maskLayer;
@property (nonatomic, strong) NSMutableArray *colors;
@end

@implementation LTGradientProgressView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setupGradientLayer];
        
        _maskLayer = [[CALayer alloc]init];
        _maskLayer.frame = CGRectMake(0, 0, 0, self.bounds.size.height);
        _maskLayer.backgroundColor = [UIColor blackColor].CGColor;
        [self.layer setMask:_maskLayer];
        
        [self animateLayerColor];
    }
    return  self;
}

- (void)setupGradientLayer {
    CAGradientLayer *layer = (CAGradientLayer *)self.layer;
    NSMutableArray *colorArray = [NSMutableArray array];
    for (int i = 0; i <= 360; i += 90) {
        UIColor *color = [UIColor colorWithHue:i/360.0 saturation:1.0 brightness:1.0 alpha:1.0];
        [colorArray addObject:(id)color.CGColor];
    }
    //此处要给CGColor
    layer.colors = colorArray;
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 0);
}

- (void)animateLayerColor {
    CAGradientLayer *layer = (CAGradientLayer *)self.layer;
    self.colors = layer.colors.mutableCopy;
    UIColor *color = self.colors.lastObject;
    [self.colors removeLastObject];
    [self.colors insertObject:color atIndex:0];
    
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    animation.toValue = self.colors;
    animation.duration = 1.0;
    animation.delegate = self;
    
    [self.layer addAnimation:animation forKey:@"animateGradient"];
}

- (void)layoutSubviews {
    self.maskLayer.frame = CGRectMake(0, 0, self.bounds.size.width * self.progress, self.bounds.size.height);
}

/**
 * 设置layer的类
 */
+ (Class)layerClass {
    return [CAGradientLayer class];
}

#pragma mark - Delegate
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    CAGradientLayer *layer = (CAGradientLayer *)self.layer;
    layer.colors = self.colors;
    [self animateLayerColor];
}

#pragma mark - Setter

/**
 *在设置progress的同时修改maskLayer的frame，达到进度条增长的效果
 */
- (void)setProgress:(CGFloat)progress {
    if (_progress == progress) {
        return;
    }
    if (progress < 0.0) {
        progress = 0.0;
    }
    if (progress > 1.0) {
        progress = 1.0;
    }
    _progress = progress;

    [self setNeedsLayout];
}


@end
