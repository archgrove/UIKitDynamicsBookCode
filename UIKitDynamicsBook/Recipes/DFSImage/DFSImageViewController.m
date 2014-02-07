//
//  DraggableImageViewController.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 05/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "DFSImageViewController.h"

const NSUInteger FlingThreshhold = 150;

@implementation DFSImageViewController
{
    UIImageView *imageView;
    
    UIPanGestureRecognizer *panRecognizer;
    
    UIDynamicAnimator *dynamicAnimator;
    UIAttachmentBehavior *attachmentBehavior;
    UISnapBehavior *snapBehavior;
    
    CGPoint lastVelocity;
    UIOffset lastOffset;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // The image to be dragged is drawn entirely standard UIImageView
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    imageView.center = self.view.center;
    imageView.image = [UIImage imageNamed:@"DemoImage"];
    imageView.userInteractionEnabled = YES;
    
    [self.view addSubview:imageView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"DFS image";

    // We drive the dynamic animation from a pan recognizer that tracks the users finger
    panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [imageView addGestureRecognizer:panRecognizer];
    
    dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    // Configure the snap behavior, whose parameters are constant through the effect
    snapBehavior = [[UISnapBehavior alloc] initWithItem:imageView snapToPoint:imageView.center];
    // ...and attach it to the image
    [dynamicAnimator addBehavior:snapBehavior];
    
    lastVelocity = CGPointZero;
}

- (void)handleGesture:(UIGestureRecognizer*)recognizer
{
    switch (panRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            // Remove any existing behavior (which will be either the snap, or the push)
            // We do this so that the user can try to catch the flung image before it vanishes
            [dynamicAnimator removeAllBehaviors];
            
            CGPoint anchorPoint = [panRecognizer locationInView:nil];
            CGPoint locationInImage = CGPointMake(anchorPoint.x - imageView.center.x, anchorPoint.y - imageView.center.y);
            CGPoint locationInAAImage = CGPointApplyAffineTransform(locationInImage, CGAffineTransformInvert(imageView.transform));
            
            lastOffset = UIOffsetMake(locationInAAImage.x, locationInAAImage.y);
            
            attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:imageView offsetFromCenter: lastOffset
                                                           attachedToAnchor:anchorPoint];

            [dynamicAnimator addBehavior:attachmentBehavior];

            break;
        }
            
        case UIGestureRecognizerStateChanged:
        {
            CGPoint p = [panRecognizer locationInView:nil];
            
            attachmentBehavior.anchorPoint = p;
            
            // We now track the velocity of the movement at all times
            lastVelocity = [panRecognizer velocityInView:nil];

            break;
        }
        default:
            // Remove the attachment to the touch point
            [dynamicAnimator removeBehavior:attachmentBehavior];
            attachmentBehavior = nil;            
            
            // We must now decide if the image is "flung" off
            // We examine the magnitude of the velocity vector
            if (sqrt(lastVelocity.x * lastVelocity.x + lastVelocity.y + lastVelocity.y) > FlingThreshhold)
            {
                // This image has been flung! Attach a push behavior to the image
                UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[imageView] mode:UIPushBehaviorModeInstantaneous];
                
                // The velocities given by the pan gesture, whilst accurate, don't look good
                pushBehavior.pushDirection = CGVectorMake(lastVelocity.x / 25, lastVelocity.y / 25);
                [pushBehavior setTargetOffsetFromCenter:lastOffset forItem:imageView];
                
                [dynamicAnimator addBehavior:pushBehavior];
            }
            else
            {
                // Otherwise, just snap to the centre again
                [dynamicAnimator addBehavior:snapBehavior];
            }
            
            break;
    }
}

@end
