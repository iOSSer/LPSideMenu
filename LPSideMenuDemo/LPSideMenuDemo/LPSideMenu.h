//
//  LPSideMenu.h
//  LPSideMenuDemo
//
//  Created by MacBook on 15/8/26.
//  Copyright (c) 2015年 lipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPSideMenu : UIViewController

@property (nonatomic, readwrite, strong) UIViewController *contentViewController;//中间视图控制器
@property (nonatomic, readwrite, strong) UIViewController *leftViewController;//左边视图控制器
@property (nonatomic, readwrite, assign) CGFloat scrollOffset;//默认为0.4，即中间视图内容只显示出:屏幕宽度 * 0.4;
@property (nonatomic, readonly, assign) BOOL isShowing;//是否展开状态
@property (nonatomic, readwrite, assign) BOOL menuEnable;//是否可用

- (instancetype) initWithContentViewController:(UIViewController *)contentViewController leftViewController:(UIViewController *)leftViewController;//初始化方法

- (void) showLeft:(BOOL) show;//是否显示左侧
@end
