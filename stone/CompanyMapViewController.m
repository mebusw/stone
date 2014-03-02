//
//  CompanyMapViewController.m
//  stone
//
//  Created by Jacky Shen on 14-2-24.
//  Copyright (c) 2014年 JackyShen. All rights reserved.
//

#import "CompanyMapViewController.h"

@interface CompanyMapViewController ()

@end

@implementation CompanyMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self addAnnotation];
}

- (void)addAnnotation
{
    MKPointAnnotation  *anno = [[MKPointAnnotation alloc]init];
    anno.coordinate = CLLocationCoordinate2DMake(31.20333, 121.14250);
    anno.title = @"上海青浦石材总公司";
    anno.subtitle = STR(@"共%d个品种, 总库存%d方", 5, 1988);
    
    [self.map addAnnotation:anno];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) navigateToTheCompany:(id)sender {
    CLLocationCoordinate2D companyCoord = CLLocationCoordinate2DMake(31.20333, 121.14250);
    MKPlacemark *pm = [[MKPlacemark alloc] initWithCoordinate:companyCoord addressDictionary:nil];
    MKMapItem *there = [[MKMapItem alloc] initWithPlacemark:pm];
    there.name = @"上海青浦石材总公司";
    MKMapItem *here = [MKMapItem mapItemForCurrentLocation];
    
    [MKMapItem openMapsWithItems:@[here, there] launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving}];
}


@end
