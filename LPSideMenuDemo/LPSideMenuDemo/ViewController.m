//
//  ViewController.m
//  LPSideMenuDemo
//
//  Created by 李鹏 on 15/5/3.
//  Copyright (c) 2015年 lipeng. All rights reserved.
//

#import "ViewController.h"
#import "CenterViewController.h"

@interface ViewController ()
{
    CGSize mainSize;
}

@property (nonatomic, strong) CenterViewController *center;

@end

CGFloat distance = 0.f;
CGFloat fullDistance = 0.78f;
CGFloat proportion = 0.77f;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.title = @"ViewController.m";
    
    mainSize = [UIScreen mainScreen].bounds.size;
    
    self.center = [[CenterViewController alloc] init];
    [self.view addSubview:self.center.view];
    
    self.center.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(paned:)];
    [self.center.view addGestureRecognizer:self.center.pan];
}

- (void) paned:(UIPanGestureRecognizer *)pan
{
    CGFloat x = [pan translationInView:self.view].x;
    CGFloat trueDistance = distance + x;
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (trueDistance > mainSize.width * (proportion / 3)) {
            [self showLeftView];
        }else if (trueDistance < mainSize.width * (-(proportion / 3)))
        {
            [self showRightView];
        }else
        {
            [self showCenterView];
        }
        return;
    }
    
    CGFloat proportion1 = pan.view.frame.origin.x >= 0 ? - 1 : 0;
    proportion1 *= (trueDistance / mainSize.width);
    proportion1 *= 1 - proportion;
    proportion1 /= 0.6;
    proportion1 += 1;
    if (proportion1 <= proportion) {
        return;
    }
    
    pan.view.center = CGPointMake(self.view.center.x + trueDistance, self.view.center.y);
    pan.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion);
}

- (void) showLeftView
{
    distance = self.view.center.x * (fullDistance + proportion/2);
    [self viewAnimtion:distance];
}

- (void) showRightView
{
    distance = 0.f;
    [self viewAnimtion:1.f];
}

- (void) showCenterView
{
    distance = self.view.center.x * - (fullDistance + proportion / 2);
    [self viewAnimtion:proportion];
}

- (void) viewAnimtion:(CGFloat)proportion
{
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.center.view.center = CGPointMake(self.view.center.x + proportion, self.view.center.y);
        self.center.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion);
    } completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
