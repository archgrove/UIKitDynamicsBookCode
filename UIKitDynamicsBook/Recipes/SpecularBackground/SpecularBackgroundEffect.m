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
    // Standard linear interpolation
    return (source * (1 - factor)) + (dest * factor);
}

@implementation SpecularBackgroundEffect
{
    // Storage for the base colour components
    CGFloat bR, bG, bB, bA;
    // and for the specular components
    CGFloat sR, sG, sB, sA;
}

- (instancetype)initWithBackgroundColor:(UIColor*)color specularColor:(UIColor*)specColor
{
    return [self initWithBackgroundColor:color specularColor:specColor lightNormalX:0.25 lightNormalY:0.25];
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
        
        // To speed up the calculations, we pre-fetch the components of each colour
        [self getColourComponents:_backgroundColor r:&bR g:&bG b:&bB a:&bA];
        [self getColourComponents:_specularColor r:&sR g:&sG b:&sB a:&sA];
    }
    
    return self;
}

- (NSDictionary *)keyPathsAndRelativeValuesForViewerOffset:(UIOffset)viewerOffset
{
    // The viewer offset can be seen as Eulerian angles representing the vector of the device
    CGFloat yaw = M_PI * viewerOffset.horizontal;
    CGFloat pitch = M_PI * viewerOffset.vertical;
    CGFloat deviceVector[] = { sin(yaw) * -cos(pitch), sin(pitch), cos(yaw) * -cos(pitch) };
    
    // The "specular" angle
    yaw = M_PI * self.lightNormalX;
    pitch = M_PI * self.lightNormalY;
    CGFloat specularVector[] = { sin(yaw) * -cos(pitch), sin(pitch), cos(yaw) * -cos(pitch)  };

    // We thus approximate Phong shading to compute the specular intensisty
    CGFloat dotProduct =   specularVector[0] * deviceVector[0]
                         + specularVector[1] * deviceVector[1]
                         + specularVector[2] * deviceVector[2];
    float intensity = dotProduct * dotProduct * dotProduct;

    // We linearly interpolate the specular colour with the base colour based on the intensity
    UIColor *c = [UIColor colorWithRed:interpolate(bR, sR, intensity)
                                 green:interpolate(bG, sG, intensity)
                                  blue:interpolate(bB, sB, intensity)
                                 alpha:interpolate(bA, sA, intensity)];

    
    return @{ @"backgroundColor" : c };
}

- (void)getColourComponents:(UIColor *)col r:(CGFloat *)r g:(CGFloat *)g b:(CGFloat *)b a:(CGFloat *)a
{
    // Extract colour components from either an RGB or greyscale colour space
    
    // If we can't get them from the RGBA space
    if (![col getRed:r green:g blue:b alpha:a])
    {
        // Assume we're in a Greyscale space
        CGFloat white;
        
        [col getWhite:&white alpha:a];
        
        *r = white;
        *g = white;
        *b = white;
    }
}

@end
