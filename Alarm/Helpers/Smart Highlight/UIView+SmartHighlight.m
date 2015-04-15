//
//  UIView+SmartHighlight.m
//  Alarm
//
//  Created by Gaurav Keshre on 4/15/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import "UIView+SmartHighlight.h"

@implementation UIView (SmartHighlight)

-(void)shake{
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"position"];
    [shake setDuration:0.1];
    [shake setRepeatCount:2];
    [shake setAutoreverses:YES];
    [shake setFromValue:[NSValue valueWithCGPoint:
                         CGPointMake(self.center.x - 5,self.center.y)]];
    [shake setToValue:[NSValue valueWithCGPoint:
                       CGPointMake(self.center.x + 5, self.center.y)]];
    
    [self.layer addAnimation:shake forKey:@"position"];
}


-(void)focusWithScale:(CGFloat)scale{
    CGAffineTransform t = CGAffineTransformMakeScale(scale, scale);
    [UIView animateWithDuration:HIGHLIGHT_SCALE_DURATION animations:^{
        self.transform = t;
    }];
}
-(void)dismissFocus{
    [self focusWithScale:1.f];
}

@end
