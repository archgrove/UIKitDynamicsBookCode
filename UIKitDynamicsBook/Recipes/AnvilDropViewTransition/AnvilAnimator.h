//
//  AnvilAnimator.h
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 06/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    AnvilAnimationArrival,
    AnvilAnimationDismissal
} AnvilAnimationMode;

@interface AnvilAnimator : NSObject<UIViewControllerAnimatedTransitioning, UIDynamicAnimatorDelegate, UICollisionBehaviorDelegate>
{
    AnvilAnimationMode _mode;
}

- (instancetype)initWithMode:(AnvilAnimationMode)mode;

@property NSUInteger gravityStrength;
@property NSTimeInterval retractTime;
@property NSTimeInterval smokeTime;

@end
