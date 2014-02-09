//
//  AnvilAnimator.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 06/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "AnvilAnimator.h"
#import "SmokeGenerator.h"

@implementation AnvilAnimator
{
    UIDynamicAnimator *dynamicAnimator;
    UICollisionBehavior *collisionBehavior;
    UIGravityBehavior *gravityBehavior;
    
    id<UIViewControllerContextTransitioning> _transitionContext;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.gravityStrength = 5;
        self.smokeTime = 2;
        self.smokePointsCount = 15;
    }
    
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    _transitionContext = transitionContext;
    
    [self animateAnvilArrival];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    const NSUInteger ScreenHeight = 480;
    
    /*
     We need to compute how long the controller will take to fall up or down the screen
     A little bit of integration on the normal acceleration equation gives us:
     
     ScreenHeight = GravityStrength / 2 t^2
     =>  sqrt(ScreenHeight * 2 / GravityStrength) = t
     
     */
    
    NSTimeInterval baseTime = sqrt(ScreenHeight * 2.0 / self.gravityStrength);
    
    // We then approximate some "bounce time"
    return baseTime * 1.2;
}

- (void)animationEnded:(BOOL)transitionCompleted
{
    collisionBehavior = nil;
    gravityBehavior = nil;
    dynamicAnimator = nil;
}

- (void)animateAnvilArrival
{
    UIView *modalView = [_transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
 
    // Place the modal controller above the screen
    modalView.frame = CGRectMake(0, -modalView.frame.size.height, modalView.frame.size.width, modalView.frame.size.height);
    [_transitionContext.containerView addSubview:modalView];
    
    dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:_transitionContext.containerView];
    dynamicAnimator.delegate = self;
    
    // Add a boundary at the bottom of the screen
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGPoint baselineStart = CGPointMake(0, screenSize.height + 0.5);
    CGPoint baselineEnd = CGPointMake(screenSize.width, screenSize.height + 0.5);
    
    collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[modalView]];
    [collisionBehavior addBoundaryWithIdentifier:@"Bottom" fromPoint:baselineStart toPoint:baselineEnd];
    collisionBehavior.collisionDelegate = self;
    
    gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[modalView]];
    gravityBehavior.gravityDirection = CGVectorMake(0, self.gravityStrength);
    
    [dynamicAnimator addBehavior:collisionBehavior];
    [dynamicAnimator addBehavior:gravityBehavior];
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator
{
    [_transitionContext completeTransition:YES];
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    // The anvil has hit the bottom; spawn some smoke
    [SmokeGenerator generateSmokeEffectsInView:_transitionContext.containerView
                                    startPoint:CGPointMake(0, screenSize.height)
                                      endPoint:CGPointMake(screenSize.width, screenSize.height)
                                    pointCount:self.smokePointsCount duration:self.smokeTime];
}


@end
