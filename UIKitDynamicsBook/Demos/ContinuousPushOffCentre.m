//
//  ImpulsePush.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 28/01/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "ContinuousPushOffCentre.h"
#import "ShapeView.h"
#import "DynamicsDemoViewController.h"

@implementation ContinuousPushOffCentre
{
    DynamicsDemoViewController *controller;
    
    UIDynamicBehavior *totalBehavior;
}

- (void)configureViewsInController:(DynamicsDemoViewController*)viewController
{
    controller = viewController;
    
    ShapeView *view = [controller shapeViewInCenterWithSize:CGSizeMake(100, 30)];
    view.center = CGPointMake(75, 100);
    
    UIDynamicItemBehavior *dynamicItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[view]];
    dynamicItemBehavior.resistance = 1;
    
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[view] mode:UIPushBehaviorModeContinuous];
    pushBehavior.pushDirection = CGVectorMake(0.5, 0.5);
    [pushBehavior setTargetOffsetFromCenter:UIOffsetMake(-25, -7) forItem:view];
    
    totalBehavior = [[UIDynamicBehavior alloc] init];
    [totalBehavior addChildBehavior:pushBehavior];
    [totalBehavior addChildBehavior:dynamicItemBehavior];
}

- (void)activate
{
    [controller.dynamicAnimator addBehavior:totalBehavior];
}

- (NSString*)demoTitle
{
    return @"Continuous push off centre";
}

@end
