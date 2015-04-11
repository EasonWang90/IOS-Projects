//
//  ConfirmCourseViewController.h
//  ClassBuddyInterface
//
//  Created by Jonathan Cudmore on 2015-03-25.
//  Copyright (c) 2015 CS212 Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"
#import "DBManager.h"
#import "CreateCourseTableViewController.h"

@interface ConfirmCourseViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic) Course* course;
@property (weak, nonatomic) IBOutlet UITextField *courseCodeField;
@property (weak, nonatomic) IBOutlet UITextField *courseNameField;
@property (weak, nonatomic) IBOutlet UITextField *dateTimeField;
@property (weak, nonatomic) IBOutlet UITextField *professorField;
@property (weak, nonatomic) IBOutlet UITextField *locationField;
@property (nonatomic) DBManager *myDataBase;
@property (nonatomic) NSString *userEmail;

@end
