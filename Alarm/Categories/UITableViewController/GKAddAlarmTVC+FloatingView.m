//
//  CustomTableWithFloatingView.m
//  Alarm
//
//  Created by Gaurav Keshre on 4/15/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import <objc/runtime.h>
#import "GKAddAlarmTVC+FloatingView.h"

@implementation GKAddAlarmTVC(FloatingView)
@dynamic floatingView;
@dynamic originalOrigin;

static char *kFloatingViewKey;

+ (void)swizzle {
    static dispatch_once_t once_token;
    dispatch_once(&once_token,  ^{
        SEL viewDidAppearSelector = @selector(viewDidAppear:);
        SEL viewDidAppearCustomSelector = @selector(custom_viewDidAppear:);
        Method originalMethod = class_getInstanceMethod(self, viewDidAppearSelector);
        Method extendedMethod = class_getInstanceMethod(self, viewDidAppearCustomSelector);
        method_exchangeImplementations(originalMethod, extendedMethod);
        
        SEL viewWillAppearSelector = @selector(viewWillAppear:);
        SEL viewWillAppearCustomSelector = @selector(custom_viewWillAppear:);
        originalMethod = class_getInstanceMethod(self, viewWillAppearSelector);
        extendedMethod = class_getInstanceMethod(self, viewWillAppearCustomSelector);
        method_exchangeImplementations(originalMethod, extendedMethod);
    });
}

-(void) custom_viewWillAppear:(BOOL)animated {
    [self custom_viewWillAppear:animated];
    objc_getAssociatedObject(self, &kFloatingViewKey);
    NSLog(@"Associative Object %@", [self floatingViewKey]);
    NSLog(@"logged view did appear for %@", [self class]);
    [self prepareFloatingView]; //shouldn't be put in custom_viewWillAppear:
}


-(void) custom_viewDidAppear:(BOOL)animated{
    [self custom_viewDidAppear:animated];
    NSLog(@"custom view did appear for %@", [self class]);
    [self adjustTableHeight]; //can't be put inside custom_viewDidAppear:
}

- (id)floatingViewKey {
    return objc_getAssociatedObject(self, kFloatingViewKey);
}

- (void)setFloatingViewKey:(id)object {
    objc_setAssociatedObject(self, kFloatingViewKey, object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(void)adjustTableHeight{
    CGSize originalContentSize = self.tableView.contentSize;
    originalContentSize.height += kMAXHEIGHT;
    self.tableView.contentSize = originalContentSize;
}

-(void)prepareFloatingView{
    if (self.floatingView) {
        return;
    }
    
    UIView *v2 = [[UIView alloc]initWithFrame:CGRectMake(0,0, [[UIScreen mainScreen]bounds].size.width, 120)];
    [v2 setBackgroundColor:[UIColor colorWithRed:0.580 green:0.482 blue:0.698 alpha:1.000]];
    [v2 setAlpha:0.6];
    CGFloat height = [[UIScreen mainScreen]bounds].size.height;
    self.originalOrigin = height - kMAXHEIGHT;
    
    UIView *v1 = [[UIView alloc]initWithFrame:CGRectMake(0, self.originalOrigin, [[UIScreen mainScreen]bounds].size.width, 120)];
    
    [v1 setBackgroundColor:[UIColor clearColor]];
    [v1 addSubview:v2];
    
    CGRect frameBtn = CGRectInset(v1.bounds, 10, 35);
    frameBtn.origin.y = 10;
    
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
    CGRect tableBounds = self.tableView.bounds;
    CGRect floatingButtonFrame = self.floatingView.frame;
    floatingButtonFrame.origin.y = tableBounds.origin.y + self.originalOrigin;
    self.floatingView.frame = floatingButtonFrame;
}

#pragma mark - Action Methods
#pragma mark - IBAction Methods

-(void)handleFloatingButton:(id)sender{
    NSLog(@"%@", sender);
    
}

@end
