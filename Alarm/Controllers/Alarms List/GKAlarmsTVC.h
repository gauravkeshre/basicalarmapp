//
//  GKAlarmsTVC.h
//  Alarm
//
//  Created by Gaurav Keshre on 4/15/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKAlarmsTVC : UITableViewController

/*
 * FloatingView
 */
@property(nonatomic, weak) UIButton *floatingButton;
@property(nonatomic, weak) UIImageView  *floatingLogo;
@property(nonatomic, weak) UIView  *floatingView;
@property (nonatomic) CGFloat originalOrigin;

@end
