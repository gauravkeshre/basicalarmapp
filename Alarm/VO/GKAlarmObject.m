//
//  AlarmObject.m
//  Alarm
//
//  Created by Gaurav Keshre on 4/15/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import "GKAlarmObject.h"

@implementation GKAlarmObject

@synthesize label;
@synthesize date;
@synthesize enabled;
@synthesize notificationID;


#pragma mark - NSCoding Methods
/*
 * To be able to save the alarm object in User default
 */
-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.label forKey:@"label"];
    [encoder encodeObject:self.date forKey:@"date"];
    [encoder encodeBool:self.enabled forKey:@"enabled"];
    [encoder encodeInt:self.notificationID forKey:@"notificationID"];
}

-(id)initWithCoder:(NSCoder *)decoder
{
    self.label = [decoder decodeObjectForKey:@"label"];
    self.date = [decoder decodeObjectForKey:@"date"];
    self.enabled = [decoder decodeBoolForKey:@"enabled"];
    self.notificationID = [decoder decodeIntForKey:@"notificationID"];
    return self;
}

@end
