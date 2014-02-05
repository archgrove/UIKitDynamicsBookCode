//
//  SpecularBackgroundEffect.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 05/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "SpecularBackgroundEffect.h"

inline static CGFloat interpolate(CGFloat source, CGFloat dest, float factor)
{
    return (source * (1 - factor)) + (dest * factor);
}

@implementation SpecularBackgroundEffect
{
    CGFloat bR, bG, bB, bA;
    CGFloat sR, sG, sB, sA;
}

- (instancetype)initWithBackgroundColor:(UIColor*)color specularColor:(UIColor*)specColor
{
    return [self initWithBackgroundColor:color specularColor:specColor lightNormalX:0.5 lightNormalY:0.5];
}

- (instancetype)initWithBackgroundColor:(UIColor*)color specularColor:(UIColor*)specColor lightNormalX:(CGFloat)x lightNormalY:(CGFloat)y
{
    NSAssert(x >= -1 && x <= 1 && y >= -1 * y <= 1, @"Normals must be in range [-1, 1]");
    
    self = [super init];
    
    if (self)
    {
        _backgroundColor = color;
        _specularColor = specColor;
        _lightNormalX = x;
        _lightNormalY = y;
        
        // We need to extract the colours, independent of colour space
        if (![_backgroundColor getRed:&bR green:&bG blue:&bB alpha:&bA])
        {
            CGFloat white;
            
            [_backgroundColor getWhite:&white alpha:&bA];
            
            bR = white;
            bG = white;
            bB = white;
        }
        
        if (![_specularColor getRed:&sR green:&sG blue:&sB alpha:&sA])
        {
            CGFloat white;
            
            [_specularColor getWhite:&white alpha:&sA];
            
            sR = white;
            sG = white;
            sB = white;
        }
    }
    
    return self;
}

- (NSDictionary *)keyPathsAndRelativeValuesForViewerOffset:(UIOffset)viewerOffset
{
    // The viewer offset can be seen as the viewport vector of the user
    // We thus approximate Phong shading to compute the specular intensisty
    float intensity = pow((viewerOffset.horizontal * self.lightNormalX) +
                          (viewerOffset.vertical * self.lightNormalY), 2);
    
    NSLog(@"Intensity: %f", intensity);
    UIColor *c = [UIColor colorWithRed:interpolate(bR, sR, intensity)
                                 green:interpolate(bG, sG, intensity)
                                  blue:interpolate(bB, sB, intensity)
                                 alpha:interpolate(bA, sA, intensity)];

    
    return @{ @"backgroundColor" : c };
}


@end
