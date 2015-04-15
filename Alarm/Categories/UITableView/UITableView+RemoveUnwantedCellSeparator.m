//
//  UITableView+RemoveUnwantedCellSeparator.m
//  Alarm
//
//  Created by Gaurav Keshre on 4/15/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import "UITableView+RemoveUnwantedCellSeparator.h"

@implementation UITableView (RemoveUnwantedCellSeparator)
-(void)removeUnwantedCellSeparator{
    
}

- (void)addEmptyFooter{
    CGRect viewFrame = self.frame;
    viewFrame.size.height= 1.f;
    UIView *v = [[UIView alloc]initWithFrame:viewFrame];
    [v setBackgroundColor:[UIColor clearColor]];
    [self setTableFooterView:v];
    v = nil;
}
- (void)addShadowFooter
{
    CGRect viewFrame = self.frame;
    viewFrame.size.height= 16.f;
    UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dark_shadow_divider.png"]];
    imgV.frame = viewFrame;
    [self setTableFooterView:imgV];
    imgV = nil;
}
@end
