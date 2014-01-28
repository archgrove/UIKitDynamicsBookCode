//
//  CollisionBehaviorDemo1.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 28/01/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "CollisionBehaviorDemo2.h"
#import "DynamicsDemoViewController.h"
#import "ShapeView.h"

@implementation CollisionBehaviorDemo2
{
    ShapeView *view;
    
    UICollisionBehavior *collision;
    UIGravityBehavior *gravity;
    DynamicsDemoViewController *controller;
}

- (void)configureViewsInController:(DynamicsDemoViewController*)viewController
{
    controller = viewController;

    
    collision = [[UICollisionBehavior alloc] init];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    gravity = [[UIGravityBehavior alloc] init];
    
    [collision addChildBehavior:gravity];
    
    [viewController.dynamicAnimator addBehavior:collision];
    
    [controller.dynamicAnimator addBehavior:gravity];
}

- (void)tapped
{
    view = [[ShapeView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    view.backgroundColor = [UIColor greenColor];
    
    int offset = (rand() % 100) - 50;
    [controller moveViewToTopCentre:view withOffset:CGPointMake(offset, 0)];
    [controller.view addSubview:view];
    
    [collision addItem:view];
    [gravity addItem:view];
}

- (NSString*)demoTitle
{
    return @"Collision 2";
}

@end
