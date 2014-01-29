//
//  ImpulsePush.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 28/01/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "AttachmentPoint.h"
#import "ShapeView.h"
#import "DynamicsDemoViewController.h"

@implementation AttachmentPoint
{
    ShapeView *view;
    
    UIGravityBehavior *gravity;
    UIAttachmentBehavior *attachment;
    UIDynamicItemBehavior *item;
    UIDynamicBehavior *totalBehavior;
    
    DynamicsDemoViewController *controller;
}

- (void)configureViewsInController:(DynamicsDemoViewController*)viewController
{
    controller = viewController;
    
    view = [[ShapeView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    view.backgroundColor = [UIColor greenColor];
    
    [viewController moveViewToTopCentre:view withOffset:CGPointMake(-100, 50)];
    [viewController.view addSubview:view];
    
    gravity = [[UIGravityBehavior alloc] initWithItems:@[view]];
    
    attachment = [[UIAttachmentBehavior alloc] initWithItem:view attachedToAnchor:CGPointMake(160, 100)];
    attachment.length = 200;
    attachment.frequency = 1;
    
    item = [[UIDynamicItemBehavior alloc] initWithItems:@[view]];
    item.resistance = 0.3;
    
    
    totalBehavior = [[UIDynamicBehavior alloc] init];
    
    [totalBehavior addChildBehavior:gravity];
    [totalBehavior addChildBehavior:attachment];
    [totalBehavior addChildBehavior:item];
}

- (void)tapped
{
    [controller.dynamicAnimator addBehavior:totalBehavior];
}

- (NSString*)demoTitle
{
    return @"Attachment to point";
}


@end
