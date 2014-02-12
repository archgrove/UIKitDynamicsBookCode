//
//  DangleMenuController.h
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 05/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DangleMenuController : NSObject
{
    NSMutableArray *_items;
    
    UIDynamicAnimator *_dynamicAnimator;
    UIGravityBehavior *_gravityBehavior;
    NSMutableArray *_itemBehaviors;
}

@property (readonly) UIView *referenceView;
@property (readonly) UIView *menuRootView;
@property (readonly) NSArray *menuItems;
@property (readonly) BOOL isExpanded;
@property CGFloat minimumVerticalSeparation;
@property NSUInteger jitter;

- (instancetype)initWithReferenceView:(UIView*)refView menuRootView:(UIView*)menuRoot menuItems:(NSArray*)menuItems;

- (void)addMenuItem:(UIView*)item;
- (void)removeMenuItem:(UIView*)item;

- (void)toggle;
- (void)expand;
- (void)collapse;

@end
