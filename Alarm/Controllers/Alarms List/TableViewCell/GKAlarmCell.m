//
//  GKAlarmCell.m
//  Alarm
//
//  Created by Gaurav Keshre on 4/15/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import "GKAlarmCell.h"
#import "NSDate+RelativeTime.h"
#import "NSDate-Utilities.h"
#import "GKAlarmObject.h"
static NSDateFormatter *formatter;
@interface GKAlarmCell()
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblAMPM;
@property (weak, nonatomic) IBOutlet UILabel *lblFuzzyTime;

@end

@implementation GKAlarmCell

#pragma mark - GKDataReceiverProtocol Methods
-(void)setData:(GKAlarmObject *)alarm{
//    NSString *strTimeToAlarm = [data[@"alarm_time"] relativeTime];
    
    NSString *relative = [alarm.date relativeTime];
    [self.lblFuzzyTime setText:relative];    
    NSString *myDate = [[self df] stringFromDate:[alarm date]];

    [self.lblTime setText:myDate];
    
    
    
    
}

- (IBAction)handleCheckMark:(UIButton *)sender {
}

#pragma mark - Conv Methods
-(NSDateFormatter *)df{
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"hh:mm a"];
     }
    return formatter;
}
@end
