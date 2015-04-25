//
//  GKAddAlarmVC.m
//  Alarm
//
//  Created by Gaurav Keshre on 4/15/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import "GKAddAlarmTVC.h"
#import "NSDate-Utilities.h"
#import "GKAlarmObject.h"
#import "UITextField+Additions.h"
@interface GKAddAlarmTVC()<UITextFieldDelegate>
{
    NSDataDetector *_detector; // restrain from directly calling _detector
    GKAlarmObject *activeNotif;
}
@end

@implementation GKAddAlarmTVC
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.pickerView setMinimumDate:[NSDate date]]; // cannot chose dates before "now"
    [self.txtFreeText fixInsets];
    [self.txtLabel fixInsets];
    
    
}
#pragma mark - UITextFieldDelegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self detectDateAndUpdatePicker];
    return YES;
}
#pragma mark - Action Methods

- (IBAction)handleAddButton:(id)sender {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *alarmListData = [defaults objectForKey:kALARMSLIST];
    NSMutableArray *alarmList = [NSKeyedUnarchiver unarchiveObjectWithData:alarmListData];
    
    if(!alarmList)
    {
        alarmList = [[NSMutableArray alloc]init];
    }
    
    GKAlarmObject *alarmObj = [GKAlarmObject new];
    [alarmObj setDate:self.pickerView.date];
    [alarmObj setNotificationID:[self getUniqueNotificationID]];

    NSString *label =self.txtLabel.text?:@"Alarm";
    [alarmObj setLabel:label];
    [alarmObj setEnabled:YES];
    activeNotif = alarmObj;
    [self scheduleLocalNotificationWithDate:self.pickerView.date atIndex:alarmObj.notificationID];
     [alarmList addObject:alarmObj];
    NSData *alarmListData2 = [NSKeyedArchiver archivedDataWithRootObject:alarmList];
    [[NSUserDefaults standardUserDefaults] setObject:alarmListData2 forKey:kALARMSLIST];
    
    [self.navigationController popViewControllerAnimated:YES];

}
- (IBAction)handleDone:(UIButton *)sender {
    if (!self.txtFreeText.text || [self.txtFreeText.text length]<3) {
        return;
    }
    [self detectDateAndUpdatePicker];
}

#pragma mark - Convenience Methods
-(NSDataDetector *)dataDetector{
    if (!_detector) {
        NSError *error = nil;
        _detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeDate error:&error];
    }
    return _detector;
}

-(void)detectDateAndUpdatePicker{
    NSArray *matches = [[self dataDetector] matchesInString:self.txtFreeText.text options:0 range:NSMakeRange(0, [self.txtFreeText.text length])];
    for (NSTextCheckingResult *match in matches) {
        [self.pickerView setDate:match.date];
        break;
    }
    [self.txtFreeText resignFirstResponder];
    [self.txtFreeText setText:@""];
}

-(NSInteger)getUniqueNotificationID
{
    NSUserDefaults *ud        = [NSUserDefaults standardUserDefaults];
    NSArray *eventArray       = [NSKeyedUnarchiver unarchiveObjectWithData:[ud objectForKey:kALARMSLIST]];
    
    [eventArray sortedArrayUsingComparator:^NSComparisonResult(GKAlarmObject *obj1, GKAlarmObject *obj2) {
        if (obj1.notificationID < obj2.notificationID) {
            return NSOrderedAscending;
        }else if (obj1.notificationID > obj2.notificationID) {
            return NSOrderedDescending;
        }else if (obj1.notificationID == obj2.notificationID) {
            return NSOrderedSame;
        }
        return NSOrderedSame;
    }];
    
    NSInteger i = [(GKAlarmObject *)[eventArray lastObject] notificationID];
    i++;

    return i;
    
}

#pragma mark - Alarm Scheduler Methods
- (void)scheduleLocalNotificationWithDate:(NSDate *)fireDate
                                  atIndex:(NSInteger)indexOfObject {
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    if (!localNotification)
        return;
    [localNotification setFireDate:fireDate];
    [localNotification setTimeZone:[NSTimeZone defaultTimeZone]];

    // Setup alert notification
    [localNotification setAlertBody:activeNotif.label];
    [localNotification setCategory:kNOTIF_CAT_ALARM];
    [localNotification setAlertTitle:@"Alarm App"];
    [localNotification setSoundName:@"wolf_out.caf"];
    /*
     * Created the file with command
     * afconvert -f caff -d LEI16@44100 -c 1 wolf.wav wolf_out.caf
     */

    [localNotification setSoundName:@"wolf_out.caf"];
    
    //This array maps the alarms uid to the index of the alarm so that we can cancel specific local notifications
    
    NSNumber* uidToStore = @(indexOfObject);
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:uidToStore forKey:@"notificationID"];
    localNotification.userInfo = userInfo;
    
    // Schedule the notification
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    activeNotif = nil;
    
}

@end
