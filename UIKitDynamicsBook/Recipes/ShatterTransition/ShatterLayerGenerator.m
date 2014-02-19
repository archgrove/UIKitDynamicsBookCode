//
//  ShatterLayerGenerator.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 18/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "ShatterLayerGenerator.h"

@implementation ShatterLayerGenerator

- (instancetype)initWithBounds:(CGRect)bounds
{
    self = [super init];
    
    if (self)
    {
        self.bounds = bounds;
        
        self.rings = 5;
        self.ringSpacing = bounds.size.width / self.rings;
        self.points = 7;
        self.jitter = 0.05;
    }
    
    return self;
}

- (NSArray*)generateShatterLayersFromPoint:(CGPoint)p
{
    // Pick self.points ordered random angles around a circle
    NSArray *angles = [self generateRandomNumbersInRange:0 to:2 * M_PI partitions:self.points];
    NSMutableArray *pointSets = [NSMutableArray array];
    
    srand(time(NULL));
    
    for (NSNumber *a in angles)
    {
        // Starting at the given point p, create a sequence of points connecting it to each ring of the radii circles
        NSMutableArray *targetPoints = [NSMutableArray array];
        
        for (int i = 0; i < self.rings; i++)
        {
            int radius = i * self.ringSpacing;
            
            CGFloat jitter = self.jitter * (rand() / (float)RAND_MAX);
            if (rand () % 2) jitter *= -1;
            CGFloat angle = [a floatValue] * (1 + jitter);
            
            [targetPoints addObject:[NSValue valueWithCGPoint:CGPointMake(p.x + sin(angle) * radius, p.y + cos(angle) * radius)]];
        }
        
        // Now we need to connect it to the edge; instead, we connect it far off the edge and force CG to do our clipping for us
        // This is more resource intensive, but results in much easier code
        CGFloat angle = [a floatValue];
        [targetPoints addObject:[NSValue valueWithCGPoint:CGPointMake(p.x + sin(angle) * 2 * self.bounds.size.height,
                                                                      p.y + cos(angle) * 2 * self.bounds.size.height)]];
        
        [pointSets addObject:targetPoints];

    }
    
    // Now, for reach pair of point sequences (n, n+1 % self.points), create a connected path by walking out
    // of the first set, and into the second
    NSMutableArray *shapeLayers = [NSMutableArray array];
    for (int i = 0; i < pointSets.count; i++)
    {
        NSArray *pointsOut = pointSets[i];
        NSArray *pointsIn = pointSets[(i + 1) % pointSets.count];
        
        
        CGMutablePathRef path = CGPathCreateMutable();
        
        CGPoint startPoint = [pointsOut[0] CGPointValue];
        
        CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
        for (int j = 1; j < pointsOut.count; j++)
        {
            CGPoint lP = [pointsOut[j] CGPointValue];
            CGPathAddLineToPoint(path, NULL, lP.x, lP.y);
        }
        
        for (NSValue *v in [pointsIn reverseObjectEnumerator])
        {
            CGPoint lP = v.CGPointValue;
            CGPathAddLineToPoint(path, NULL, lP.x, lP.y);
        }
        
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.bounds = self.bounds;
        shapeLayer.fillColor = [UIColor blackColor].CGColor;
        shapeLayer.strokeColor = [UIColor clearColor].CGColor;
        shapeLayer.lineWidth = 0;
        shapeLayer.path = path;
        shapeLayer.anchorPoint = CGPointMake(0, 0);
        CGPathRelease(path);
        
        [shapeLayers addObject:shapeLayer];
    }

    return shapeLayers;
}

- (NSArray*)generateRandomNumbersInRange:(CGFloat)start to:(CGFloat)end partitions:(NSUInteger)count
{
    NSAssert(start < end, @"Range cannot be 0 or negative in length");
    
    CGFloat rangeLength = end - start;
    
    NSMutableArray *randomFactors = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++)
    {
        CGFloat randFactor = (rand() / (float)RAND_MAX);
        [randomFactors addObject:@(start + (randFactor * rangeLength))];
    }
    
    return [randomFactors sortedArrayWithOptions:NSSortStable usingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 floatValue] > [obj2 floatValue];
    }];
}

@end
