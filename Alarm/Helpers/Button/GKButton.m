//
//  GKButton.m
//  Alarm
//
//  Created by Gaurav Keshre on 4/15/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import "GKButton.h"
#import "UIView+SmartHighlight.h"
@implementation GKButton


#pragma mark - UIGesture Delegate Methods
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self focusWithScale:2.f];
    [super touchesBegan:touches withEvent:event];
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [self dismissFocus];
    [super touchesCancelled:touches withEvent:event];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self dismissFocus];
    [super touchesEnded:touches withEvent:event];
}
@end
