//
//  ViewShattererDelegate.h
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 19/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ViewShatterer;

@protocol ViewShattererDelegate <NSObject>

- (void)shatterComplete:(ViewShatterer*)shatterer;

@end
