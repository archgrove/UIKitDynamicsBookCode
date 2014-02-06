//
//  ImageWellView.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 06/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "ImageWellView.h"

static const int ShadowBorder = 2;

@implementation ImageWellView
{
    CALayer *shadowLayer;
    UIImageView *backingImageView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
 
    if (self)
    {
        backingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.parallex = 20;
        
        UIInterpolatingMotionEffect *horizontalParallex = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        UIInterpolatingMotionEffect *verticalParallex = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        
        horizontalParallex.minimumRelativeValue = @(-self.parallex);
        horizontalParallex.maximumRelativeValue = @(self.parallex);
        verticalParallex.minimumRelativeValue = @(-self.parallex);
        verticalParallex.maximumRelativeValue = @(self.parallex);
        
        [backingImageView addMotionEffect:horizontalParallex];
        [backingImageView addMotionEffect:verticalParallex];
        
        shadowLayer = [[CALayer alloc] init];
        shadowLayer.frame = CGRectMake(-ShadowBorder, -ShadowBorder, frame.size.width + ShadowBorder, frame.size.height + ShadowBorder);
        [shadowLayer setMasksToBounds:YES];
        [shadowLayer setCornerRadius:0];
        [shadowLayer setBorderColor:[[UIColor whiteColor] CGColor]];
        [shadowLayer setBorderWidth:2.0f];
        
        [shadowLayer setShadowOffset:CGSizeMake(0, 0)];
        [shadowLayer setShadowOpacity:1];
        [shadowLayer setShadowRadius:10.0];

        self.clipsToBounds = YES;
        [self addSubview:backingImageView];
        [self.layer addSublayer:shadowLayer];
        
    }
    
    return self;
}

- (void)setImage:(UIImage *)image
{
    backingImageView.image = image;
}

- (void)setParallex:(NSInteger)parallex
{
    _parallex = parallex;
    backingImageView.bounds = CGRectMake(-_parallex, -_parallex, self.frame.size.width + _parallex, self.frame.size.height + _parallex);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    shadowLayer.frame = CGRectMake(-ShadowBorder, -ShadowBorder, self.frame.size.width + ShadowBorder, self.frame.size.height + ShadowBorder);
}

@end
