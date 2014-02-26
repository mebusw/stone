//
//  SearchMapViewController.m
//  stone
//
//  Created by Jacky Shen on 14-2-26.
//  Copyright (c) 2014年 JackyShen. All rights reserved.
//

#import "SearchMapViewController.h"


@interface SearchMapViewController () {
    CLLocationManager* locationManager;
    NSArray *merchants;

}

@end

@implementation SearchMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"----");
    
    [self.map setShowsUserLocation:YES];
    

    
//    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = (id)self;
    self.map.delegate = (id)self;
    [locationManager startUpdatingLocation];
}


- (void)viewWillAppear:(BOOL)animated {
    self.view.frame = self.parentViewController.view.bounds;
    [self centerMap];
    merchants = [self allMerchantsOfGolf];
    [self removeAllAnnotations];
    
    [self addAnnotations];
}

/**
 * for iOS 5-
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    [self locationManager:manager didUpdateLocations:@[newLocation]];
}

/**
 * for iOS 6+
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
//    printCoordinate(@"map view", ((CLLocation*)locations[0]).coordinate);
    
}


- (void)removeAllAnnotations {
    [self.map removeAnnotations:self.map.annotations];
}

-(void) addAnnotations {
    
    for (NSDictionary *merchant in merchants) {
        
        MKPointAnnotation  *anno = [[MKPointAnnotation alloc]init];
  
        NSNumber *lat = ((NSNumber*)merchant[@"latitude"]);
        NSNumber *lng = ((NSNumber*)merchant[@"longitude"]);
        
        
//        CLLocationCoordinate2D myCoord = locationManager.location.coordinate;
        anno.coordinate = CLLocationCoordinate2DMake([lat doubleValue], [lng doubleValue]);
        
        anno.title = merchant[@"name"];
        anno.subtitle = STR(@"距离%.2f公里, 库存%d方", 35.0, 988);
        
        [self.map addAnnotation:anno];
    }
}

-(void) centerMap {
    MKCoordinateSpan theSpan;    //地图的范围 越小越精确
    theSpan.latitudeDelta = 16;
    theSpan.longitudeDelta = 16;
    
    MKCoordinateRegion theRegion;
    theRegion.center = locationManager.location.coordinate;
    
    theRegion.span = theSpan;
    [self.map setRegion:theRegion];
    [self.map setCenterCoordinate:theRegion.center animated:YES];
}



-(MKAnnotationView*) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    MKAnnotationView *aView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
    
    if(!aView){
        aView = [[MKAnnotationView alloc] initWithAnnotation:annotation  reuseIdentifier:@"Pin"];
        aView.image = [UIImage imageNamed:@"6-12AM.png"];
        
        aView.canShowCallout = YES;
        
        aView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        aView.leftCalloutAccessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"6-12AM.png"]];
    }
    aView.annotation = annotation;
    
    return aView;
}


-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    
}

-(void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    NSLog(@"====");
    UIViewController *companyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CompanyVC"];
    
    [self.navigationController pushViewController:companyVC animated:YES];
}

-(NSArray*) allMerchantsOfGolf {
    return [NSMutableArray arrayWithArray:@[
                                            @{
                                                @"id": @67,
                                                @"name": @"天津峪景山地高尔夫俱乐部",
                                                @"latitude": @40.094230,
                                                @"longitude": @117.523355,
                                                @"address": @"天津市蓟县毛家峪长寿度假村",
                                                @"phone": @"022-88826203",
                                                @"price": @"760",
                                                @"images": @[@"67.jpg"],
                                                @"description": @"球场内地形险峻，落差超过164码，18个球洞全部建在著名风景区盘山东麓的山体上。"
                                                },
                                            @{
                                                @"id": @68,
                                                @"name": @"天津杨柳青高尔夫俱乐部",
                                                @"latitude": @39.1488,
                                                @"longitude": @117.008188,
                                                @"address": @"天津市西青区杨柳青镇一经路立交桥北",
                                                @"phone": @"022-27937878",
                                                @"price": @"400",
                                                @"images": @[@"68.jpg"],
                                                @"description": @"于1999年十月正式对外营业的杨柳青高尔夫俱乐部是一个大型的国际锦标级具有三十六个球洞的高尔夫度假村。"
                                                },
                                            @{
                                                @"id": @69,
                                                @"name": @"天津天鹅湖高尔夫俱乐部",
                                                @"latitude": @39.404747,
                                                @"longitude": @117.057755,
                                                @"address": @"天津市武清开发区福源道20号",
                                                @"phone": @"022-82115588",
                                                @"price": @"600",
                                                @"images": @[@"69.jpg"],
                                                @"description": @"标准为9洞36杆，球场三面环水，梯台及果岭置于岛上，极具挑战且难度较大。"
                                                },
                                            @{
                                                @"id": @70,
                                                @"name": @"天津京基高尔夫俱乐部",
                                                @"latitude": @38.974625,
                                                @"longitude": @117.292736,
                                                @"address": @"天津市津南区八里台镇津港公路北侧",
                                                @"phone": @"022-58378111",
                                                @"price": @"400",
                                                @"images": @[@"70.jpg"],
                                                @"description": @"球场占地面积1100亩，为国际标准18洞锦标赛场地，标准杆72杆，球道总长度6961码。"
                                                }
                                            ]];
}

@end
