//
//  LayerToDynamicItemAdaptor.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 19/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "LayerToDynamicItemAdaptor.h"

@implementation LayerToDynamicItemAdaptor

- (instancetype)initWithLayer:(CALayer*)layer
{
    self = [super init];
    
    if (self)
    {
        self.layer = layer;
    }
    
    return self;
}

- (CGRect)bounds
{
    return _layer.bounds;
}

- (CGPoint)center
{
    return _layer.position;
}

- (void)setCenter:(CGPoint)center
{
    _layer.position = center;
}

- (CGAffineTransform)transform
{
    return _layer.affineTransform;
}

- (void)setTransform:(CGAffineTransform)transform
{
    _layer.affineTransform = transform;
}

@end
