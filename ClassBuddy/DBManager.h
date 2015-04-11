//
//  DMManager.h
//  ClassBuddyData
//
//  Created by iOS Developer on 2015-03-25.
//  Copyright (c) 2015 UPEICS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Course.h"
#import "Person.h"
#import "Event.h"

@interface DBManager : NSObject
{
    NSString *databasePath;
    NSMutableArray* courseList;
}

//@property (nonatomic) NSMutableArray* courseList;

+(DBManager*)getSharedInstance;
-(BOOL)createDB;
-(BOOL)initData;
- (NSArray*) listAll;
- (NSMutableArray*) findByCourseCode:(NSString*)code;
- (BOOL)registerACourseCourseCode: (NSString *)courseCode UserEmail: (NSString *)userEmail;
- (NSArray*)getRegisteredCourseList: (NSString *)userEmail;
- (BOOL)addAnEventEventName: (NSString *)name
                   DueDate: (NSString *)dueDate
                   AlarmDate: (NSString *)alarmDate
                   CourseCode: (NSString *)code
                   userEmail: (NSString *)email;
- (NSArray*)getUnfinishedEvents: (NSString *)userEmail CourseCode: (NSString *)courseCode;
- (BOOL)finishedAnEvent:(NSString *)courseCode UserEmail: (NSString *)userEmail EventName: (NSString *)eventName;
- (BOOL) resetAlarmDate: (NSString *)alarmDate
             CourseCode: (NSString *)courseCode
              UserEmail: (NSString *)userEmail
              EventName: (NSString *)eventName;
- (BOOL)createNewCourse: (Course *)course;
- (BOOL)deleteACourse: (NSString *)courseCode UserEmail: (NSString *)userEmail;

@end
