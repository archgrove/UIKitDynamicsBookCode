//
//  AnvilAnimator.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 06/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "AnvilAnimator.h"

@implementation AnvilAnimator
{
    UIDynamicAnimator *dynamicAnimator;
    UICollisionBehavior *collisionBehavior;
    UIGravityBehavior *gravityBehavior;
    
    id<UIViewControllerContextTransitioning> _transitionContext;
    
    CGPoint baselineStart;
    CGPoint baselineEnd;
    CGRect finalFrame;
}

- (instancetype)initWithMode:(AnvilAnimationMode)mode
{
    self = [super init];
    
    if (self)
    {
        _mode = mode;
        self.gravityStrength = 5;
        self.retractTime = 1;
        self.smokeTime = 2;
        self.smokePointsCount = 15;
    }
    
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    _transitionContext = transitionContext;
    
    UIView *modalView;
    if (_mode == AnvilAnimationArrival)
        modalView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    else
        modalView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    
    if (_mode == AnvilAnimationArrival)
    {
        // Place the modal controller above the screen
        modalView.frame = CGRectMake(0, -modalView.frame.size.height, modalView.frame.size.width, modalView.frame.size.height);
        [transitionContext.containerView addSubview:modalView];
        
        dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:transitionContext.containerView];
        dynamicAnimator.delegate = self;
        
        // Add a boundary at the bottom of the screen
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        baselineStart = CGPointMake(0, screenSize.height);
        baselineEnd = CGPointMake(screenSize.width, screenSize.height);
        
        collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[modalView]];
        [collisionBehavior addBoundaryWithIdentifier:@"Bottom" fromPoint:baselineStart toPoint:baselineEnd];
        collisionBehavior.collisionDelegate = self;
        
        gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[modalView]];
        gravityBehavior.gravityDirection = CGVectorMake(0, self.gravityStrength);
        
        [dynamicAnimator addBehavior:collisionBehavior];
        [dynamicAnimator addBehavior:gravityBehavior];
    }
    else
    {
        [UIView animateWithDuration:self.retractTime animations:^{
            modalView.frame = CGRectMake(0, -modalView.frame.size.height, modalView.frame.size.width, modalView.frame.size.height);
        } completion:^(BOOL finished) {
            [_transitionContext completeTransition:YES];
        }];
    }
}

- (void)animationEnded:(BOOL)transitionCompleted
{
    collisionBehavior = nil;
    gravityBehavior = nil;
    dynamicAnimator = nil;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    NSTimeInterval transitionTime;
    
    if (_mode == AnvilAnimationArrival)
    {
        const NSUInteger ScreenHeight = 480;
        
        /*
          We need to compute how long the controller will take to fall up or down the screen
        
         Acceleration is GravityStrength p/s
         The screen is ScreenHeightps
         
         Calculus says GravityStrength * t is the velocity, so
         
           x = GravityStrength/2 t^2
         
          is the time to reach x ps, thus
         
               ScreenHeight = GravityStrength / 2 t^2
          =>  sqrt(ScreenHeight * 2 / GravityStrength) = t
         
         */
        
        NSTimeInterval baseTime = sqrt(ScreenHeight * 2.0 / self.gravityStrength);
        
        // We then add some "bounce time"
        transitionTime = baseTime * 1.2;
    }
    else
    {
        transitionTime = self.retractTime;
    }
    
    return transitionTime;
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator
{
    // The animator will sometimes leave the final view controller on a fractional pixel boundary; fix that here
    UIView *modalView = [_transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    CGRect frame = modalView.frame;
    modalView.frame = CGRectMake((int)frame.origin.x, (int)frame.origin.y, frame.size.width, frame.size.height);
    
    [_transitionContext completeTransition:YES];
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    // The anvil has hit the bottom; spawn some smoke
    int pointDistance = (baselineEnd.x - baselineStart.x) / self.smokePointsCount;
    UIView *container = _transitionContext.containerView;
    
    for (int i = 0; i < self.smokePointsCount; i++)
    {
        CGPoint spawnPoint = CGPointMake(pointDistance * i, baselineStart.y);
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Smoke"]];
        imageView.center = spawnPoint;
        imageView.alpha = 0.5;
        imageView.transform = CGAffineTransformMakeRotation((rand() / (float)RAND_MAX) * M_PI);
        
        [container addSubview:imageView];
        
        [UIView animateWithDuration:self.smokeTime delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            imageView.center = CGPointMake(imageView.center.x + (rand() % 50 - 25), imageView.center.y - rand() % 100);
            imageView.alpha = 0;
            imageView.transform = CGAffineTransformMakeRotation((rand() / (float)RAND_MAX) * M_PI);
        } completion:^(BOOL finished) {
            [imageView removeFromSuperview];
        }];
    }
}

@end
