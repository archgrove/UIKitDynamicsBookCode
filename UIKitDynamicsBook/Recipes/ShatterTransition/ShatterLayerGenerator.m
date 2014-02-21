//
//  ShatterLayerGenerator.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 18/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "ShatterLayerGenerator.h"

BOOL linesIntersect(CGPoint l1Start, CGPoint l1End, CGPoint l2Start, CGPoint l2End, CGPoint *result)
{
    // Cross product approach to line-segment intersections
    // See http://stackoverflow.com/questions/563198/how-do-you-detect-where-two-line-segments-intersect
    const CGFloat EPSILON = 0.0001;
    CGFloat d = (l1End.x - l1Start.x) * (l2End.y - l2Start.y) - (l1End.y - l1Start.y) * (l2End.x - l2Start.x);
    
    if (fabs(d) < EPSILON)
        return NO;
    
    CGFloat u = ((l2Start.x - l1Start.x) * (l2End.y - l2Start.y) - (l2Start.y - l1Start.y) * (l2End.x - l2Start.x)) / d;
    CGFloat v = ((l2Start.x - l1Start.x) * (l1End.y - l1Start.y) - (l2Start.y - l1Start.y) * (l1End.x - l1Start.x)) / d;
    
    if (u < 0.0 || u > 1.0)
        return NO;
    
    if (v < 0.0 || v > 1.0)
        return NO;
    
    CGPoint intersection;
    intersection.x = l1Start.x + u * (l1End.x - l1Start.x);
    intersection.y = l1Start.y + u * (l1End.y - l1Start.y);
    
    if (fabs(intersection.x) < EPSILON)
        intersection.x = 0;
    if (fabs(intersection.y) < EPSILON)
        intersection.y = 0;
    
    *result = intersection;
    
    return YES;
}

CGPoint targetPointOrNextCorner(CGRect rect, CGPoint current, CGPoint target)
{
    // Assumes that current and target are on the rect
    CGPoint connectTo = CGPointZero;
    
    if (current.y == 0 && current.x < rect.size.width)
    {
        // Current point is on the top line
        if (target.y == 0 && target.x >= current.x)
            return target;

        connectTo = CGPointMake(rect.size.width, 0);
    }
    if (current.x == rect.size.width && current.y < rect.size.height)
    {
        // Current point is on the right line
        if (target.x == rect.size.width && target.y >= current.y)
            return target;
        
        connectTo = CGPointMake(rect.size.width, rect.size.height);
    }
    if (current.y == rect.size.height && current.x > 0)
    {
        // Bottom line
        if (target.y == rect.size.height && target.x <= current.x)
            return target;
        
        connectTo = CGPointMake(0, rect.size.height);
    }
    else if (current.x == 0 && current.y > 0)
    {
        // Left line
        if (target.x == 0 && target.y <= current.y)
            return target;
        
        connectTo = CGPointMake(0, 0);
    }

    return connectTo;
}

void addPerimeterConnectionBetweenPoints(CGRect rect, CGMutablePathRef path, CGPoint p1, CGPoint p2)
{
    // Start at p1
    CGPathAddLineToPoint(path, NULL, p1.x, p1.y);
    NSLog(@"Point %f %f", p1.x, p1.y);
    
    // Clockwise walk the four possible sides to connect the two points
    CGPoint p = targetPointOrNextCorner(rect, p1, p2);
    while (p.x != p2.x || p.y != p2.y)
    {
        CGPathAddLineToPoint(path, NULL, p.x, p.y);
        p = targetPointOrNextCorner(rect, p, p2);
    }
    
    // End at p2
    CGPathAddLineToPoint(path, NULL, p2.x, p2.y);
    NSLog(@"Point %f %f", p2.x, p2.y);
}

CGPoint lineRectIntersection(CGRect rect, CGPoint lineStart, CGPoint lineEnd)
{
    // Consider each rect segment separately
    CGPoint segments[] = {
        // Top line
        CGPointMake(0, 0), CGPointMake(rect.size.width, 0),
        // Right line
        CGPointMake(rect.size.width, 0), CGPointMake(rect.size.width, rect.size.height),
        // Bottom line
        CGPointMake(rect.size.width, rect.size.height), CGPointMake(0, rect.size.height),
        // Left line
        CGPointMake(0, rect.size.height), CGPointMake(0, 0)
    };
    
    CGPoint intersection = CGPointZero;
    
    for (int i = 0; i < sizeof(segments) / sizeof(CGPoint); i += 2)
    {
        if (linesIntersect(lineStart, lineEnd, segments[i], segments[i + 1], &intersection))
            break;
    }
    
    return intersection;
}

@implementation ShatterLayerGenerator

- (instancetype)initWithBounds:(CGRect)bounds
{
    self = [super init];
    
    if (self)
    {
        self.bounds = bounds;
        
        self.rings = 5;
        self.ringSpacing = bounds.size.width / (2 * self.rings);
        self.points = 12;
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

        CGFloat angle = [a floatValue];
        CGPoint farOutPoint = CGPointMake(p.x + sin(angle) * 5 * self.bounds.size.height,
                                         p.y + cos(angle) * 5 * self.bounds.size.height);
        
        CGPoint intersectionPoint = lineRectIntersection(self.bounds, p, farOutPoint);
        NSLog(@"Intersection point %f %f", intersectionPoint.x, intersectionPoint.y);
        [targetPoints addObject:[NSValue valueWithCGPoint:intersectionPoint]];
        
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
        [self logPoint:startPoint];
        
        CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
        for (int j = 1; j < pointsOut.count; j++)
        {
            CGPoint lP = [pointsOut[j] CGPointValue];
                    [self logPoint:lP];
            CGPathAddLineToPoint(path, NULL, lP.x, lP.y);
        }
        
        addPerimeterConnectionBetweenPoints(self.bounds, path, [pointsOut.lastObject CGPointValue], [pointsIn.lastObject CGPointValue]);
        
        for (NSValue *v in [pointsIn reverseObjectEnumerator])
        {
            
            CGPoint lP = v.CGPointValue;
                    [self logPoint:lP];
            CGPathAddLineToPoint(path, NULL, lP.x, lP.y);
        }
        
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.bounds = self.bounds;
        shapeLayer.fillColor = [UIColor blackColor].CGColor;
        shapeLayer.strokeColor = [UIColor redColor].CGColor;
        shapeLayer.lineWidth = 2;
        shapeLayer.path = path;
        shapeLayer.anchorPoint = CGPointMake(0, 0);
        CGPathRelease(path);
        
        [shapeLayers addObject:shapeLayer];
    }

    return shapeLayers;
}

- (void)logPoint:(CGPoint)p
{
    NSLog(@"Point %f %f", p.x, p.y);
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
        return [obj1 floatValue] < [obj2 floatValue];
    }];
}

@end
