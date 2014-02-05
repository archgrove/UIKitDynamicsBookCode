//
//  ShapeView.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 02/08/2013.
//  Copyright (c) 2013 Adam Wright. All rights reserved.
//

#import "ShapeView.h"

@implementation ShapeView
{
    UILabel *label;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [[UIColor blackColor] CGColor];
        self.layer.borderWidth = 1;
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        label.adjustsFontSizeToFitWidth = YES;
        label.text = @"View";
        label.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:label];
        
        self.backgroundColor = [UIColor darkGrayColor];
        self.labelColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)setLabelText:(NSString *)labelText
{
    [self willChangeValueForKey:@"labelText"];
    _labelText = labelText;
    [self didChangeValueForKey:@"labelText"];
    
    label.text = labelText;
}

- (void)setLabelColor:(UIColor*)labelColor
{
    [self willChangeValueForKey:@"labelColor"];
    _labelColor = labelColor;
    [self didChangeValueForKey:@"labelColor"];
    
    label.textColor = labelColor;
}

@end
