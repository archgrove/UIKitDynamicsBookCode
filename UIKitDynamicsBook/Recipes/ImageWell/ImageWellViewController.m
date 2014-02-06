//
//  ImageWellViewController.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 06/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "ImageWellViewController.h"
#import "ImageWellView.h"

@implementation ImageWellViewController

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view.backgroundColor = [UIColor whiteColor];
    
    ImageWellView *imageWellView = [[ImageWellView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    imageWellView.center = self.view.center;
    imageWellView.image = [UIImage imageNamed:@"DemoImage"];
    
    [self.view addSubview:imageWellView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Image well";
}
@end
