//
//  StoneEditViewController.m
//  stone
//
//  Created by Jacky Shen on 14-2-24.
//  Copyright (c) 2014年 JackyShen. All rights reserved.
//

#import "StoneEditViewController.h"

@interface StoneEditViewController () {
    UIPickerView *colorPicker;
    UIToolbar *colorPickerToolbar;
    NSArray *colorOfStones;
    NSArray *originsOfStones;
    BOOL isPickerHidden;
    UIPickerView *originPicker;
    UILabel *expandingLabel;
    UILabel *originLabel;
}

@end

@implementation StoneEditViewController

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
    
 
    [self preparePickers];
    
}

- (void)preparePickers
{
    colorOfStones = @[@"金黄",
                      @"米黄",
                      @"桃红",
                      @"亮黄",
                      @"翠绿"];
    originsOfStones = @[@"巴西", @"西班牙", @"蒙古", @"新西兰", @"法国", @"俄罗斯"];
    originPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(5, 35, 280, 216)];
    originPicker.dataSource = (id)self;
    originPicker.delegate = (id)self;
    isPickerHidden = YES;
    
    
    colorPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0f, 200.0f, 320.0f, 216.0f)];
    colorPicker.delegate = (id)self;
    colorPicker.dataSource = (id)self;
    colorPicker.showsSelectionIndicator = YES;
    colorPicker.backgroundColor = [UIColor lightGrayColor];
    
    
    colorPickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 156.0f, 320.0f, 44.0f)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissPicker:)];
    NSArray *items = [NSArray arrayWithObject:item];
    colorPickerToolbar.items = items;

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)doneEditing:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}




#pragma mark - Image

- (IBAction) addImage:(id)sender {
    UIActionSheet *photoActionSheet = [[UIActionSheet alloc]
                                    initWithTitle:nil
                                    delegate:(id)self
                                    cancelButtonTitle:@"取消"
                                    destructiveButtonTitle:nil
                                    otherButtonTitles: @"从相册选择", @"拍照",nil];
    [photoActionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            //从相册选择
            [self localPhoto];
            break;
        case 1:
            //拍照
            [self takePhoto];
            break;
        default:
            break;
    }
}

//从相册选择
-(void)localPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //资源类型为图片库
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = (id)self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:^(void){}];
}

//拍照
-(void)takePhoto{
    //资源类型为照相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = (id)self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        //资源类型为照相机
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:^(void){}];
    }else {
        NSLog(@"该设备无摄像头");
    }
}



#pragma mark - Delegate method UIImagePickerControllerDelegate

//图像选取器的委托方法，选完图片后回调该方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
    //当图片不为空时显示图片并保存图片
    if (image != nil) {
        //图片显示在界面上
        
        //以下是保存文件到沙盒路径下
        //把图片转成NSData类型的数据来保存文件
        NSData *data;
        //判断图片是不是png格式的文件
        if (UIImagePNGRepresentation(image)) {
            //返回为png图像。
            data = UIImagePNGRepresentation(image);
        }else {
            //返回为JPEG图像。
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        //保存
//        [[NSFileManager defaultManager] createFileAtPath:self.imagePath contents:data attributes:nil];
        
    }
    //关闭相册界面
    [picker dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"Cell";
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d", indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    switch (indexPath.row) {
        case 1: {
            if (!expandingLabel) {
                originLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 15, 50, 22)];
                originLabel.text = @"产地";
                originLabel.textAlignment = NSTextAlignmentRight;
                expandingLabel = [[UILabel alloc] initWithFrame:CGRectMake(270, 15, 50, 22)];
                expandingLabel.font = [UIFont systemFontOfSize:14];
                expandingLabel.textColor = [UIColor darkGrayColor];
                expandingLabel.text = @"巴西";
            }
            
                [cell addSubview:expandingLabel];
                [cell addSubview:originLabel];
                [cell addSubview:originPicker];

            break;
        }
        default:
            break;
    }
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 140;
    }

    if (indexPath.row == 1 && !isPickerHidden) {
        return 200;
    }
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 1: {
            if (isPickerHidden) {
                isPickerHidden = NO;
                expandingLabel.text = @"^";
            }
            
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case 2: {
            [UIView transitionWithView:self.view
                              duration:0.8
                               options:UIViewAnimationOptionCurveEaseIn
                            animations:^{
                                [self.view addSubview:colorPicker];
                                [self.view addSubview:colorPickerToolbar];
                            }
                            completion:NULL];
            break;
        }
        default:

            break;
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    DLog(@"deSelect %d", indexPath.row);
}



#pragma mark - Picker View Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == originPicker) {
        return [originsOfStones count];
    }
    return [colorOfStones count];
}

-(UIView *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == originPicker) {
        return [originsOfStones objectAtIndex:row];
    }
    return [colorOfStones objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    DLog(@"did select pv %d", row);
    
    
    expandingLabel.text = originsOfStones[row];
    isPickerHidden = YES;
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}

-(void) dismissPicker:(id)obj {
    
    [colorPicker removeFromSuperview];
    [colorPickerToolbar removeFromSuperview];
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
