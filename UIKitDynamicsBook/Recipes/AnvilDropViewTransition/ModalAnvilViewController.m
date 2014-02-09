//
//  ModalAnvilViewController.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 06/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "ModalAnvilViewController.h"

@implementation ModalAnvilViewController
{
    UIButton *dismissButton;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = [UIColor darkGrayColor];
    //self.view.alpha = 0.7;
    
    // Create a button to act as the menu toggle
    dismissButton = [UIButton buttonWithType:UIButtonTypeSystem];
    dismissButton.frame = CGRectMake(0, 0, 200, 50);
    dismissButton.center = CGPointMake(160, 90);
    
    // When pressed, we will toggle the menu
    [dismissButton setTitle:@"Dismiss view controller" forState:UIControlStateNormal];
    [dismissButton addTarget:self action:@selector(dismissController:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:dismissButton];
}

- (void)dismissController:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
