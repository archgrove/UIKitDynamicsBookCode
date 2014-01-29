//
//  MasterViewController.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 02/08/2013.
//  Copyright (c) 2013 Adam Wright. All rights reserved.
//

#import "MasterViewController.h"
#import "DynamicsDemoViewController.h"

#import "GravityDemo.h"
#import "CollisionBehaviorDemo1.h"
#import "CollisionBehaviorDemo2.h"
#import "ImpulsePush.h"
#import "ContinuousPush.h"
#import "AttachmentPoint.h"
#import "AttachmentView.h"

@interface MasterViewController () {
    NSArray *demos;
}
@end

@implementation MasterViewController

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
              [[ImpulsePush alloc] init],
              [[ContinuousPush alloc] init],
              [[AttachmentPoint alloc] init],
              [[AttachmentView alloc] init]
            ];
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
