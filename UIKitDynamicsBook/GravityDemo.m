//
//  GravityDemo.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 28/01/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "GravityDemo.h"
#import "ShapeView.h"
#import "DynamicsDemoViewController.h"

@implementation GravityDemo
{
    ShapeView *view;
    
    UIGravityBehavior *gravity;
    DynamicsDemoViewController *controller;
}

- (void)configureViewsInController:(DynamicsDemoViewController*)viewController
{
    controller = viewController;
    
    view = [[ShapeView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    view.backgroundColor = [UIColor greenColor];
    
    [viewController moveViewToTopCentre:view withOffset:CGPointMake(0, 0)];
    [viewController.view addSubview:view];
    
    gravity = [[UIGravityBehavior alloc] initWithItems:@[view]];
}

- (void)tapped
{
    [controller.dynamicAnimator addBehavior:gravity];
}

- (NSString*)demoTitle
{
    return @"Gravity";
}

@end
