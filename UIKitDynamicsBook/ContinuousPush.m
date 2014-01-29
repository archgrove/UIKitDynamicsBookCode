//
//  ImpulsePush.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 28/01/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "ContinuousPush.h"
#import "ShapeView.h"
#import "DynamicsDemoViewController.h"

@implementation ContinuousPush
{
    ShapeView *view;
    
    DynamicsDemoViewController *controller;
}

- (void)configureViewsInController:(DynamicsDemoViewController*)viewController
{
    controller = viewController;
    
    view = [[ShapeView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    view.backgroundColor = [UIColor greenColor];
    
    [viewController moveViewToTopCentre:view withOffset:CGPointMake(-75, 50)];
    [viewController.view addSubview:view];
}

- (void)tapped
{
    UIDynamicItemBehavior *dynamicItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[view]];
    dynamicItemBehavior.resistance = 1;
    
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[view] mode:UIPushBehaviorModeContinuous];
    pushBehavior.pushDirection = CGVectorMake(0.5, 0.5);
    
    UIDynamicBehavior *totalBehavior = [[UIDynamicBehavior alloc] init];
    [totalBehavior addChildBehavior:pushBehavior];
    [totalBehavior addChildBehavior:dynamicItemBehavior];

    
    [controller.dynamicAnimator addBehavior:totalBehavior];
}

- (NSString*)demoTitle
{
    return @"Continuous push";
}

@end
