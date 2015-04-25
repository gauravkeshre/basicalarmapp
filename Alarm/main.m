//
//  main.m
//  Alarm
//
//  Created by Gaurav Keshre on 4/14/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        
        NSUInteger count = 99;
        NSString *str = @"orange tshirt";
        
        NSArray *arr = @[@"sun", @"moon", @"jupiter"];
        
        NSLog(@"%lu - %@", count, str);
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
