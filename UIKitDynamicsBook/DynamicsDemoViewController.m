//
//  DetailViewController.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 02/08/2013.
//  Copyright (c) 2013 Adam Wright. All rights reserved.
//

#import "DynamicsDemoViewController.h"
#import "DynamicsDemo.h"

@implementation DynamicsDemoViewController
{
    UITapGestureRecognizer *tapRecognizer;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    if (self.dynamicsDemo)
    {
        [self.dynamicsDemo configureViewsInController:self];
        self.navigationItem.title = self.dynamicsDemo.demoTitle;
    }
    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)setDynamicsDemo:(DynamicsDemo*)demo
{
    for (int i = 0; i < self.view.subviews.count; i++)
        [self.view.subviews[0] removeFromSuperview];
    
    [self willChangeValueForKey:@"dynamicsDemo"];
    _dynamicsDemo = demo;
    [self didChangeValueForKey:@"dynamicsDemo"];
    
    [self.dynamicsDemo configureViewsInController:self];
    self.navigationItem.title = self.dynamicsDemo.demoTitle;
}

- (void)moveViewToTopCentre:(UIView*)view withOffset:(CGPoint)pt
{
    int centerX = (self.view.frame.size.width / 2);
    int centerY = 100;
    
    view.center = CGPointMake(centerX + pt.x, centerY + pt.y);
}

- (void)tapped:(UIGestureRecognizer*)recognizer
{
    [self.dynamicsDemo tapped];
}

@end
