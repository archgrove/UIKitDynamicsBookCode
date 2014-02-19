//
//  ShatterViewController.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 18/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "ShatterViewController.h"

#import "ViewShatterer.h"

@implementation ShatterViewController
{
    UIView *containerView;
    
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
}

- (void)viewTapped:(UITapGestureRecognizer*)tapRecognizer
{
    [shatterer startAtPoint:[tapRecognizer locationOfTouch:0 inView:containerView]];
    [containerView removeFromSuperview];
}


@end
