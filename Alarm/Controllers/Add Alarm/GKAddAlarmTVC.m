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
@interface GKAddAlarmTVC()<UITextFieldDelegate>
{
    NSDataDetector *_detector; // restrain from directly calling _detector
    
//    GKAlarmObject *alarmObj;
//    NSDate *alarmDate;
}
@end

@implementation GKAddAlarmTVC
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.pickerView setMinimumDate:[NSDate date]]; // cannot chose dates before "now"
}
#pragma mark - UITextFieldDelegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self detectDateAndUpdatePicker];
    return YES;
}
#pragma mark - Action Methods
- (IBAction)handlePickerValueChanged:(UIDatePicker *)pkr {
}

- (IBAction)handleAddButton:(id)sender {
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *alarmListData = [defaults objectForKey:@"AlarmListData"];
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
    
    [self scheduleLocalNotificationWithDate:self.pickerView.date atIndex:alarmObj.notificationID];
     [alarmList addObject:alarmObj];
    NSData *alarmListData2 = [NSKeyedArchiver archivedDataWithRootObject:alarmList];
    [[NSUserDefaults standardUserDefaults] setObject:alarmListData2 forKey:@"AlarmListData"];

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

}
-(int)getUniqueNotificationID
{
    NSMutableDictionary * hashDict = [[NSMutableDictionary alloc]init];
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *eventArray = [app scheduledLocalNotifications];
    for (int i=0; i<[eventArray count]; i++)
    {
        UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
        NSDictionary *userInfoCurrent = oneEvent.userInfo;
        NSNumber *uid= [userInfoCurrent valueForKey:@"notificationID"];
        NSNumber * value =[NSNumber numberWithInt:1];
        [hashDict setObject:value forKey:uid];
    }
    for (int i=0; i<[eventArray count]+1; i++)
    {
        NSNumber * value = [hashDict objectForKey:[NSNumber numberWithInt:i]];
        if(!value)
        {
            return i;
        }
    }
    return 0;
    
}

#pragma mark - Alarm Scheduler Methods
- (void)scheduleLocalNotificationWithDate:(NSDate *)fireDate
                                  atIndex:(int)indexOfObject {
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    if (!localNotification)
        return;
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"hh-mm -a";
    NSDate* date = [dateFormatter dateFromString:[dateFormatter stringFromDate:fireDate]];
    
//    localNotification.repeatInterval = NSDayCalendarUnit;
    [localNotification setFireDate:date];
    [localNotification setTimeZone:[NSTimeZone defaultTimeZone]];
    // Setup alert notification
    [localNotification setAlertBody:@"Alarm"];
    [localNotification setAlertAction:@"Open App"];
    [localNotification setHasAction:YES];
    
    NSLog(@"%@", date);
  
    //This array maps the alarms uid to the index of the alarm so that we can cancel specific local notifications
    
    NSNumber* uidToStore = [NSNumber numberWithInt:indexOfObject];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:uidToStore forKey:@"notificationID"];
    localNotification.userInfo = userInfo;
    NSLog(@"Uid Store in userInfo %@", [localNotification.userInfo objectForKey:@"notificationID"]);
    
    // Schedule the notification
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    
}

@end
