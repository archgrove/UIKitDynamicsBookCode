//
//  ViewShatterer.h
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 19/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewShattererDelegate.h"

@interface ViewShatterer : NSObject

@property (weak) id<ViewShattererDelegate> delegate;

- (instancetype)initWithView:(UIView*)sourceView containerView:(UIView*)containerView;

- (void)startAtPoint:(CGPoint)p;
- (void)cancel;

@end
