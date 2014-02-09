//
//  SlideUpAnimator.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 07/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "SlideUpAnimator.h"

@implementation SlideUpAnimator

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.retractTime = 1;
    }
    
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *modalView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    
    [UIView animateWithDuration:self.retractTime animations:^{
        modalView.frame = CGRectMake(0, -modalView.frame.size.height, modalView.frame.size.width, modalView.frame.size.height);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.retractTime;
}


@end
