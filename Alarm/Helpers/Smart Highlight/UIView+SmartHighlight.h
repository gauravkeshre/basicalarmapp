//
//  UIView+SmartHighlight.h
//  Alarm
//
//  Created by Gaurav Keshre on 4/15/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import <UIKit/UIKit.h>
#define HIGHLIGHT_SCALE_DURATION 0.25

@interface UIView (SmartHighlight)

-(void)focusWithScale:(CGFloat)scale;
-(void)dismissFocus;
-(void)shake;
@end
