//
//  GKTimeLabel.h
//  Alarm
//
//  Created by Gaurav Keshre on 4/15/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKTimeLabel : UIButton
{
    UIControlContentHorizontalAlignment textAlignment;
}
@property (nonatomic, copy) NSString* fontName;

-(void)setTitle:(NSString *)title;
-(void)setTextHorizontalAlignment:(UIControlContentHorizontalAlignment)alignment;
-(void)startTimerWithIntialDate:(NSString *)date;
-(void)startTimerWithDate:(NSDate *)date;
-(void)stopTimer;
-(void)displayDate;

@end
