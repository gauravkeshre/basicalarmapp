//
//  GKAlarmsTVC.m
//  Alarm
//
//  Created by Gaurav Keshre on 4/15/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import "GKAlarmsTVC.h"
#import "GKAlarmsTVC+FloatingView.h"
#import "UITableView+RemoveUnwantedCellSeparator.h"
#import "GKAlarmCell.h"
@interface GKAlarmsTVC ()
{
    NSMutableArray *arrAlarms;
}
- (IBAction)handleEditButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnEdit;
- (IBAction)handleGearButton:(id)sender;

@end

@implementation GKAlarmsTVC

- (void)viewDidLoad {
    [super viewDidLoad];

    /*
     * FLoatingView
     */
    CGFloat height = [[UIScreen mainScreen]bounds].size.height;
    self.originalOrigin = height - kFLOATING_BUTTON_HEIGHT;
    [self.tableView addEmptyFooter];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    /*
     * FLoatingView
     */
    [self prepareFloatingView]; //shouldn't be put in viewDidAppear:

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *alarmListData = [defaults objectForKey:@"AlarmListData"];
    [arrAlarms removeAllObjects];
    arrAlarms = nil;
    arrAlarms = [NSKeyedUnarchiver unarchiveObjectWithData:alarmListData];
    
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:TRUE];
    [arrAlarms sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [self.tableView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrAlarms.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GKAlarmCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GKAlarmCell" forIndexPath:indexPath];
    [cell setData:arrAlarms[indexPath.row]];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Action Methods

- (IBAction)handleEditButton:(id)sender {
    BOOL isEditing = self.tableView.isEditing;
    isEditing = !isEditing;
    [self.tableView setEditing:isEditing animated:YES];
}
- (IBAction)handleGearButton:(id)sender {
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
