//
//  DetailViewController.h
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 02/08/2013.
//  Copyright (c) 2013 Adam Wright. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DynamicsDemo;
@class ShapeView;

@interface DynamicsDemoViewController : UIViewController
{
}

@property (nonatomic) DynamicsDemo *dynamicsDemo;
@property (readonly) UIDynamicAnimator *dynamicAnimator;

- (ShapeView*)shapeViewInCenterWithSize:(CGSize)size;
- (void)moveViewToTopCentre:(UIView*)view withOffset:(CGPoint)pt;

@end
