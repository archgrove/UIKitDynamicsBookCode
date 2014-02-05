//
//  DraggableImageViewController.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 05/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "DraggableImageViewController.h"

@implementation DraggableImageViewController
{
    UIPanGestureRecognizer *panRecognizer;
    
    UIImageView *imageView;
    
    UIDynamicAnimator *dynamicAnimator;
    UIAttachmentBehavior *attachmentBehavior;
    UISnapBehavior *snapBehavior;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view.backgroundColor = [UIColor whiteColor];
    
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

    panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [imageView addGestureRecognizer:panRecognizer];
    
    dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
}

- (void)handleGesture:(UIGestureRecognizer*)recognizer
{
    switch (panRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            // When the touch begins, we create a new attachment behavior, linking:
            // the point of the touch *within* the reference view
            CGPoint globalP = [panRecognizer locationInView:nil];
            // to the point of the touch in the image
            CGPoint center = CGPointMake(globalP.x - imageView.center.x, globalP.y - imageView.center.y);
            // Notice that as previous drag operations will probably have rotated the image, we must account for the
            // rotation when computing the offset
            CGPoint ivCentre = CGPointApplyAffineTransform(center, CGAffineTransformInvert(imageView.transform));
        
            attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:imageView offsetFromCenter:UIOffsetMake(ivCentre.x,
                                                                                                                    ivCentre.y)
                                                               attachedToAnchor:globalP];
            
            // The length of the attachment "rod" must be 0 for the image to track with the users finger
            attachmentBehavior.length = 0;
            
            
            [dynamicAnimator addBehavior:attachmentBehavior];

            break;
        }
            
        case UIGestureRecognizerStateChanged:
        {
            // When the user drags their touch, we update the anchor point of the attachment
            // The dynamic animator will then move the image towards the new point, accounting for
            // the offset of the original touch anchor-point in the image (
            CGPoint p = [panRecognizer locationInView:nil];
            
            attachmentBehavior.anchorPoint = p;

            break;
        }
        default:
            // When the behavior ends, we remove it from the image view
            [dynamicAnimator removeBehavior:attachmentBehavior];
            break;
    }
}

@end
