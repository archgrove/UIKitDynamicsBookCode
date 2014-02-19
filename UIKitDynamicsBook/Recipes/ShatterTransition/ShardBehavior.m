//
//  ShardBehavior.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 19/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "ShardBehavior.h"

@implementation ShardBehavior
{
    UIGravityBehavior *_gravityBehavior;
    UIDynamicItemBehavior *_dynamicItem;
    ShardBehaviorCompletionCallback _callback;
    BOOL _shouldCallback;
}

- (instancetype)initWithCompletionCallback:(ShardBehaviorCompletionCallback)callback
{
    self = [super init];
    
    if (self)
    {
        _gravityBehavior = [[UIGravityBehavior alloc] init];
        _dynamicItem = [[UIDynamicItemBehavior alloc] init];
        _callback = callback;
        _shouldCallback = NO;
        
        __weak ShardBehavior *weakSelf = self;
        self.action = ^()
        {
            ShardBehavior *strongSelf = weakSelf;
            
            CGRect containerBounds = strongSelf.dynamicAnimator.referenceView.bounds;
            
            NSMutableArray *removalItems = nil;
            
            // Schedule any item outside our bounds for removal
            for (id<UIDynamicItem> item in strongSelf->_dynamicItem.items)
            {
                CGFloat itemDiagonal = sqrt(item.bounds.size.width * item.bounds.size.width + item.bounds.size.height * item.bounds.size.height);
                if (item.center.y - itemDiagonal > containerBounds.size.height)
                {
                    // We lazily create the removal schedule list
                    if (removalItems == nil)
                        removalItems = [NSMutableArray array];
                        
                    [removalItems addObject:item];
                }
            }
            
            // Removal all scheduled items
            if (removalItems.count > 0)
            {
                for (id<UIDynamicItem> item in removalItems)
                {
                    [strongSelf->_gravityBehavior removeItem:item];
                    [strongSelf->_dynamicItem removeItem:item];
                }
            }
            
            // If we're not animating anything now, call the callback once
            if (strongSelf->_dynamicItem.items.count == 0 && strongSelf->_shouldCallback)
            {
                strongSelf->_callback(strongSelf);
                strongSelf->_shouldCallback = NO;
            }
        };
        
        [self addChildBehavior:_gravityBehavior];
        [self addChildBehavior:_dynamicItem];
    }
    
    return self;
}

- (void)addItem:(id<UIDynamicItem>)item
{
    [_gravityBehavior addItem:item];
    [_dynamicItem addItem:item];
    
    [self randomShove:item];
    
    _shouldCallback = YES;
}

- (void)randomShove:(id<UIDynamicItem>)item
{
    const float angularFactor = 0.01;
    const int linearFactor = 500;
    
    int randomLinear = (rand() % linearFactor) - (linearFactor / 2);
    
    [_dynamicItem addAngularVelocity:randomLinear * angularFactor forItem:item];
    [_dynamicItem addLinearVelocity:CGPointMake(randomLinear, randomLinear) forItem:item];
    
}

@end
