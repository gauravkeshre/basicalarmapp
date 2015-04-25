//
//  GKAlarmCell.h
//  Alarm
//
//  Created by Gaurav Keshre on 4/15/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GKDataReceiverProtocol.h"
#import "NSDate+RelativeTime.h"

@class GKAlarmCell;
@protocol GKAlarmCellDelegate <NSObject>
-(void)alarmCellDate:(id)cellData didChangeCheckMarkStateTo:(BOOL)selected ;
@end

@interface GKAlarmCell : UITableViewCell<GKDataReceiverProtocol>
@property (weak, nonatomic)id<GKAlarmCellDelegate>delegate;
- (IBAction)handleCheckMark:(UIButton *)sender;

@end
