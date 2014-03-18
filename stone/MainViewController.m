//
//  MainViewController.m
//  stone
//
//  Created by Jacky Shen on 14-2-23.
//  Copyright (c) 2014年 JackyShen. All rights reserved.
//

#import "MainViewController.h"
#import "SlidesViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    SlidesViewController *slideVC = [[SlidesViewController alloc] initWithFrame:CGRectMake(0, 60, 320, 60)];
    [self.view addSubview:slideVC.view];
    slideVC.images = @[@"xuanwuyan.jpg", @"jixueshi.jpg", @"dalishi.jpg"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

@end
