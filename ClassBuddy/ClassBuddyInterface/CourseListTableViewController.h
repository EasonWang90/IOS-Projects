//
//  CourseListTableViewController.h
//  ClassBuddyInterface
//
//  Created by Jonathan Cudmore on 2015-03-25.
//  Copyright (c) 2015 CS212 Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"
#import "Person.h"

@interface CourseListTableViewController : UITableViewController

@property (nonatomic) NSMutableArray *courseArray;
@property (nonatomic) DBManager *myDatabase;
@property (nonatomic) NSString *userEmail;
@end
