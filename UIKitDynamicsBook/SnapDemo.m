//
//  GravityDemo.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 28/01/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "SnapDemo.h"
#import "ShapeView.h"
#import "DynamicsDemoViewController.h"

@implementation SnapDemo
{
    UISnapBehavior *snap;
    
    DynamicsDemoViewController *controller;
}

- (void)configureViewsInController:(DynamicsDemoViewController*)viewController
{
    controller = viewController;
    
    ShapeView *view = [controller shapeViewInCenterWithSize:CGSizeMake(100, 30)];
    snap = [[UISnapBehavior alloc] initWithItem:view snapToPoint:CGPointMake(160, 220)];
}

- (void)activate
{
    [controller.dynamicAnimator addBehavior:snap];
}

- (NSString*)demoTitle
{
    return @"Snap";
}

@end
