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

static CGFloat const fullDistanceValue = 0.78;
static CGFloat const proportionValue = 0.77;

- (instancetype)initWithContentViewController:(UIViewController *)contentViewController leftViewController:(UIViewController *)leftViewController
{
    
    self = [super init];
    if (self) {
        _contentViewController = contentViewController;
        _leftViewController = leftViewController;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    if (self.contentViewController) {
        [self addChildViewController:self.contentViewController];
        UIView *contentView = self.contentViewController.view;
//        contentView.layer.shadowColor = [UIColor grayColor].CGColor;
//        contentView.layer.shadowOffset = CGSizeMake(- 4, 3);
//        contentView.layer.shadowOpacity = 0.5;
//        contentView.layer.shadowRadius = 4;
        [self.view addSubview:contentView];
    }
    
    distance = 0;
    self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:self.pan];
}

- (void) panAction:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan locationInView:self.view];
    CGFloat viewLeft = [pan translationInView:self.view].x;
    CGFloat trueDistance = distance + viewLeft;
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            self.beginPoint = point;
            break;
        case UIGestureRecognizerStateChanged:
        {
            
            
            CGFloat proportion = pan.view.frame.origin.x >= 0 ? -1 : 1;
            proportion *= trueDistance / CGRectGetWidth(self.view.bounds);
            proportion *= 1 - proportionValue;
            proportion /= 0.6;
            proportion += 1;
            
            self.contentViewController.view.center = CGPointMake(viewLeft + self.beginPoint.x, self.view.center.y);
//            self.contentViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion);
//            CGFloat offsetX = point.x - self.beginPoint.x;
//            
//            UIView *contentView = self.contentViewController.view;
//            contentView.frame = CGRectMake(CGRectGetMidX(contentView.frame) + offsetX , 0, CGRectGetWidth(contentView.bounds), CGRectGetHeight(contentView.bounds));
//            CGFloat x = CGRectGetWidth(self.view.bounds) - point.x;
//            NSLog(@"x %f", x);
        }
            break;
        
        case UIGestureRecognizerStateEnded:
        {
            NSLog(@"end");
            NSLog(@"tx %f ", self.contentViewController.view.frame.origin.x);
            if (trueDistance > CGRectGetWidth(self.view.bounds) * (proportionValue / 3)) {
                [self showLeft];
            }else
            {
                [self showContent];
            }
//            else if (trueDistance < CGRectGetWidth(self.view.bounds) * -(proportionValue / 3)) {
//                [self showRight];
//            } else {
//                [self showContent];
//            }
//
//            if (point.x < CGRectGetWidth(self.view.bounds) / 3) {
//                [UIView animateWithDuration:0.375 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//                    self.contentViewController.view.center = self.view.center;
//                } completion:^(BOOL finished) {
//                    
//                }];
//            }else
//            {
//                [UIView animateWithDuration:0.375 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//                    self.contentViewController.view.center = CGPointMake(CGRectGetWidth(self.view.bounds) / 4 + CGRectGetWidth(self.view.bounds), self.view.center.y);
//                } completion:^(BOOL finished) {
//                    
//                }];
//            }
            
        }
            break;
        default:
            break;
    }
}

- (void)showLeft
{
    NSLog(@"%f", CGRectGetWidth(self.view.bounds) / 3);
    if (self.contentViewController.view.frame.origin.x < CGRectGetWidth(self.view.bounds) / 3) {
        [UIView animateWithDuration:0.375 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.contentViewController.view.center = self.view.center;
        } completion:^(BOOL finished) {

        }];
    }
}

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
