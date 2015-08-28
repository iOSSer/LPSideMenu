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

@property (nonatomic, assign) CGPoint beginPoint;



@end

@implementation LPSideMenu
{
    CGFloat distance;
}

//static CGFloat const fullDistanceValue = 0.78;
//static CGFloat const proportionValue = 0.77;

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
        self.scrollOffset = 0.4;
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
        contentView.layer.shadowOpacity = 0.5;
        contentView.layer.shadowRadius = 4;
        [self.view addSubview:contentView];
    }
    
    if (self.leftViewController) {
        [self addChildViewController:self.leftViewController];
        UIView *leftView = self.leftViewController.view;
        leftView.frame = self.view.bounds;
        [self.view addSubview:leftView];
        [self.view sendSubviewToBack:leftView];
    }
    
//    distance = 0;
    self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:self.pan];
}

- (void) panAction:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan locationInView:self.view];
    CGFloat viewLeft = [pan translationInView:self.view].x;
//    NSLog(@"%f %f", point.x, viewLeft);
//    CGFloat trueDistance = distance + viewLeft;
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            self.beginPoint = point;
            break;
        case UIGestureRecognizerStateChanged:
        {
            UIView *contentView = self.contentViewController.view;
            
            self.contentViewController.view.frame = CGRectMake(self.beginPoint.x + viewLeft, 0, CGRectGetWidth(contentView.bounds), CGRectGetHeight(contentView.bounds));
//            NSLog(@"pointx %f x %f", point.x, viewLeft);
            
//            NSLog(@"%@", NSStringFromCGRect(self.contentViewController.view.frame));
//            NSLog(@"%f", [self getOffsetValue]);
        }
            break;
        
        case UIGestureRecognizerStateEnded:
        {
            CGFloat leftValue = 1 - [self getOffsetValue];
            
            
            CGFloat contentLeft = self.contentViewController.view.frame.origin.x;
            if (contentLeft < CGRectGetWidth(self.view.bounds) / 3.5) {
                [self showLeft:NO];
            }else
            {
                CGFloat contentLeft = CGRectGetWidth(self.view.bounds) *  (1 - [self getOffsetValue]);
                [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self.contentViewController.view.frame = CGRectMake(contentLeft, 0, CGRectGetWidth(self.contentViewController.view.bounds), CGRectGetHeight(self.contentViewController.view.bounds));
                } completion:^(BOOL finished) {
                    
                }];
            }
        }
            break;
        default:
            break;
    }
}

- (void)showLeft:(BOOL)show
{
    if (!show) {
        
        [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.contentViewController.view.frame = self.view.bounds;
        } completion:^(BOOL finished) {
            
        }];
        return;
    }
}

//- (void)showLeft
//{
//    NSLog(@"%f", CGRectGetWidth(self.view.bounds) / 3);
//    if (self.contentViewController.view.frame.origin.x < CGRectGetWidth(self.view.bounds) / 3) {
//        [UIView animateWithDuration:0.375 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//            self.contentViewController.view.center = self.view.center;
//        } completion:^(BOOL finished) {
//
//        }];
//    }
//}

- (void)showRight
{
    
}
- (void)showContent
{
    [UIView animateWithDuration:0.375 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.contentViewController.view.center = CGPointMake(CGRectGetWidth(self.view.bounds) + 20, self.view.center.y);
    } completion:^(BOOL finished) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
