//
//  DynamicsDemo.h
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 28/01/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DynamicsDemoViewController;

@interface DynamicsDemo : NSObject

- (void)configureViewsInController:(DynamicsDemoViewController*)viewController;
- (void)activate;
- (NSString*)demoTitle;

@end
