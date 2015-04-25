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
    [encoder encodeInteger:self.notificationID forKey:@"notificationID"];
}

-(id)initWithCoder:(NSCoder *)decoder
{
    self.label = [decoder decodeObjectForKey:@"label"];
    self.date = [decoder decodeObjectForKey:@"date"];
    self.enabled = [decoder decodeBoolForKey:@"enabled"];
    self.notificationID = [decoder decodeIntegerForKey:@"notificationID"];
    return self;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"label: %@ \n date: %@ \n notificationID: %li \n enabled : %@", self.label, self.date, (long)self.notificationID, self.enabled?@"YES":@"NO"];
}
@end
