//
//  MJMeteorView.m
//  MJMeteorView
//
//  Created by 刘鹏 on 2018/4/26.
//  Copyright © 2018年 musjoy. All rights reserved.
//  粒子效果-流星

#import "MJMeteorView.h"

@implementation MJMeteorView
#pragma mark - Life Circle
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self configView];
}

+ (Class)layerClass
{
    return [CAEmitterLayer class];
}

#pragma mark - Subjoin
- (void)configView
{
    // 创建发射器
    CAEmitterLayer *layer = (CAEmitterLayer *)self.layer;
    // 设置发射器大小
    [self configEmitterFrame];
    // 发射器外形
    layer.emitterShape = kCAEmitterLayerRectangle;
    
    // 创建粒子
    CAEmitterCell *meteorCell = [[CAEmitterCell alloc] init];
    UIImage *image = [UIImage imageNamed:@"img_home_meteor"];
    meteorCell.contents = (__bridge id)image.CGImage;
    meteorCell.birthRate = 0.5;             // 每秒创建的cell
    meteorCell.lifetime = 5;                // 生命周期
    //    meteorCell.lifetimeRange = 3;         // 生命周期范围
    meteorCell.emissionLongitude = 150 / 180.0 * M_PI;        // 发射角度 （与y轴成60°角）
    meteorCell.velocity = 150;              // 初始速度
    meteorCell.velocityRange = 200;         // 初始速度随机范围
    meteorCell.yAcceleration = 130;         // y轴的加速度
    meteorCell.xAcceleration = -(tan(60/ 180.0 * M_PI) * 130);// x轴的加速度（与y轴成60°角）
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        //iPad
        meteorCell.scale = 0.18;                // 图片比例
    } else {
        //Phone
        meteorCell.scale = 0.11;                // 图片比例
    }
    meteorCell.color = [[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor;
    meteorCell.alphaSpeed = -0.15;          // 透明度增长速度，负数递减
    
    layer.emitterCells = @[meteorCell];
}

- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    [self configEmitterFrame];
}

// 设置发射器大小
- (void)configEmitterFrame
{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    // 发射器设置
    CAEmitterLayer *emitterLayer = (CAEmitterLayer *)self.layer;
    CGFloat h_scale = 0.5;  //发射器占视图高度比例
    CGFloat angle = 30; //流星角度
    CGFloat emitterHeight = tan(angle / 180.0 * M_PI) * width + height * h_scale;
    emitterLayer.emitterSize =  CGSizeMake(20, emitterHeight); // 发射器大小
    emitterLayer.emitterPosition = CGPointMake(width + 20, h_scale * height - (emitterHeight * 0.5));  // 发射器中心点
}

@end
