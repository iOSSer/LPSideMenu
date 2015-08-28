//
//  LPSideMenu.h
//  LPSideMenuDemo
//
//  Created by MacBook on 15/8/26.
//  Copyright (c) 2015年 lipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPSideMenu : UIViewController

@property (nonatomic, readwrite, strong) UIViewController *contentViewController;
@property (nonatomic, readwrite, strong) UIViewController *leftViewController;
@property (nonatomic, readwrite, assign) CGFloat scrollOffset;

- (instancetype) initWithContentViewController:(UIViewController *)contentViewController leftViewController:(UIViewController *)leftViewController;

- (void) showLeft:(BOOL) show;

@end
