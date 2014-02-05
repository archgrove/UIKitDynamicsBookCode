//
//  CollisionBehaviorDemo1.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 28/01/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "CollisionBehaviorDemo1.h"
#import "DynamicsDemoViewController.h"
#import "ShapeView.h"

@implementation CollisionBehaviorDemo1
{
    ShapeView *view;
    
    UICollisionBehavior *collision;
    UIGravityBehavior *gravity;
    DynamicsDemoViewController *controller;
}

- (void)configureViewsInController:(DynamicsDemoViewController*)viewController
{
    controller = viewController;
    
    // We will animate the standard rectangle view
    view = [viewController shapeViewInCenterWithSize:CGSizeMake(100, 30)];
    
    collision = [[UICollisionBehavior alloc] initWithItems:@[view]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    gravity = [[UIGravityBehavior alloc] initWithItems:@[view]];
    
    [collision addChildBehavior:gravity];
    
    [viewController.dynamicAnimator addBehavior:collision];
}

- (void)activate
{
    [controller.dynamicAnimator addBehavior:gravity];
}

- (NSString*)demoTitle
{
    return @"Collision 1";
}

@end
