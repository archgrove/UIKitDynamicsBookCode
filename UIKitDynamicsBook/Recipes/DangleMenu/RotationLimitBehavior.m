//
//  RotationLimitBehavior.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 12/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "RotationLimitBehavior.h"

@implementation RotationLimitBehavior
{
    NSMutableArray *_items;
}

- (instancetype)initWithClockwiseLimit:(CGFloat)clockwiseLimit anticlockwiseLimit:(CGFloat)anticlockwiseLimit items:(NSArray*)items
{
    self = [super init];
    
    if (self)
    {
        NSLog(@"Here");
        _items = [NSMutableArray arrayWithArray:items];
        self.clockwiseLimit = clockwiseLimit;
        self.anticlockwiseLimit = anticlockwiseLimit;
        
        __weak RotationLimitBehavior *weakSelf = self;
        
        self.action = ^()
        {
            for (id<UIDynamicItem> item in weakSelf.items)
            {
                CGFloat angle = acos([item transform].a);
                
                CGFloat set = INFINITY;
                
                if (angle < anticlockwiseLimit)
                    set = anticlockwiseLimit;
                else if (angle > clockwiseLimit)
                    set = clockwiseLimit;
                
                if (set != INFINITY)
                {
                    NSLog(@"Setting");
                    CGAffineTransform current = [item transform];
                    
                    CGAffineTransform newTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(set), current.tx, current.ty);
                    [item setTransform:newTransform];
                }
            }
        };
    }
    
    return self;
}

- (void)addItem:(id<UIDynamicItem>)item
{
    [_items addObject:item];
}

- (void)removeItem:(id<UIDynamicItem>)item
{
    [_items removeObject:item];
}

@end
