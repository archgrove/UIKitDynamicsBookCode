//
//  ShatterViewController.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 18/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "ShatterViewController.h"

#import "ShatterLayerGenerator.h"

#import "ViewShatterer.h"

@implementation ShatterViewController
{
    UIView *containerView;
    UIView *testView;
    
    ViewShatterer *shatterer;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *nibViews = [[UINib nibWithNibName:@"SampleView" bundle:nil] instantiateWithOwner:nil options:@{}];;

    containerView = nibViews[0];
    containerView.center = self.view.center;

    
    [self.view addSubview:containerView];

    
    
    shatterer = [[ViewShatterer alloc] initWithView:containerView containerView:self.view];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [containerView addGestureRecognizer:tapRecognizer];
    
    
    
    /*
    testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    testView.center = self.view.center;
    [self.view addSubview:testView];
    
    ShatterLayerGenerator *gen = [[ShatterLayerGenerator alloc] initWithBounds:testView.bounds];
    NSArray *layers = [gen generateShatterLayersFromPoint:CGPointMake(150, 150)];
    
    for (CALayer *layer in layers)
        [testView.layer addSublayer:layer];*/
}

- (void)viewTapped:(UITapGestureRecognizer*)tapRecognizer
{
    [shatterer startAtPoint:[tapRecognizer locationOfTouch:0 inView:containerView]];
    [containerView removeFromSuperview];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"View shattering";
}

@end
