//
//  ALBackProgressView.m
//  Smartwatch
//
//  Created by 代亮 on 2017/7/27.
//  Copyright © 2017年 AlphaTelecom. All rights reserved.
//

#import "DLBackProgressView.h"
#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式
#define DEFAULT_STARTANGLE   -90  //默认开始度数
#define DEFAULT_ENDANGLE     270  //默认结束度数
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
//设置 圆环的角度
- (void)setStartAngle:(CGFloat)startAngle{
    
    if ([NSString stringWithFormat:@"%f",_endAngle] == nil) {
        
        if (_startAngle != startAngle) {
            _startAngle = startAngle;
            //从新定义 开始 角度
            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.width/2) radius:(self.frame.size.width - _lineWidth)/2 startAngle:degreesToRadians(_startAngle) endAngle:degreesToRadians(DEFAULT_ENDANGLE) clockwise:YES];
            _shapeLayer.path =[path CGPath];
            _foreLayer.path = [path CGPath];
            
            
        }
    }else{
        
        if (_startAngle != startAngle) {
            _startAngle = startAngle;
            //从新定义 开始 角度
            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.width/2) radius:(self.frame.size.width - _lineWidth)/2 startAngle:degreesToRadians(_startAngle) endAngle:degreesToRadians(_endAngle) clockwise:YES];
            _shapeLayer.path =[path CGPath];
            _foreLayer.path = [path CGPath];
            
            
        }
    }
    
}
- (void)setEndAngle:(CGFloat)endAngle{
    
    if ([NSString stringWithFormat:@"%f",_startAngle] == nil) {
        
        if (_endAngle != endAngle) {
            _endAngle = endAngle;
            //从新定义 结束 角度
            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.width/2) radius:(self.frame.size.width - _lineWidth)/2 startAngle:degreesToRadians(DEFAULT_STARTANGLE) endAngle:degreesToRadians(_endAngle) clockwise:YES];
            _shapeLayer.path =[path CGPath];
            _foreLayer.path = [path CGPath];
        }
        
    }else{
        
        if (_endAngle != endAngle) {
            _endAngle = endAngle;
            //从新定义 结束 角度
            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.width/2) radius:(self.frame.size.width - _lineWidth)/2 startAngle:degreesToRadians(_startAngle) endAngle:degreesToRadians(_endAngle) clockwise:YES];
            _shapeLayer.path =[path CGPath];
            _foreLayer.path = [path CGPath];
        }
        
    }
}

@end
