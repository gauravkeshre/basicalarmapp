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
@interface GKAlarmCell : UITableViewCell<GKDataReceiverProtocol>
- (IBAction)handleCheckMark:(UIButton *)sender;

@end
