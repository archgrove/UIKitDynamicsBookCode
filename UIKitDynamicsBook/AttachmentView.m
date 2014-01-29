//
//  ImpulsePush.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 28/01/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "AttachmentView.h"
#import "ShapeView.h"
#import "DynamicsDemoViewController.h"

@implementation AttachmentView
{
    UIGravityBehavior *gravity;
    UIAttachmentBehavior *attachment;
    UIDynamicItemBehavior *item;
    UICollisionBehavior *collision;
    UIDynamicBehavior *totalBehavior;
    
    DynamicsDemoViewController *controller;
}

- (void)configureViewsInController:(DynamicsDemoViewController*)viewController
{
    controller = viewController;
    
    UIView *view1 = [[ShapeView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    view1.backgroundColor = [UIColor greenColor];
    UIView *view2 = [[ShapeView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    view2.backgroundColor = [UIColor blueColor];
    
    [viewController moveViewToTopCentre:view1 withOffset:CGPointMake(100, 50)];
    [viewController.view addSubview:view1];
    [viewController moveViewToTopCentre:view2 withOffset:CGPointMake(-100, 50)];
    [viewController.view addSubview:view2];
    
    gravity = [[UIGravityBehavior alloc] initWithItems:@[view1]];
    
    attachment = [[UIAttachmentBehavior alloc] initWithItem:view1 attachedToItem:view2];
    
    collision = [[UICollisionBehavior alloc] initWithItems:@[view1, view2]];
    collision.translatesReferenceBoundsIntoBoundary = YES;

    totalBehavior = [[UIDynamicBehavior alloc] init];
    
    [totalBehavior addChildBehavior:collision];
    [totalBehavior addChildBehavior:gravity];
    [totalBehavior addChildBehavior:attachment];
}

- (void)tapped
{
    [controller.dynamicAnimator addBehavior:totalBehavior];
}

- (NSString*)demoTitle
{
    return @"Attachment to view";
}

@end
