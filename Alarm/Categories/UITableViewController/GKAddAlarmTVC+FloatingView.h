//
//  CustomTableWithFloatingView.h
//  FaceDetectionPOC
//
//  Created by Sugeet on 01/04/15.
//  Copyright (c) 2015 Softway Solutions Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GKAddAlarmTVC.h"
#define kMAXHEIGHT 60
@interface GKAddAlarmTVC(FloatingView)

@property (nonatomic, strong) UIView *floatingView;
@property (nonatomic, assign) CGFloat originalOrigin;

@end
