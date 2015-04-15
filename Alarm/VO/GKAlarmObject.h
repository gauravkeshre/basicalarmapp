//
//  AlarmObject.h
//  Alarm
//
//  Created by Gaurav Keshre on 4/15/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface GKAlarmObject : NSObject<NSCoding>

@property(nonatomic,strong) NSString * label;
@property(nonatomic,strong) NSDate * date;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign) int notificationID;


@end
