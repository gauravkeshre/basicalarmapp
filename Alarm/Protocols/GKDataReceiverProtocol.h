//
//  GKDataReceiverProtocol.h
//  Alarm
//
//  Created by Gaurav Keshre on 4/15/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GKDataReceiverProtocol<NSObject>

@optional
-(void)setData:(id)data;
@end
