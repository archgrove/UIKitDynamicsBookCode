//
//  SpecularButtonViewController.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 05/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "SpecularButtonViewController.h"
#import "SpecularBackgroundEffect.h"

@implementation SpecularButtonViewController

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Create a button to act as the menu toggle
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeSystem];
    menuButton.frame = CGRectMake(0, 0, 200, 60);
    menuButton.center = CGPointMake(160, 200);
    
    menuButton.layer.borderColor = [menuButton titleColorForState:UIControlStateNormal].CGColor;
    menuButton.layer.borderWidth = 1.0f;
    menuButton.layer.cornerRadius = 3.0f;
    
    // When pressed, we will initiate the animation
    [menuButton setTitle:@"Specular button" forState:UIControlStateNormal];
    
    SpecularBackgroundEffect *specularBGEffect = [[SpecularBackgroundEffect alloc] initWithBackgroundColor:[UIColor whiteColor] specularColor:[UIColor darkGrayColor]];
    [menuButton addMotionEffect:specularBGEffect];
    
    [self.view addSubview:menuButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Specular button";
}

@end
