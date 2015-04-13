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

@interface CreateCourseTableViewController : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate, UITableViewDelegate,UITableViewDataSource>{
    UISearchBar *searchBar;
    UISearchDisplayController *searchDisplayController;
}
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (nonatomic, strong) NSMutableArray *initialCourseArray;
@property (nonatomic, strong) NSMutableArray *registeredCourses;
@property (nonatomic, strong) NSMutableArray *filteredCourseArray;
@property (nonatomic) DBManager *myDataBase;
@property (nonatomic)BOOL isSearching;
@property (weak, nonatomic) NSString *userEmail;

@end
