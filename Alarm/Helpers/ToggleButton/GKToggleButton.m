//
//  GKToggleButton.m
//  Alarm
//
//  Created by Gaurav Keshre on 4/15/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import "GKToggleButton.h"
@interface GKToggleButton()
{
    UIColor *initialColor;
    NSString *title;
}
@end
@implementation GKToggleButton
#pragma mark - UIGesture Delegate Methods
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    initialColor = self.backgroundColor;
    title = self.titleLabel.text;
    
//    [self setTitle:@" " forState:UIControlStateNormal];
//    if (self.selected) {
//        [self setImage:[UIImage imageNamed:@"tick_sel"] forState:UIControlStateNormal];
//    }else{
//        [self setImage:[UIImage imageNamed:@"tick_unsel"] forState:UIControlStateNormal];
//
//    }

    [super touchesBegan:touches withEvent:event];
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    BOOL f = !self.selected;
   
//    if (f) {
//        [self setImage:[UIImage imageNamed:@"tick_sel"] forState:UIControlStateNormal];
//    }else{
//        [self setImage:[UIImage imageNamed:@"tick_unsel"] forState:UIControlStateNormal];
//        
//    }
        [self setSelected:f];

//    if (self.selected) {
//        [self setBackgroundColor:[UIColor greenColor]];
//        [self setTitle:@"ON" forState:UIControlStateNormal];
//    }else{
//        [self setBackgroundColor:[UIColor grayColor]];
//        [self setTitle:@"OFF" forState:UIControlStateNormal];
//    }
    [super touchesEnded:touches withEvent:event];
}


@end
