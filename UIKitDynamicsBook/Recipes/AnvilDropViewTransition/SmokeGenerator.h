//
//  SmokeGenerator.h
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 07/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SmokeGenerator : NSObject

+ (void)generateSmokeEffectsInView:(UIView*)container startPoint:(CGPoint)start endPoint:(CGPoint)end pointCount:(NSUInteger)pointCount duration:(NSTimeInterval)time;

@end
