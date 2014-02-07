//
//  ViewBounceInViewController.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 05/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "ViewBounceInViewController.h"

@implementation ViewBounceInViewController
{
    UIButton *menuButton;
    UIButton *popinButton1;
    UIButton *popinButton2;
    
    UIDynamicAnimator *dynamicAnimator;
    
    BOOL isShowing;
}

// You can just as easily use a NIB to setup your views
- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Create a button to act as the menu toggle
    menuButton = [UIButton buttonWithType:UIButtonTypeSystem];
    menuButton.frame = CGRectMake(0, 0, 100, 30);
    menuButton.center = CGPointMake(60, 90);
    
    // Give it a standard coloured border, and a solid white background
    // In this way, the views that will "bounce in" will appear to slide out from under it
    menuButton.layer.borderColor = [menuButton titleColorForState:UIControlStateNormal].CGColor;
    menuButton.layer.borderWidth = 1.0f;
    menuButton.layer.cornerRadius = 3.0f;
    menuButton.backgroundColor = [UIColor whiteColor];

    // When pressed, we will initiate the animation
    [menuButton setTitle:@"Toggle menu" forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(toggleViews:) forControlEvents:UIControlEventTouchUpInside];
    
    isShowing = NO;
    
    // Create two more buttons that will bounce in
    popinButton1 = [UIButton buttonWithType:UIButtonTypeSystem];
    popinButton1.frame = CGRectMake(0, 0, 100, 30);
    popinButton1.center = CGPointMake(60, 90);
    [popinButton1 setTitle:@"Button 1" forState:UIControlStateNormal];
    [popinButton1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    popinButton2 = [UIButton buttonWithType:UIButtonTypeSystem];
    popinButton2.frame = CGRectMake(0, 0, 100, 30);
    popinButton2.center = CGPointMake(60, 90);
    [popinButton2 setTitle:@"Button 2" forState:UIControlStateNormal];
    [popinButton2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    // Add all the views to the subview
    [self.view addSubview:popinButton1];
    [self.view addSubview:popinButton2];
    [self.view addSubview:menuButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Bounce-in menu";
    dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
}

- (void)toggleViews:(id)sender
{
    const CGPoint homeLocation = menuButton.center;
    const CGPoint button1ExpandedLocation = CGPointMake(150, 90);
    const CGPoint button2ExpandedLocation = CGPointMake(220, 90);
    const CGFloat damping = 0.75;
    
    [dynamicAnimator removeAllBehaviors];
    
    UISnapBehavior *snapForButton1;
    UISnapBehavior *snapForButton2;
    
    if (isShowing)
    {
        snapForButton1 = [[UISnapBehavior alloc] initWithItem:popinButton1 snapToPoint:homeLocation];
        snapForButton2 = [[UISnapBehavior alloc] initWithItem:popinButton2 snapToPoint:homeLocation];
    }
    else
    {
        snapForButton1 = [[UISnapBehavior alloc] initWithItem:popinButton1 snapToPoint:button1ExpandedLocation];
        snapForButton2 = [[UISnapBehavior alloc] initWithItem:popinButton2 snapToPoint:button2ExpandedLocation];
    }
    
    snapForButton1.damping = damping;
    snapForButton2.damping = damping;
    
    [dynamicAnimator addBehavior:snapForButton1];
    [dynamicAnimator addBehavior:snapForButton2];
    
    isShowing = !isShowing;
}


@end
