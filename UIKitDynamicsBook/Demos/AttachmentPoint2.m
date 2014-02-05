//
//  ImpulsePush.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 28/01/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "AttachmentPoint2.h"
#import "ShapeView.h"
#import "DynamicsDemoViewController.h"

@implementation AttachmentPoint2
{
    UIDynamicBehavior *totalBehavior;
    
    DynamicsDemoViewController *controller;
}

- (void)configureViewsInController:(DynamicsDemoViewController*)viewController
{
    controller = viewController;
    
    ShapeView *view = [controller shapeViewInCenterWithSize:CGSizeMake(100, 30)];
    view.center = CGPointMake(100, 100);
    
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[view]];
    
    UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:view attachedToAnchor:CGPointMake(160, 100)];
    attachment.length = 100;
    attachment.frequency = 0;
    
    UIDynamicItemBehavior *item = [[UIDynamicItemBehavior alloc] initWithItems:@[view]];
    item.resistance = 0.3;
    
    totalBehavior = [[UIDynamicBehavior alloc] init];
    
    [totalBehavior addChildBehavior:gravity];
    [totalBehavior addChildBehavior:attachment];
    [totalBehavior addChildBehavior:item];
}

- (void)activate
{
    [controller.dynamicAnimator addBehavior:totalBehavior];
}

- (NSString*)demoTitle
{
    return @"Attachment";
}


@end
