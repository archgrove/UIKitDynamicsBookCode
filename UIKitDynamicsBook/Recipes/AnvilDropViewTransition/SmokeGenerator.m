//
//  SmokeGenerator.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 07/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "SmokeGenerator.h"

@implementation SmokeGenerator

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Do not build" reason:@"Do not try to construct this class" userInfo:nil];
}

+ (void)generateSmokeEffectsInView:(UIView*)container startPoint:(CGPoint)start endPoint:(CGPoint)end pointCount:(NSUInteger)pointCount duration:(NSTimeInterval)time
{
    const int xDistribution = 50;
    const int yDistribution = 100;
    const CGPoint line = CGPointMake(end.x - start.x, end.y - start.y);
    
    for (int i = 0; i < pointCount; i++)
    {
        float pointFactor = i / ((float)pointCount - 1);
        
        CGPoint spawnPoint = CGPointMake(start.x + (pointFactor * line.x), start.y + (pointFactor * line.y));
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Smoke"]];
        imageView.center = spawnPoint;
        imageView.alpha = 0.5;
        imageView.transform = CGAffineTransformMakeRotation((rand() / (float)RAND_MAX) * M_PI);
        
        [container addSubview:imageView];
        
        [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            imageView.center = CGPointMake(imageView.center.x + (rand() % xDistribution - (xDistribution / 2)),
                                           imageView.center.y - rand() % yDistribution);
            imageView.alpha = 0;
            imageView.transform = CGAffineTransformMakeRotation((rand() / (float)RAND_MAX) * M_PI);
        } completion:^(BOOL finished) {
            [imageView removeFromSuperview];
        }];
    }
}

@end
