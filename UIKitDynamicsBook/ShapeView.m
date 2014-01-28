//
//  ShapeView.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 02/08/2013.
//  Copyright (c) 2013 Adam Wright. All rights reserved.
//

#import "ShapeView.h"

@implementation ShapeView

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self.backgroundColor setFill];
    CGContextFillRect(ctx, rect);
    
    [[UIColor darkGrayColor] setStroke];
    CGContextSetLineWidth(ctx, 2);
    CGContextStrokeRect(ctx, rect);
}

@end
