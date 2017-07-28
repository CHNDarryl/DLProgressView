//
//  ALBackProgressView.h
//  Smartwatch
//
//  Created by 代亮 on 2017/7/27.
//  Copyright © 2017年 AlphaTelecom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLBackProgressView : UIView
-(instancetype)initWithFrame:(CGRect)frame lineWidth:(CGFloat)lineWidth;
/** 圆圈的进度,参数为0-1*/
@property(nonatomic, assign) CGFloat progress;
/** 进度条的底色,*/
@property(nonatomic, strong) UIColor *bottomLineColor;  //默认灰色
/** 进度条的画线颜色*/
@property(nonatomic, strong) UIColor *drawLineColor;   //默认黄色
/** 圆圈中间的文字*/
@property(nonatomic, strong) NSString *textString;
/** 中间文字的颜色*/
@property (nonatomic, strong) UIColor *textColor;    //默认白色
/** 中间文字的大小*/
@property (nonatomic, assign) CGFloat textSize;      //默认42
@end
