//
//  ALBackProgressView.m
//  Smartwatch
//
//  Created by 代亮 on 2017/7/27.
//  Copyright © 2017年 AlphaTelecom. All rights reserved.
//

#import "DLBackProgressView.h"

@interface DLBackProgressView()
@property(nonatomic, strong) UILabel *label;
@property(nonatomic, assign) CGFloat lineWidth;
@property(nonatomic, strong) CAShapeLayer *foreLayer;//蒙版layer
@property(nonatomic, strong) CAShapeLayer *shapeLayer;
@property(nonatomic, strong) CAGradientLayer *gradientLayer;
@end
@implementation DLBackProgressView

-(instancetype)initWithFrame:(CGRect)frame lineWidth:(CGFloat)lineWidth
{
    self = [super initWithFrame:frame];
    if (self) {
        _lineWidth = lineWidth;
        [self setupNormalStyle];
        [self setup:frame];
    }
    return self;
}
- (void)setupNormalStyle{
    _bottomLineColor = [UIColor grayColor];
    _drawLineColor = [UIColor yellowColor];
    _textColor = [UIColor whiteColor];
    _textSize = 42;
}
-(void)setup:(CGRect)rect{
    
    //背景灰色
    CAShapeLayer *shapeLayer =[[CAShapeLayer alloc]init];
    shapeLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.width);
    shapeLayer.lineWidth = _lineWidth;
    shapeLayer.fillColor =[UIColor clearColor].CGColor;
    shapeLayer.strokeColor = _bottomLineColor.CGColor;
    CGPoint center =  CGPointMake((rect.size.width )/2, (rect.size.width)/2);
    UIBezierPath *bezierPath =[UIBezierPath bezierPathWithArcCenter:center radius:(rect.size.width- _lineWidth)/2 startAngle:-0.5 *M_PI endAngle:1.5 *M_PI clockwise:YES];
    shapeLayer.path = bezierPath.CGPath;
    self.shapeLayer = shapeLayer;
    [self.layer addSublayer:shapeLayer];
    
    
    //渐变色，加蒙版，显示的蒙版的区域
    CAGradientLayer *gradientLayer =[[CAGradientLayer alloc]init];
    
    gradientLayer.frame = self.bounds;
    
    gradientLayer.colors = @[(id)_drawLineColor.CGColor,(id)_drawLineColor.CGColor];
    
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    self.gradientLayer = gradientLayer;
    [self.layer addSublayer:gradientLayer];
    
    
    self.foreLayer = [CAShapeLayer layer];
    self.foreLayer.frame = self.bounds;
    
    self.foreLayer.fillColor =[UIColor clearColor].CGColor;
    
    self.foreLayer.lineWidth = self.lineWidth;
    self.foreLayer.strokeColor = [UIColor redColor].CGColor;
    
    self.foreLayer.strokeEnd = 0;
    self.foreLayer.lineCap = kCALineCapRound;
    
    self.foreLayer.path = bezierPath.CGPath;
    
    gradientLayer.mask = self.foreLayer;
    
    
    self.label =[[UILabel alloc]initWithFrame:self.bounds];
    self.label.text  = @"";
    self.label.font =[UIFont boldSystemFontOfSize:_textSize];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor =_textColor;
    [self addSubview:self.label];
}
-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    self.foreLayer.strokeEnd = progress;
    [self setNeedsDisplay];
}
-(void)setTextString:(NSString *)textString{
    self.label.text = textString;
    [self setNeedsDisplay];
}
- (void)setBottomLineColor:(UIColor *)bottomLineColor{
    if (bottomLineColor == _bottomLineColor) {
        return;
    }
    _bottomLineColor = bottomLineColor;
    self.shapeLayer.strokeColor = _bottomLineColor.CGColor;
    
    [self setNeedsDisplay];
}

-(void)setDrawLineColor:(UIColor *)drawLineColor{
    if (drawLineColor == _drawLineColor) {
        return;
    }
    _drawLineColor = drawLineColor;
    self.gradientLayer.colors = @[(id)_drawLineColor.CGColor,(id)_drawLineColor.CGColor];
    [self setNeedsDisplay];
}
- (void)setTextSize:(CGFloat)textSize{
    if (textSize == _textSize) {
        return;
    }
    self.label.font =[UIFont boldSystemFontOfSize:textSize];
    [self setNeedsDisplay];
}
- (void)setTextColor:(UIColor *)textColor{
    if (textColor == _textColor) {
        return;
    }
    self.label.textColor =textColor;
    [self setNeedsDisplay];
}
@end
