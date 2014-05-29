//
//  TraffleViewController.m
//  PopTestAnimation
//
//  Created by Nikolay Derkach on 29/05/14.
//  Copyright (c) 2014 Nikolay Derkach. All rights reserved.
//

#import "TraffleViewController.h"

#import <POP.h>

static int delay = 0;

@interface TraffleViewController ()


@end

@implementation TraffleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell
    cell.textLabel.text = @"test";
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    CGFloat toValue = CGRectGetMidX(self.view.bounds);

    POPSpringAnimation *onscreenAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    onscreenAnimation.fromValue = @(-toValue);
    onscreenAnimation.toValue = @(toValue);
    onscreenAnimation.springBounciness = 5.f;
    onscreenAnimation.beginTime = (CACurrentMediaTime() + delay);
    delay++;

    [cell.layer pop_addAnimation:onscreenAnimation forKey:onscreenAnimation.name];

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


@end
