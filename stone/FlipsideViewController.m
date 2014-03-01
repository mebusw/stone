//
//  FlipsideViewController.m
//  stone
//
//  Created by Jacky Shen on 14-2-23.
//  Copyright (c) 2014年 JackyShen. All rights reserved.
//

#import "FlipsideViewController.h"

@interface FlipsideViewController ()

@end

@implementation FlipsideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    UIButton *searchFilterBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [searchFilterBtn setFrame:CGRectMake(80, 220, 100, 80)];
    [searchFilterBtn addTarget:self
               action:@selector(aMethod:)
     forControlEvents:UIControlEventTouchDown];
    [searchFilterBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [self.view addSubview:searchFilterBtn];

}

-(IBAction) aMethod:(id)sender {
    DLog(@"");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
