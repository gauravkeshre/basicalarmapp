//
//  GKAppearanceManager.m
//  Alarm
//
//  Created by Gaurav Keshre on 4/15/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import "GKAppearanceManager.h"

@implementation GKAppearanceManager

+(void)applyAppearance{
    /*
     * Appearance
     */
    
    NSShadow* shadow = [NSShadow new];
    shadow.shadowOffset = CGSizeMake(0.0f, 0.0f);
    shadow.shadowColor = [UIColor colorWithRed:0.918 green:0.943 blue:0.929 alpha:1.000];
    [[UINavigationBar appearance] setTitleTextAttributes: @{
                                                            NSForegroundColorAttributeName: [UIColor colorWithRed:0.994 green:0.962 blue:1.000 alpha:1.000],
                                                            NSFontAttributeName: [UIFont boldSystemFontOfSize:22.f],
                                                            NSShadowAttributeName: shadow
                                                            }];
    
    UIImage *imgText = [[UIImage imageNamed:@"bg_innershadow"] resizableImageWithCapInsets:UIEdgeInsetsMake(5.f, 5.f, 5.f, 5.f)];
    
    [[UITextField appearance]setBackground:imgText];


}
@end
