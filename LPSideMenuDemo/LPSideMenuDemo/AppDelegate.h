//
//  AppDelegate.h
//  LPSideMenuDemo
//
//  Created by 李鹏 on 15/5/3.
//  Copyright (c) 2015年 lipeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPSideMenu.h"
#import "LeftViewController.h"
#import "CenterViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) LPSideMenu *menu;

@end

