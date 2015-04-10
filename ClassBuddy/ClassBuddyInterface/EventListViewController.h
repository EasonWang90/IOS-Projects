//
//  EventListViewController.h
//  ClassBuddy
//
//  Created by Eason on 2015-03-26.
//  Copyright (c) 2015 Big data. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "EventViewController.h"
#import "DBManager.h"

@interface EventListViewController : UITableViewController <UITableViewDataSource,UITabBarDelegate,UIActionSheetDelegate>
@property (nonatomic) NSInteger numRows;
@property (nonatomic) DBManager *myDataBase;
@property (nonatomic) NSString *courseCode;
@property (nonatomic) NSString *userEmail;
@end
