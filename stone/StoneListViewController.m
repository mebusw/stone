//
//  StoneListViewController.m
//  stone
//
//  Created by Jacky Shen on 14-2-24.
//  Copyright (c) 2014年 JackyShen. All rights reserved.
//

#import "StoneListViewController.h"


@interface StoneListViewController () {
    
    NSInteger touchedMenuTitleIndex;
    NSInteger widthOfMenuItem;
    NSMutableArray *displayingMenuItems;
    UIView *dropdownView;
}

@end



#define SCREEN_WIDTH 320
#define MENU_ITEM_HEIGHT 30



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
    
    
    
    UIView *menuTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, MENU_ITEM_HEIGHT)];
    [menuTitleView setBackgroundColor:[UIColor lightGrayColor]];

    displayingMenuItems = [NSMutableArray array];
    
    NSArray *menuTitles = @[@"品种△", @"颜色△", @"产地△"];
    widthOfMenuItem = SCREEN_WIDTH / [menuTitles count];

    
    for (int i = 0; i < [menuTitles count]; i++) {
        UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [menuBtn setFrame:CGRectMake(widthOfMenuItem * i, 0, widthOfMenuItem, MENU_ITEM_HEIGHT)];
        [menuBtn setTitle:menuTitles[i] forState:UIControlStateNormal];
        [menuBtn setBackgroundColor:[UIColor lightGrayColor]];
        [menuBtn addTarget:self
                    action:@selector(touchMenuTitle:)
          forControlEvents:UIControlEventTouchDown];
        [menuBtn setTag:i];
        [self.view addSubview:menuBtn];
    }

    self.tableView.tableHeaderView = menuTitleView;

}



-(IBAction) touchMenuTitle:(id)sender {

    touchedMenuTitleIndex = ((UIView*)sender).tag;
    DLog(@"%d", ((UIButton*)sender).tag);
    
    [dropdownView removeFromSuperview];

    
    NSArray *kindsOfStone = @[@"花岗岩", @"大理石", @"玄武岩", @"人造石"];
    NSArray *colorOfStones = @[@"金黄", @"米黄", @"桃红", @"亮黄", @"翠绿"];
    NSArray *originsOfStones = @[@"巴西", @"西班牙", @"蒙古", @"新西兰", @"法国", @"俄罗斯", @"中国", @"越南", @"澳大利亚"];
    NSArray *menus = @[kindsOfStone, colorOfStones, originsOfStones];
    
    
    NSArray *subMenu = menus[touchedMenuTitleIndex];

    dropdownView = [[UIView alloc] initWithFrame:CGRectMake(touchedMenuTitleIndex * widthOfMenuItem, MENU_ITEM_HEIGHT, widthOfMenuItem, MENU_ITEM_HEIGHT * [subMenu count])];
    
    for (int j = 0; j < [subMenu count]; j++) {
        UIButton *menuItem = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [menuItem setFrame:CGRectMake(0, MENU_ITEM_HEIGHT * j, widthOfMenuItem, MENU_ITEM_HEIGHT)];
        [menuItem setTitle:subMenu[j] forState:UIControlStateNormal];
        [menuItem setBackgroundColor:[UIColor lightGrayColor]];
        [menuItem addTarget:self
                     action:@selector(touchMenuItem:)
           forControlEvents:UIControlEventTouchDown];
        [menuItem setTag:j];
        
        [dropdownView addSubview:menuItem];
    }
    
    [UIView transitionWithView:self.view
                      duration:0.8
                       options:UIViewAnimationOptionCurveEaseIn
                    animations:^{
                        [self.view addSubview:dropdownView];
                    }
                    completion:NULL];
    
    
}

-(IBAction) touchMenuItem:(id)sender {
    DLog(@"%d | %d", touchedMenuTitleIndex, ((UIButton*)sender).tag);
    [dropdownView removeFromSuperview];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table header delegate



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
