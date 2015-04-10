//
//  ResetAlarmViewController.h
//  ClassBuddyInterface
//
//  Created by iOS Developer on 2015-04-09.
//  Copyright (c) 2015 CS212 Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "DBManager.h"

@interface ResetAlarmViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *eventName;
@property (weak, nonatomic) IBOutlet UILabel *dueDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *alarm;
@property (nonatomic) DBManager *myDataBase;
@property (nonatomic) Event *event;
@property (nonatomic) NSString *courseCode;
@property (nonatomic) NSString *userEmail;
@end
