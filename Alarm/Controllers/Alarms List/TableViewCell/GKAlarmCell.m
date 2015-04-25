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
#import "GKToggleButton.h"
#import "GKTimeLabel.h"
static NSDateFormatter *formatter;
@interface GKAlarmCell()
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet GKTimeLabel *lblFuzzyTime;
@property (weak, nonatomic) IBOutlet GKToggleButton *btnCheckmark;
@property (weak, nonatomic)id data;
@property (weak, nonatomic) IBOutlet GKTimeLabel *btnTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lblAlarmTitle;

@end

@implementation GKAlarmCell

#pragma mark - GKDataReceiverProtocol Methods
-(void)setData:(GKAlarmObject *)alarm{
    
    NSLog(@"%@", alarm);
    _data =alarm;
    [self.btnTimeLabel startTimerWithDate:alarm.date];
    NSString *myDate = [[self df] stringFromDate:[alarm date]];
    [self.lblTime setText:myDate];
    [self.btnCheckmark setSelected:alarm.enabled];
    [self.lblAlarmTitle setText:alarm.label];
}

- (IBAction)handleCheckMark:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(alarmCellDate:didChangeCheckMarkStateTo:)]) {
        [self.delegate alarmCellDate:self.data didChangeCheckMarkStateTo:sender.isSelected];
    }
}

#pragma mark - Conv Methods
-(NSDateFormatter *)df{
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"hh:mm a"];
        [formatter setAMSymbol:@"am"];
        [formatter setPMSymbol:@"pm"];
     }
    return formatter;
}


@end
