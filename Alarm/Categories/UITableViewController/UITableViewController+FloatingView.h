//
//  CustomTableWithFloatingView.h
//  FaceDetectionPOC
//
//  Created by Sugeet on 01/04/15.
//  Copyright (c) 2015 Softway Solutions Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kMAXHEIGHT 60
@interface UITableViewController(FloatingView)

@property (nonatomic, strong) UIView *floatingView;
@property (nonatomic, assign) CGFloat originalOrigin;

+(void)swizzle;
-(void) custom_viewWillAppear:(BOOL)animated;
-(void) custom_viewDidAppear:(BOOL)animated;
@end
