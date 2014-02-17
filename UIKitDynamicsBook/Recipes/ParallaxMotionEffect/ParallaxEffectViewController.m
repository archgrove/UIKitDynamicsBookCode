//
//  ParallaxEffectViewController.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 17/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "ParallaxEffectViewController.h"
#import "ParallaxMotionEffect.h"

@implementation ParallaxEffectViewController
{
    UIImageView *imageView;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // The image to be dragged is drawn entirely standard UIImageView
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    imageView.center = self.view.center;
    imageView.image = [UIImage imageNamed:@"DemoImage"];
    
    [self.view addSubview:imageView];
    
    [imageView addMotionEffect:[[ParallaxMotionEffect alloc] initWithMovementSize:20]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Parallax Motion Effect";
}

@end
