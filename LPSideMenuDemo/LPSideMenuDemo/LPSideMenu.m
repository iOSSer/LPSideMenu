//
//  LPSideMenu.m
//  LPSideMenuDemo
//
//  Created by MacBook on 15/8/26.
//  Copyright (c) 2015年 lipeng. All rights reserved.
//

#import "LPSideMenu.h"

@interface LPSideMenu ()

@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, assign) CGPoint beginPoint;

@end

static CGFloat const defaultScrollOffset = 0.4;

@implementation LPSideMenu
{
    BOOL isShow;
}

- (BOOL)isShowing
{
    return isShow;
}

- (instancetype)initWithContentViewController:(UIViewController *)contentViewController leftViewController:(UIViewController *)leftViewController
{
    self = [super init];
    if (self) {
        _contentViewController = contentViewController;
        _leftViewController = leftViewController;
    }
    return self;
}

- (CGFloat) getOffsetValue
{
    if (!self.scrollOffset) {
        self.scrollOffset = defaultScrollOffset;
    }
    return self.scrollOffset;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    if (self.contentViewController) {
        [self addChildViewController:self.contentViewController];
        UIView *contentView = self.contentViewController.view;
        contentView.layer.shadowColor = [UIColor grayColor].CGColor;
        contentView.layer.shadowOffset = CGSizeMake(- 4, 3);
        contentView.layer.shadowOpacity = 0.3;
        contentView.layer.shadowRadius = 2;
        [self.view addSubview:contentView];
    }
    
    if (self.leftViewController) {
        [self addChildViewController:self.leftViewController];
        UIView *leftView = self.leftViewController.view;
        leftView.frame = self.view.bounds;
        [self.view addSubview:leftView];
        [self.view sendSubviewToBack:leftView];
    }
    
    self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:self.pan];
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.contentViewController.view addGestureRecognizer:self.tap];
}

- (void) tapAction:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:self.view];
    if (CGRectContainsPoint(self.contentViewController.view.frame, point)) { //判断点击的点是否在中间视图上
        [self showLeft:NO];
    }
}

- (void) panAction:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan locationInView:self.view];
    CGFloat viewLeft = [pan translationInView:self.view].x;
    isShow = NO;
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            self.beginPoint = point;
            break;
        case UIGestureRecognizerStateChanged:
        {
            UIView *contentView = self.contentViewController.view;
            self.contentViewController.view.frame = CGRectMake(self.beginPoint.x + viewLeft, 0, CGRectGetWidth(contentView.bounds), CGRectGetHeight(contentView.bounds));
//            NSLog(@"beginpointx %f viewleft %f", self.beginPoint.x, viewLeft);
        }
            break;
        
        case UIGestureRecognizerStateEnded:
        {
            CGFloat contentLeft = self.contentViewController.view.frame.origin.x;
            if (contentLeft < CGRectGetWidth(self.view.bounds) / 3.5) {
                [self showLeft:NO];
            }else
            {
                [self showLeft:YES];
                
            }
            self.beginPoint = CGPointZero;
        }
            break;
        default:
            break;
    }
}


- (void)showLeft:(BOOL)show
{
    isShow = show;
    self.tap.enabled = isShow;
    if (!show) {
        
        [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.contentViewController.view.frame = self.view.bounds;
        } completion:^(BOOL finished) {
            
        }];
        return;
    }
    // to right
    CGFloat contentLeft = CGRectGetWidth(self.view.bounds) *  (1 - [self getOffsetValue]);
    [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.contentViewController.view.frame = CGRectMake(contentLeft, 0, CGRectGetWidth(self.contentViewController.view.bounds), CGRectGetHeight(self.contentViewController.view.bounds));
    } completion:^(BOOL finished) {
        
    }];
}

- (void)showContent
{
    [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.contentViewController.view.center = CGPointMake(CGRectGetWidth(self.view.bounds) + 20, self.view.center.y);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)setMenuEnable:(BOOL)menuEnable
{
    self.pan.enabled = menuEnable;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
