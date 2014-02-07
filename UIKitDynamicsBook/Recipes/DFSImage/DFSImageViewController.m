//
//  DraggableImageViewController.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 05/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "DFSImageViewController.h"

const NSUInteger FlingThreshhold = 200;

@implementation DFSImageViewController
{
    UIPanGestureRecognizer *panRecognizer;
    
    UIImageView *imageView;
    
    UIDynamicAnimator *dynamicAnimator;
    UIAttachmentBehavior *attachmentBehavior;
    UISnapBehavior *snapBehavior;
    
    CGPoint lastVelocity;
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
    
    self.title = @"Draggable image";

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
            
            CGPoint globalP = [panRecognizer locationInView:nil];
            CGPoint center = CGPointMake(globalP.x - imageView.center.x, globalP.y - imageView.center.y);
            CGPoint ivCentre = CGPointApplyAffineTransform(center, CGAffineTransformInvert(imageView.transform));
        
            attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:imageView offsetFromCenter:UIOffsetMake(ivCentre.x,
                                                                                                                    ivCentre.y)
                                                               attachedToAnchor:globalP];
            
            attachmentBehavior.length = 0;

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
            
            // We must now decide if the image is "flung" off
            // We examine the magnitude of the velocity vector
            if (sqrt(lastVelocity.x * lastVelocity.x + lastVelocity.y + lastVelocity.y) > FlingThreshhold)
            {
                // This image has been flung! Attach a push behavior to the image
                UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[imageView] mode:UIPushBehaviorModeInstantaneous];
                
                // The velocities given by the pan gesture, whilst accurate, don't look good
                pushBehavior.pushDirection = CGVectorMake(lastVelocity.x / 10, lastVelocity.y / 10);
                
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
