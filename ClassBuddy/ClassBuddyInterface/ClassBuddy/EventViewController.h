//
//  EventViewController.h
//  ClassBuddy
//
//  Created by Eason on 2015-03-27.
//  Copyright (c) 2015 Big data. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"

@interface EventViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *itemText;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *dueDatePicker;

@property NSDate *dueDate;
@property NSDate *alarmDate;
@property DBManager *myDataBase;
@property (nonatomic) NSString *courseCode;
@property (nonatomic) NSString *userEmail;
@end
