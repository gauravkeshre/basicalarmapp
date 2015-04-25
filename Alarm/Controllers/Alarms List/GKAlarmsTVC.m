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
#import "GKAlarmObject.h"
@interface GKAlarmsTVC ()<GKAlarmCellDelegate>
{
    NSMutableArray *arrAlarms;
}
@property (weak, nonatomic) UIRefreshControl    *activityRefreshControl;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnEdit;

- (IBAction)handleGearButton:(id)sender;
- (IBAction)handleEditButton:(id)sender;
- (IBAction)handleAddButton:(id)sender;
@end

@implementation GKAlarmsTVC
@synthesize activityRefreshControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView addEmptyFooter];
    [self prepareAndAddPullToRefresh];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *alarmListData = [defaults objectForKey:kALARMSLIST];
    [arrAlarms removeAllObjects];
    arrAlarms = nil;
    arrAlarms = [NSKeyedUnarchiver unarchiveObjectWithData:alarmListData];
    
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:TRUE];
    [arrAlarms sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [self.tableView reloadData];
    [activityRefreshControl endRefreshing];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
     [activityRefreshControl endRefreshing];
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
    [cell setDelegate:self];
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //delete from notif
        UIApplication *app = [UIApplication sharedApplication];
        NSArray *eventArray = [app scheduledLocalNotifications];
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF.userInfo.notificationID = %i", [arrAlarms[indexPath.row] notificationID]];
        
        UILocalNotification *notiFToDelete = [[eventArray filteredArrayUsingPredicate:pred] firstObject];
        if (notiFToDelete) {
            [app cancelLocalNotification:notiFToDelete];
            }
        // Delete the row from the data source
        [arrAlarms removeObjectAtIndex:indexPath.row];

        //updated nsuserdefaults
        NSData *alarmListData2 = [NSKeyedArchiver archivedDataWithRootObject:arrAlarms];
        [[NSUserDefaults standardUserDefaults] setObject:alarmListData2 forKey:kALARMSLIST];

        //UI
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


#pragma mark - GKAlarmCellDelegate Methods

-(void)alarmCellDate:(GKAlarmObject *)cellData didChangeCheckMarkStateTo:(BOOL)selected{
    [arrAlarms enumerateObjectsUsingBlock:^(GKAlarmObject *obj, NSUInteger idx, BOOL *stop) {
        if (obj.notificationID == cellData.notificationID) {
            [obj setEnabled:selected];
            
            //update user defaults
            
//            [arrAlarms replaceObjectAtIndex:idx withObject:obj];
            NSData *alarmListData2 = [NSKeyedArchiver archivedDataWithRootObject:arrAlarms];
            [[NSUserDefaults standardUserDefaults] setObject:alarmListData2 forKey:kALARMSLIST];

            *stop = YES; //break
        }
    }];
}


#pragma mark - Action Methods

- (IBAction)handleEditButton:(id)sender {
    BOOL isEditing = self.tableView.isEditing;
    isEditing = !isEditing;
    [self.tableView setEditing:isEditing animated:YES];
    [activityRefreshControl endRefreshing];

    NSString *str = isEditing?@"Pull to Cancel":@"Pull to Edit";
    [activityRefreshControl setAttributedTitle:[[NSAttributedString alloc]initWithString:str]];

}

- (IBAction)handleGearButton:(id)sender {
}

- (IBAction)handleAddButton:(id)sender{
    [self performSegueWithIdentifier:@"sAddAlarm" sender:nil];
}


#pragma mark - config
-(void)prepareAndAddPullToRefresh{
    UIRefreshControl *_activityRefreshControl = [[UIRefreshControl alloc] init];
    [_activityRefreshControl setAttributedTitle:[[NSAttributedString alloc]initWithString:@"Pull to Edit"]];
    
    _activityRefreshControl.tintColor = [UIColor whiteColor];

    [_activityRefreshControl addTarget:self action:@selector(handleEditButton:) forControlEvents:UIControlEventValueChanged];
    
    // Configure refresh controller
    [self.tableView addSubview:_activityRefreshControl];
    self.activityRefreshControl = _activityRefreshControl;
    _activityRefreshControl = nil;
}
@end
