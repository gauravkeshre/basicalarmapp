//
//  GKAlarmsTVC+FloatingView.m
//  Alarm
//
//  Created by Gaurav Keshre on 4/15/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import "GKAlarmsTVC+FloatingView.h"

@implementation GKAlarmsTVC (FloatingView)

-(void)adjustTableHeight{
    CGSize originalContentSize = self.tableView.contentSize;
    originalContentSize.height += kFLOATING_BUTTON_HEIGHT;
    self.tableView.contentSize = originalContentSize;
}

-(void)prepareFloatingView{

    if (self.floatingView) {
        return;
    }
    UIView *v2 = [[UIView alloc]initWithFrame:CGRectMake(0,0, [[UIScreen mainScreen]bounds].size.width, kFLOATING_BUTTON_HEIGHT)];
    [v2 setBackgroundColor:[UIColor colorWithRed:0.580 green:0.482 blue:0.698 alpha:1.000]];
    [v2 setAlpha:0.6];
    
    UIView *v1 = [[UIView alloc]initWithFrame:CGRectMake(0, self.originalOrigin, [[UIScreen mainScreen]bounds].size.width, kFLOATING_BUTTON_HEIGHT)];
    
    [v1 setBackgroundColor:[UIColor clearColor]];
    [v1 addSubview:v2];
    
    CGRect frameBtn = CGRectInset(v1.bounds, 10, 0);
    frameBtn.origin.y = 0;
    
    UIImage *imgBar = [[UIImage imageNamed:@"btn_bg_green"] resizableImageWithCapInsets:UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f)];
    
    UIButton *button = [[UIButton alloc]initWithFrame:frameBtn];
    
    [button addTarget:self action:@selector(handleFloatingButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [button setBackgroundImage:imgBar forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"Add Alarm" forState:UIControlStateNormal];
    
    [v1 addSubview:button];
    
    [self.view addSubview:v1];
    self.floatingView = v1;
    v2= nil;
    button = nil;
    v1 = nil;

}
#pragma mark - UIScrollViewDelegate Methods
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.floatingView == nil)return;
    
    CGRect tableBounds = self.tableView.bounds;
    CGRect floatingButtonFrame = self.floatingView.frame;
    floatingButtonFrame.origin.y = tableBounds.origin.y + self.originalOrigin;
    self.floatingView.frame = floatingButtonFrame;
}

#pragma mark - IBAction Methods

-(void)handleFloatingButton:(id)sender{
    NSLog(@"%@", sender);
    
    [self performSegueWithIdentifier:@"sAddAlarm" sender:nil];
 }

@end
