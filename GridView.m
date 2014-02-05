//
//  GridView.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 29/01/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "GridView.h"

@implementation GridView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    const unsigned int space = 20;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 1.0f);
    
    [[UIColor colorWithRed:187/255.0f green:230/255.0f blue:251/255.0f alpha:0.33f] setStroke];
    
    for (int x = 0; x < rect.size.width; x += space)
    {
        CGContextMoveToPoint(ctx, x, 0);
        CGContextAddLineToPoint(ctx, x, rect.size.height);
        CGContextStrokePath(ctx);
    }
    
    for (int y = 0; y < rect.size.height; y += space)
    {
        CGContextMoveToPoint(ctx, 0, y);
        CGContextAddLineToPoint(ctx, rect.size.width, y);
        CGContextStrokePath(ctx);
    }
}

@end
