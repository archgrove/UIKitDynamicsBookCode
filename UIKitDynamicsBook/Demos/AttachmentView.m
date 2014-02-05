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
    UIDynamicBehavior *totalBehavior;
    
    DynamicsDemoViewController *controller;
}

- (void)configureViewsInController:(DynamicsDemoViewController*)viewController
{
    controller = viewController;
    
    ShapeView *view1 = [controller shapeViewInCenterWithSize:CGSizeMake(100, 30)];
    ShapeView *view2 = [controller shapeViewInCenterWithSize:CGSizeMake(100, 30)];
    
    view1.center = CGPointMake(75, 100);
    view1.backgroundColor = [UIColor blueColor];
    view1.labelText = @"Anchor";
    
    view2.center = CGPointMake(220, 100);
    
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[view1]];
    
    UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:view1 attachedToItem:view2];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[view1, view2]];
    collision.translatesReferenceBoundsIntoBoundary = YES;

    totalBehavior = [[UIDynamicBehavior alloc] init];
    
    [totalBehavior addChildBehavior:collision];
    [totalBehavior addChildBehavior:gravity];
    [totalBehavior addChildBehavior:attachment];
}

- (void)activate
{
    [controller.dynamicAnimator addBehavior:totalBehavior];
}

- (NSString*)demoTitle
{
    return @"Attachment to view";
}

@end
