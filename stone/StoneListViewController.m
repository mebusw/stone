//
//  StoneListViewController.m
//  stone
//
//  Created by Jacky Shen on 14-2-24.
//  Copyright (c) 2014年 JackyShen. All rights reserved.
//

#import "StoneListViewController.h"

@interface StoneListViewController ()

@end

@implementation StoneListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIButton *searchFilterBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [searchFilterBtn setFrame:CGRectMake(5, 220, 65, 30)];
    [searchFilterBtn addTarget:self
                        action:@selector(expandFilterButton:)
              forControlEvents:UIControlEventTouchDown];
    [searchFilterBtn setTitle:@"筛选品种" forState:UIControlStateNormal];
    [self.view addSubview:searchFilterBtn];
}


-(IBAction) expandFilterButton:(id)sender {
    NSArray *kindsOfStone = @[@"花岗岩", @"大理石", @"玄武岩", @"人造石"];

    for (int i = 0; i < [kindsOfStone count]; i++) {
        UIButton *kindBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [kindBtn setFrame:CGRectMake(5, 220 + (i + 1) * 30, 50, 30)];
        [kindBtn setTitle:kindsOfStone[i] forState:UIControlStateNormal];
        [kindBtn setBackgroundColor:[UIColor lightGrayColor]];
        [kindBtn addTarget:self
                            action:@selector(filterAKind:)
                  forControlEvents:UIControlEventTouchDown];
        [kindBtn setTag:i];
        
        [UIView transitionWithView:self.view
                          duration:0.8
                           options:UIViewAnimationOptionCurveEaseIn
                        animations:^{
                            [self.view addSubview:kindBtn];
                        }
                        completion:NULL];
    }
}

-(IBAction)filterAKind:(id)sender {
    DLog(@"%d", ((UIButton*)sender).tag);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
