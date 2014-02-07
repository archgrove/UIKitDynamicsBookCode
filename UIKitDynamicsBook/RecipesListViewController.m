//
//  RecipesListViewController.m
//  UIKitDynamicsBook
//
//  Created by Adam Wright on 05/02/2014.
//  Copyright (c) 2014 Adam Wright. All rights reserved.
//

#import "RecipesListViewController.h"

// The recipe classes
#import "Recipes/BounceIn/ViewBounceInViewController.h"
#import "Recipes/DraggableImage/DraggableImageViewController.h"
#import "Recipes/DFSImage/DFSImageViewController.h"
#import "Recipes/DangleMenu/DangleMenuViewController.h"
#import "Recipes/AnvilDropViewTransition/FirstAnvilViewController.h"
#import "Recipes/ImageWell/ImageWellViewController.h"
#import "Recipes/SpecularBackground/SpecularButtonViewController.h"

@implementation RecipesListViewController
{
    NSArray *recipes;
    NSArray *recipeTitles;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    recipes = @[
                 [ViewBounceInViewController class],
                 [DraggableImageViewController class],
                 [DFSImageViewController class],
                 [DangleMenuViewController class],
                 [FirstAnvilViewController class],
                 [ImageWellViewController class],
                 [SpecularButtonViewController class],
               ];
    recipeTitles = @[
                     @"Bounce-in menu",
                     @"Draggable image",
                     @"DFS image",
                     @"Dangle menu",
                     @"Anvil transition",
                     @"Image well",
                     @"Specular background"
                    ];
    
    NSAssert(recipes.count == recipeTitles.count, @"Must have the number of recipes as titles");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return recipes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = recipeTitles[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class targetClass = recipes[indexPath.row];
    
    id targetController = [[targetClass alloc] init];
    [targetController setHidesBottomBarWhenPushed:YES];
    
    [self.navigationController pushViewController:targetController animated:YES];
}

@end
