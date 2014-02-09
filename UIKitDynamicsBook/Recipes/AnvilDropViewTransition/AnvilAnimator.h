//
//  AnvilAnimator.h
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 06/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnvilAnimator : NSObject<UIViewControllerAnimatedTransitioning, UIDynamicAnimatorDelegate, UICollisionBehaviorDelegate>

@property NSUInteger gravityStrength;
@property NSTimeInterval smokeTime;
@property NSUInteger smokePointsCount;

@end
