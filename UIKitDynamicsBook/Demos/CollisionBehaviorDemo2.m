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
    UIDynamicBehavior *totalBehavior;
    
    DynamicsDemoViewController *controller;
}

- (void)configureViewsInController:(DynamicsDemoViewController*)viewController
{
    controller = viewController;

    
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] init];
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] init];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    
    totalBehavior = [[UIDynamicBehavior alloc] init];
    [totalBehavior addChildBehavior:gravityBehavior];
    [totalBehavior addChildBehavior:collisionBehavior];
    
    CGRect frames[] = {
        CGRectMake(20, 80, 100, 30),
        CGRectMake(180, 80, 70, 30),
        CGRectMake(30, 250, 60, 30),
        CGRectMake(150, 250, 100, 30)
    };
    
    for (int i = 0; i < sizeof(frames) / sizeof(CGRect); i++)
    {
        ShapeView *shapeView = [[ShapeView alloc] initWithFrame:frames[i]];
        [controller.view addSubview:shapeView];
        
        [gravityBehavior addItem:shapeView];
        [collisionBehavior addItem:shapeView];
    }
}

- (void)activate
{
    [controller.dynamicAnimator addBehavior:totalBehavior];
}

- (NSString*)demoTitle
{
    return @"Collision 2";
}

@end
