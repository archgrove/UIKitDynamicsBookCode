//
//  RotationLimitBehavior.h
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 12/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RotationLimitBehavior : UIDynamicBehavior

@property (readonly) NSArray *items;
@property CGFloat clockwiseLimit;
@property CGFloat anticlockwiseLimit;

- (instancetype)initWithClockwiseLimit:(CGFloat)clockwiseLimit anticlockwiseLimit:(CGFloat)anticlockwiseLimit items:(NSArray*)item;

- (void)addItem:(id<UIDynamicItem>)item;
- (void)removeItem:(id<UIDynamicItem>)item;

@end
