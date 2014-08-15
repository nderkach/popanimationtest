//
//  TraffleViewController.m
//  PopTestAnimation
//
//  Created by Nikolay Derkach on 29/05/14.
//  Copyright (c) 2014 Nikolay Derkach. All rights reserved.
//

#import "TraffleViewController.h"

#import <POP.h>

static float delay = 0.0f;

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
    NSLog(@"cellForRowAtIndexPath: %ld", (long)[indexPath row]);
    NSString *CellIdentifier = [NSString stringWithFormat:@"%ld", (long)[indexPath row]];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
        // Configure the cell
        cell.textLabel.text = [NSString stringWithFormat:@"test %f", delay];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        CGFloat toValue = CGRectGetMidX(self.view.bounds);
        
        POPSpringAnimation *onscreenAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
        onscreenAnimation.fromValue = @(-toValue);
        onscreenAnimation.toValue = @(toValue);
        onscreenAnimation.springBounciness = 5.0f;
        onscreenAnimation.beginTime = (CACurrentMediaTime() + delay);
        onscreenAnimation.delegate = self;
        onscreenAnimation.name = [NSString stringWithFormat:@"%ld", (long)[indexPath row]];
        delay+=0.7f;
        
        cell.hidden = YES;
        
        [cell.layer pop_addAnimation:onscreenAnimation forKey:onscreenAnimation.name];
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Displaying row: %ld", (long)[indexPath row]);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"numberOfSectionsInTableView");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"numberOfRowsInSection");
    return 3;
}

-(void)pop_animationDidStart:(POPAnimation *)anim
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow:[anim.name intValue] inSection:0]];
    cell.hidden = NO;
    NSLog(@"cell: %@ %d %d", cell.textLabel.text, [anim.name intValue], cell.hidden);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}


@end
