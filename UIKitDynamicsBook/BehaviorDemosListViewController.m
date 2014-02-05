//
//  MasterViewController.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 02/08/2013.
//  Copyright (c) 2013 Adam Wright. All rights reserved.
//

#import "BehaviorDemosListViewController.h"
#import "DynamicsDemoViewController.h"

#import "GravityDemo.h"
#import "CollisionBehaviorDemo1.h"
#import "CollisionBehaviorDemo2.h"
#import "CollisionBehaviorDemo3.h"
#import "ImpulsePush.h"
#import "ContinuousPush.h"
#import "ContinuousPushOffCentre.h"
#import "AttachmentPoint1.h"
#import "AttachmentPoint2.h"
#import "AttachmentView.h"
#import "SnapDemo.h"

@implementation BehaviorDemosListViewController
{
    NSArray *demos;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    demos = @[
              [[GravityDemo alloc] init],
              [[CollisionBehaviorDemo1 alloc] init],
              [[CollisionBehaviorDemo2 alloc] init],
              [[CollisionBehaviorDemo3 alloc] init],
              [[ImpulsePush alloc] init],
              [[ContinuousPush alloc] init],
              [[ContinuousPushOffCentre alloc] init],
              [[AttachmentPoint1 alloc] init],
              [[AttachmentPoint2 alloc] init],
              [[AttachmentView alloc] init],
              [[SnapDemo alloc] init]
            ];
    
    self.tabBarItem.title = @"Test";
}

#pragma mark - Table View

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DynamicsDemoViewController *detailViewController = segue.destinationViewController;
    
    detailViewController.dynamicsDemo = demos[[sender tag]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return demos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.tag = indexPath.row;

    DynamicsDemo *demo = demos[indexPath.row];
    cell.textLabel.text = [demo demoTitle];
    
    return cell;
}

@end
