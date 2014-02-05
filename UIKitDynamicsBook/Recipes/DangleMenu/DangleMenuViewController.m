//
//  DangleMenuViewController.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 05/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "DangleMenuViewController.h"
#import "DangleMenuController.h"

@implementation DangleMenuViewController
{
    UIButton *menuButton;
    DangleMenuController *menuController;
}

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
    
    // When pressed, we will toggle the menu
    [menuButton setTitle:@"Toggle menu" forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(toggleMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    // We create some menu items
    NSMutableArray *menuItems = [NSMutableArray array];
    const int numberOfItems = 5;
    for (int i = 0; i < numberOfItems; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = menuButton.frame;
        [button setTitle:[NSString stringWithFormat:@"Menu item %d", i] forState:UIControlStateNormal];
        
        [menuItems addObject:button];
        [self.view addSubview:button];
    }
    
    
    [self.view addSubview:menuButton];
    
    // Now, we create the dangle menu
    menuController = [[DangleMenuController alloc] initWithReferenceView:self.view menuRootView:menuButton menuItems:menuItems];
}

- (void)toggleMenu:(id)sender
{
    [menuController toggle];
}

@end
