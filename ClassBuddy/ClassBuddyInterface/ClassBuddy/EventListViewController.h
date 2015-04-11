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
#import "Event.h"
#import "DBManager.h"
#import "ResetAlarmViewController.h"

@interface EventListViewController : UITableViewController <UITableViewDataSource,UITabBarDelegate,UIActionSheetDelegate>
@property (nonatomic) DBManager *myDataBase;
@property (nonatomic) NSString *courseCode;
@property (nonatomic) NSString *userEmail;
@property (nonatomic) NSMutableArray *unfinishedEventList;
@property (nonatomic) NSString *selectedEventName;
@property (nonatomic) Event *finishedEvent;
@end
