//
//  CourseViewController.h
//  ClassBuddyInterface
//
//  Created by iOS Developer on 2015-03-29.
//  Copyright (c) 2015 CS212 Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"
#import "DBManager.h"
#import "EventListViewController.h"
#import "EventViewController.h"

@interface CourseViewController : UIViewController

@property (nonatomic) Course *course;
@property (nonatomic) DBManager *myDataBase;
@property (nonatomic) NSString *userEmail;

@end