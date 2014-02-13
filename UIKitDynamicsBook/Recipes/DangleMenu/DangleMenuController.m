//
//  DangleMenuController.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 05/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "DangleMenuController.h"

#import "RotationLimitBehavior.h"

@implementation DangleMenuController
{
    UIDynamicItemBehavior *_dynamicItemBehavior;
}

- (instancetype)initWithReferenceView:(UIView*)refView menuRootView:(UIView*)menuRoot menuItems:(NSArray*)menuItems
{
    self = [super init];
    
    if (self)
    {
        _referenceView = refView;
        _menuRootView = menuRoot;
        
        _dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:refView];
        
        _gravityBehavior = [[UIGravityBehavior alloc] init];
        [_dynamicAnimator addBehavior:_gravityBehavior];
        
        _dynamicItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[menuRoot]];
        _dynamicItemBehavior.resistance = 3;
        _dynamicItemBehavior.allowsRotation = NO;
        [_dynamicAnimator addBehavior:_dynamicItemBehavior];
        
        _items = [NSMutableArray arrayWithCapacity:menuItems.count];
        _itemBehaviors = [NSMutableArray arrayWithCapacity:menuItems.count];
        
        _isExpanded = FALSE;
        _minimumVerticalSeparation = 40;
        _jitter = 5;
        
        for (UIView *view in menuItems)
            [self addMenuItem:view];
        
        // Lock the root menu where it is
        UIAttachmentBehavior *menuAttachment = [[UIAttachmentBehavior alloc] initWithItem:_menuRootView attachedToAnchor:_menuRootView.center];
        [_dynamicAnimator addBehavior:menuAttachment];
    }
    
    return self;
}

- (NSArray*)menuItems
{
    return _items;
}

- (void)addMenuItem:(UIView*)item
{
    NSAssert(![_items containsObject:item], @"Cannot add a menu item that's already added");
    
    [_gravityBehavior addItem:item];
    [_dynamicItemBehavior addItem:item];
    
    if (_isExpanded)
    {
        UIView *previous = (_items.count == 0) ? _menuRootView : _items.lastObject;
        UIAttachmentBehavior *attachmentToPrevious = [[UIAttachmentBehavior alloc] initWithItem:item attachedToItem:previous];
        
        [_dynamicAnimator addBehavior:attachmentToPrevious];
        [_itemBehaviors addObject:attachmentToPrevious];
    }
    else
    {
        UISnapBehavior *snapToRoot = [[UISnapBehavior alloc] initWithItem:item snapToPoint:_menuRootView.center];
        
        [_dynamicAnimator addBehavior:snapToRoot];
        [_itemBehaviors addObject:snapToRoot];
    }
    
    [_items addObject:item];
}

- (void)removeMenuItem:(UIView*)item
{
    NSAssert([_items containsObject:item], @"Cannot remove menu item that's not added");
    
    NSUInteger indexOfItem = [_items indexOfObject:item];
    
    id itemBehavior = _itemBehaviors[indexOfItem];
    
    [_dynamicAnimator removeBehavior:itemBehavior];
    [_gravityBehavior removeItem:item];
    [_dynamicItemBehavior removeItem:item];
    
    [_items removeObjectAtIndex:indexOfItem];
    [_itemBehaviors removeObjectAtIndex:indexOfItem];
}

- (void)toggle
{
    if (_isExpanded)
        [self collapse];
    else
        [self expand];
}

- (void)expand
{
    if (_isExpanded)
        return;
    
    // We're collasped; that means there's no gravity and a snap for each item to the root
    
    // Restore gravity
    [_dynamicAnimator addBehavior:_gravityBehavior];
    
    // Remove all the snap behaviors
    for (UISnapBehavior *snapBehavior in _itemBehaviors)
        [_dynamicAnimator removeBehavior:snapBehavior];
    [_itemBehaviors removeAllObjects];
    
    // Add attachment behaviors
    for (int i = 0; i < _items.count; i++)
    {
        // We either attach to the root menu, or the previous view in the chain
        UIView *previous = (i == 0) ? _menuRootView : _items[i - 1];
        
        // The attachment if offset from the centre by a random amount up to the jitter factor
        int jitter = (rand() % (self.jitter * 2)) - self.jitter;
        
        UIAttachmentBehavior *attachmentToPrevious = [[UIAttachmentBehavior alloc] initWithItem:_items[i] offsetFromCenter:UIOffsetMake(0, 0) attachedToItem:previous offsetFromCenter:UIOffsetMake(jitter, 0)];
        attachmentToPrevious.length = self.minimumVerticalSeparation;

        [_dynamicAnimator addBehavior:attachmentToPrevious];
        [_itemBehaviors addObject:attachmentToPrevious];
    }
    
    _isExpanded = YES;
}

- (void)collapse
{
    if (!_isExpanded)
        return;
    
    // We're expanded; that means there's currently gravity and attachments between each item.
    
    // Remove gravity
    [_dynamicAnimator removeBehavior:_gravityBehavior];
    
    // Remove all the attachments
    for (UIAttachmentBehavior *attachmentBehavior in _itemBehaviors)
        [_dynamicAnimator removeBehavior:attachmentBehavior];
    [_itemBehaviors removeAllObjects];
    
    // Add snap behaviors
    for (UIView *item in _items)
    {
        UISnapBehavior *snapToRoot = [[UISnapBehavior alloc] initWithItem:item snapToPoint:_menuRootView.center];
        
        [_dynamicAnimator addBehavior:snapToRoot];
        [_itemBehaviors addObject:snapToRoot];
    }
    
        _isExpanded = NO;
}

@end
