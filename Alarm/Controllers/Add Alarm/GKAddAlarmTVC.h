//
//  GKAddAlarmVC.h
//  Alarm
//
//  Created by Gaurav Keshre on 4/15/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKAddAlarmTVC : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *txtFreeText;
@property (weak, nonatomic) IBOutlet UIDatePicker *pickerView;
@property (weak, nonatomic) IBOutlet UITextField *txtLabel;

- (IBAction)handlePickerValueChanged:(id)sender;
- (IBAction)handleAddButton:(id)sender;

@end
