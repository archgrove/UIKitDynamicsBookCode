//
//  ParallaxMotionEffect.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 17/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "ParallaxMotionEffect.h"

@implementation ParallaxMotionEffect

- (instancetype)initWithMovementSize:(CGFloat)movement
{
    self = [super init];
    
    if (self)
    {
        // Create a motion effect for both the horizontal and vertical axes
        UIInterpolatingMotionEffect *horizontalEffect;
        UIInterpolatingMotionEffect *verticalEffect;
        
        horizontalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
                                                                           type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        horizontalEffect.maximumRelativeValue = @(movement);
        horizontalEffect.minimumRelativeValue = @(-movement);
        
        verticalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
                                                                           type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        verticalEffect.maximumRelativeValue = @(movement);
        verticalEffect.minimumRelativeValue = @(-movement);
        
        // Set the group array to the two effects we created
        self.motionEffects = @[horizontalEffect, verticalEffect];
    }
    
    return self;
}

@end
