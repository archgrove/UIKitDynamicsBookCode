//
//  ViewShatterer.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 19/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "ViewShatterer.h"

#import "ShardBehavior.h"
#import "ShatterLayerGenerator.h"
#import "LayerToDynamicItemAdaptor.h"

@implementation ViewShatterer
{
    UIView *_sourceView;
    UIView *_containerView;

    UIImage *_sourceSnapshot;
    
    UIDynamicAnimator *_dynamicAnimator;
    ShardBehavior *_shardBehavior;
    
    NSMutableArray *_shatterLayers;
}

- (instancetype)initWithView:(UIView*)sourceView containerView:(UIView*)containerView
{
    self = [super init];
    
    if (self)
    {
        _sourceSnapshot = nil;
        _sourceView = sourceView;
        _containerView = containerView;
        _delegate = nil;
    }
    
    return self;
}

- (void)startAtPoint:(CGPoint)p
{
    [self captureSourceImage];
    
    _shardBehavior = [[ShardBehavior alloc] initWithCompletionCallback:^(ShardBehavior *shardBehavior) {
        if (self.delegate)
        {
            [self.delegate shatterComplete:self];
        }
    }];
    
    _dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:_containerView];
    [_dynamicAnimator addBehavior:_shardBehavior];
        
    ShatterLayerGenerator *shatterGenerator = [[ShatterLayerGenerator alloc] initWithBounds:_sourceView.bounds];
    
    NSArray *shatterMasks = [shatterGenerator generateShatterLayersFromPoint:p];
    _shatterLayers = [NSMutableArray array];
    
    for (CALayer *mask in shatterMasks)
    {
        CALayer *newLayer = [CALayer layer];
        newLayer.contents = (id)_sourceSnapshot.CGImage;
        newLayer.bounds = _sourceView.bounds;
        newLayer.position = _sourceView.center;
        newLayer.mask = mask;
        newLayer.masksToBounds = YES;
        [_containerView.layer addSublayer:newLayer];
        
        [_shatterLayers addObject:newLayer];
        
        LayerToDynamicItemAdaptor *adaptor = [[LayerToDynamicItemAdaptor alloc] initWithLayer:newLayer];
        
        [_shardBehavior addItem:adaptor];
    }
}

- (void)cancel
{
    [_dynamicAnimator removeBehavior:_shardBehavior];
    _dynamicAnimator = nil;
    _shardBehavior = nil;
    
    [_shatterLayers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [(CALayer*)obj removeFromSuperlayer];
    }];
    
    _sourceSnapshot = nil;
    _shatterLayers = nil;
}

- (void)captureSourceImage
{
    UIGraphicsBeginImageContext(_sourceView.frame.size);
    
    [_sourceView drawViewHierarchyInRect:_sourceView.bounds afterScreenUpdates:YES];
    _sourceSnapshot = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
}

@end
