//
//  CompanyMapViewController.h
//  stone
//
//  Created by Jacky Shen on 14-2-24.
//  Copyright (c) 2014年 JackyShen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface CompanyMapViewController : UIViewController

@property (nonatomic, strong) IBOutlet MKMapView *map;

-(IBAction) navigateToTheCompany:(id)sender;

@end
