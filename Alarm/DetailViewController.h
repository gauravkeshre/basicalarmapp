//
//  DetailViewController.h
//  Alarm
//
//  Created by Gaurav Keshre on 4/14/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

