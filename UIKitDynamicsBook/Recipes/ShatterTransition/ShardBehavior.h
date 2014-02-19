//
//  ShardBehavior.h
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 19/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShardBehavior;

typedef void (^ShardBehaviorCompletionCallback)(ShardBehavior *shardBehavior);

@interface ShardBehavior : UIDynamicBehavior


- (instancetype)initWithCompletionCallback:(ShardBehaviorCompletionCallback)callback;
- (void)addItem:(id<UIDynamicItem>)item;
@end
