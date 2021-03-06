//
//  DetailViewController.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 02/08/2013.
//  Copyright (c) 2013 Adam Wright. All rights reserved.
//

#import "DynamicsDemoViewController.h"
#import "DynamicsDemo.h"
#import "GridView.h"
#import "ShapeView.h"

@implementation DynamicsDemoViewController
{
    UITapGestureRecognizer *tapRecognizer;
    GridView *gridView;
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
    
    gridView = [[GridView alloc] initWithFrame:self.view.frame];
    
    [self.view addSubview:gridView];
    
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self performSelector:@selector(tapped:) withObject:self afterDelay:1];
}

- (void)setDynamicsDemo:(DynamicsDemo*)demo
{
    for (int i = 0; i < self.view.subviews.count; i++)
        [self.view.subviews[0] removeFromSuperview];
    
    _dynamicsDemo = demo;
    
    [self.dynamicsDemo configureViewsInController:self];
    self.navigationItem.title = self.dynamicsDemo.demoTitle;
}

- (ShapeView*)shapeViewInCenterWithSize:(CGSize)size
{
    ShapeView *view = [[ShapeView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    [self moveViewToTopCentre:view withOffset:CGPointMake(0, 0)];
    [self.view addSubview:view];
    
    return view;
}

- (void)moveViewToTopCentre:(UIView*)view withOffset:(CGPoint)pt
{
    int centerX = (self.view.frame.size.width / 2);
    int centerY = 100;
    
    view.center = CGPointMake(centerX + pt.x, centerY + pt.y);
}

- (void)tapped:(UIGestureRecognizer*)recognizer
{
    [self.dynamicsDemo activate];
}

@end
