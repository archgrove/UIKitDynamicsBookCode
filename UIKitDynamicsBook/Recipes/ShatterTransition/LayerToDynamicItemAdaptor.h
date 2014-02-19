//
//  LayerToDynamicItemAdaptor.h
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 19/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LayerToDynamicItemAdaptor : NSObject<UIDynamicItem>

@property CALayer *layer;

// UIDynamicItem protocol
@property (nonatomic, readonly) CGRect bounds;
@property (nonatomic) CGPoint center;
@property (nonatomic) CGAffineTransform transform;

- (instancetype)initWithLayer:(CALayer*)layer;

@end
