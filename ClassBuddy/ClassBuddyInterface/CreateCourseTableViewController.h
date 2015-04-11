//
//  CreateCourseTableViewController.h
//  ClassBuddyInterface
//
//  Created by Jon on 2015-03-26.
//  Copyright (c) 2015 CS212 Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"
#import "DBManager.h"
#import "Person.h"

@interface CreateCourseTableViewController : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *initialCourseArray;
@property (nonatomic, strong) NSMutableArray *registeredCourses;
@property (nonatomic, strong) NSMutableArray *filteredCourseArray;
@property IBOutlet UISearchBar *courseSearchBar;
@property (nonatomic) DBManager *myDataBase;
@property (weak, nonatomic) NSString *userEmail;

@end
