//
//  UITextField+Additions.m
//  FaceDetectionPOC
//
//  Created by Gaurav Keshre on 3/30/15.
//  Copyright (c) 2015 Softway Solutions Pvt. Ltd. All rights reserved.
//

#import "UITextField+Additions.h"

@implementation UITextField (Additions)
-(void)fixInsets{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    [paddingView setBackgroundColor:[UIColor clearColor]];
    self.leftView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

@end
