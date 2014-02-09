//
//  AnvilTransitionVendor.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 06/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "AnvilTransitionVendor.h"
#import "SlideUpAnimator.h"
#import "AnvilAnimator.h"

@implementation AnvilTransitionVendor

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[SlideUpAnimator alloc] init];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[AnvilAnimator alloc] init];
}

@end
