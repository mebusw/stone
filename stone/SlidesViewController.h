//
//  SlidesViewController.h
//  stone
//
//  Created by Jacky Shen on 14-3-18.
//  Copyright (c) 2014年 JackyShen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlidesViewController : UIViewController


@property (nonatomic, strong) IBOutlet UIImageView *imageCurrent;
@property (nonatomic, strong) IBOutlet UIImageView *imageOld;
@property (nonatomic, strong) IBOutlet UIPageControl *ImagePageControl;

@property (nonatomic, strong) NSArray *images;


-(id) initWithFrame:(CGRect)frame;

@end
