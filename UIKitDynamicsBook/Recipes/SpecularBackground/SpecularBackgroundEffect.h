//
//  SpecularBackgroundEffect.h
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 05/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpecularBackgroundEffect : UIMotionEffect

@property UIColor *backgroundColor;
@property UIColor *specularColor;
@property CGFloat lightNormalX;
@property CGFloat lightNormalY;

- (instancetype)initWithBackgroundColor:(UIColor*)color specularColor:(UIColor*)specColor;
- (instancetype)initWithBackgroundColor:(UIColor*)color specularColor:(UIColor*)specColor lightNormalX:(CGFloat)x lightNormalY:(CGFloat)y;

@end
