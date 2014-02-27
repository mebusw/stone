//
//  StoneEditViewController.h
//  stone
//
//  Created by Jacky Shen on 14-2-24.
//  Copyright (c) 2014年 JackyShen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoneEditViewController : UITableViewController

@property (nonatomic, weak) IBOutlet UIPickerView *pickerView;

-(IBAction)doneEditing:(id)sender;
- (IBAction) addImage:(id)sender;

@end
