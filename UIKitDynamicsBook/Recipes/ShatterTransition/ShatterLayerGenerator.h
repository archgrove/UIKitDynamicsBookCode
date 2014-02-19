//
//  ShatterLayerGenerator.h
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 18/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShatterLayerGenerator : NSObject

@property NSUInteger rings;
@property NSUInteger ringSpacing;
@property NSUInteger points;
@property CGFloat jitter;
@property CGRect bounds;

- (instancetype)initWithBounds:(CGRect)bounds;

- (NSArray*)generateShatterLayersFromPoint:(CGPoint)p;

@end
