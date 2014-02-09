//
//  FirstAnvilViewController.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 06/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "FirstAnvilViewController.h"
#import "ModalAnvilViewController.h"
#import "AnvilTransitionVendor.h"

@implementation FirstAnvilViewController
{
    UIButton *dropViewButton;
    ModalAnvilViewController *modalController;
    AnvilTransitionVendor *transitionVendor;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Create a button to act as the menu toggle
    dropViewButton = [UIButton buttonWithType:UIButtonTypeSystem];
    dropViewButton.frame = CGRectMake(0, 0, 200, 50);
    dropViewButton.center = CGPointMake(160, 90);
    
    // When pressed, we will toggle the menu
    [dropViewButton setTitle:@"Drop view controller" forState:UIControlStateNormal];
    [dropViewButton addTarget:self action:@selector(dropModalController:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:dropViewButton];
}

- (void)dropModalController:(id)sender
{
    [self presentViewController:modalController animated:YES completion:nil];
}

- (void)viewDidLoad
{
    modalController = [[ModalAnvilViewController alloc] init];
    modalController.modalPresentationStyle = UIModalPresentationCustom;
    transitionVendor = [[AnvilTransitionVendor alloc] init];
    modalController.transitioningDelegate = transitionVendor;
}


@end
