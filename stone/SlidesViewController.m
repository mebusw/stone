//
//  SlidesViewController.m
//  stone
//
//  Created by Jacky Shen on 14-3-18.
//  Copyright (c) 2014年 JackyShen. All rights reserved.
//

#import "SlidesViewController.h"

@interface SlidesViewController () {
    NSTimer *timer;
}

@end

#define imageTop 0
#define imageLeft 0
#define imageWidth 320
#define imageHeight 57
#define screenWidth 320
#define animateDuration 0.55

@implementation SlidesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(id) initWithFrame:(CGRect)frame {
    self = [super init];
    [self.view setFrame:frame];
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imageCurrent = [[UIImageView alloc] initWithFrame:CGRectMake(imageLeft, imageTop, imageWidth, imageHeight)];
    [self.view addSubview:self.imageCurrent];

    self.imageOld = [[UIImageView alloc] initWithFrame:CGRectMake(imageLeft, imageTop, imageWidth, imageHeight)];
    [self.view addSubview:self.imageOld];

    self.ImagePageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(150, 45, 30, 15)];
    [self.view addSubview:self.ImagePageControl];
    

    timer = [NSTimer scheduledTimerWithTimeInterval:2 target:(id)self selector:@selector(timeToSlideImage:) userInfo:nil repeats:YES];
}



-(void)viewWillAppear:(BOOL)animated {
//    [timer setFireDate:[NSDate distantPast]];
}

-(void)viewDidDisappear:(BOOL)animated {
//    [timer setFireDate:[NSDate distantFuture]];
}

-(void) timeToSlideImage:(NSTimer *)timer {
    //DLog(@"timeout");
    
    self.imageOld.image = self.imageCurrent.image;
    [self.imageOld setFrame:CGRectMake(imageLeft, imageTop, imageWidth, imageHeight)];
    self.imageOld.hidden = NO;

    NSUInteger count = self.images.count;
    NSUInteger current = self.ImagePageControl.currentPage;
    NSUInteger next = 0;
    next = (current + count - 1) % count;
    self.ImagePageControl.currentPage = next;
    
    self.imageCurrent.image = [UIImage imageNamed:_images[next]];
    [self.imageCurrent setFrame:CGRectMake(screenWidth, imageTop, imageWidth, imageHeight)];
    
    [UIView animateWithDuration:animateDuration animations:^{
        [self.imageCurrent setFrame:CGRectMake(imageLeft, imageTop, imageWidth, imageHeight)];
        [self.imageOld setFrame:CGRectMake(-screenWidth, imageTop, imageWidth, imageHeight)];
    }];


}

-(void) setImages:(NSArray *)images {
    _images = images;
    self.ImagePageControl.numberOfPages = _images.count;
    self.ImagePageControl.currentPage = 0;
    self.imageCurrent.image = [UIImage imageNamed:_images[self.ImagePageControl.currentPage]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
