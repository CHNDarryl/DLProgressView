//
//  ViewController.m
//  DLProgressView
//
//  Created by 代亮 on 2017/7/28.
//  Copyright © 2017年 代亮. All rights reserved.
//

#import "ViewController.h"
#import "DLBackProgressView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DLBackProgressView *backGroundProgressView = [[DLBackProgressView alloc]initWithFrame:CGRectMake(0, 0, 200, 200) lineWidth:20];
    self.view.backgroundColor = [UIColor blackColor];
    backGroundProgressView.bottomLineColor = [UIColor redColor];
    backGroundProgressView.center = self.view.center;
    backGroundProgressView.progress = 0.5;
    backGroundProgressView.textString = [NSString stringWithFormat:@"%.0f%%",backGroundProgressView.progress * 100];
    [self.view addSubview:backGroundProgressView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
