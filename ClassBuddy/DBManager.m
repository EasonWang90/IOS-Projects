//
//  DMManager.m
//  ClassBuddyData
//
//  Created by iOS Developer on 2015-03-25.
//  Copyright (c) 2015 UPEICS. All rights reserved.
//

#import "DBManager.h"
#import "Course.h"
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;
static DBManager *sharedInstance = nil;

@implementation DBManager

+(DBManager*)getSharedInstance{
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
        [sharedInstance initData];
        //[sharedInstance listAll];
    }
    return sharedInstance;
}

-(BOOL)createDB{
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent: @"classBuddy.db"]];
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
            char *errMsg;
            
			const char *sql_CourseInfo =
            "create table if not exists CourseInfo (CourseCode text primary key, CourseName text, CourseTime text, Location text, Professor text)";
			
            if (sqlite3_exec(database, sql_CourseInfo, NULL, NULL, &errMsg)
                != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create table CourseInfo");
            }
			
			const char *sql_Event =
            "create table if not exists Event (ID INTEGER PRIMARY KEY AUTOINCREMENT, EventName text, DueDate text, AlarmDate, Finished INT DEFAULT 0, CourseCode text, UserEmail text, FOREIGN KEY(CourseCode) REFERENCES CourseInfo(CourseCode))";
			
			if (sqlite3_exec(database, sql_Event, NULL, NULL, &errMsg)
                != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create table Event");
            }
			
			const char *sql_Registration =
            "create table if not exists Registration (ID INTEGER PRIMARY KEY AUTOINCREMENT, UserEmail text, CourseCode text, FOREIGN KEY(CourseCode) REFERENCES CourseInfo(CourseCode))";
			
			if (sqlite3_exec(database, sql_Registration, NULL, NULL, &errMsg)
                != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create table CourseRegister");
            }
			
            sqlite3_close(database);
            return  isSuccess;
        }
        else {
            isSuccess = NO;
            NSLog(@"Failed to open/create database");
        }
    }
    return isSuccess;
}

-(BOOL)initData
{
    BOOL done = NO;
	const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL0 = @"insert into CourseInfo (CourseCode, CourseName, CourseTime, Location, Professor) values (\"CS 151\", \"INTRODUCTION TO COMPUTER SCIENCE I\", \"M W 1:30-2:45\", \"CSH 104\",\"Scott Bateman\")";
		const char *insert_stmt0 = [insertSQL0 UTF8String];
		sqlite3_prepare_v2(database, insert_stmt0,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            done = YES;
        }
        else {
            done = NO;
        }
		
		NSString *insertSQL1 = @"insert into CourseInfo (CourseCode, CourseName, CourseTime, Location,  Professor) values (\"CS 212\", \"NON-TRADITIONAL PLATFORM COMPUTING\", \"T TH 2:30-3:45\", \"CSH 104\", \"Stephen Howard\")";
		const char *insert_stmt1 = [insertSQL1 UTF8String];
		sqlite3_prepare_v2(database, insert_stmt1,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            done = YES;
        }
        else {
            done = NO;
        }
		
		NSString *insertSQL2 = @"insert into CourseInfo (CourseCode, CourseName, CourseTime, Location,  Professor) values (\"CS 252\", \"COMPUTER ORGANIZATION & ARCHITECTURE\", \"M W 3:00-4:15\", \"CSH 104\", \"Qiang Ye\")";
		const char *insert_stmt2 = [insertSQL2 UTF8String];
		sqlite3_prepare_v2(database, insert_stmt2,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            done = YES;
        }
        else {
            done = NO;
        }
		
		NSString *insertSQL3 = @"insert into CourseInfo (CourseCode, CourseName, CourseTime, Location,  Professor) values (\"CS 282\", \"INTRO. TO SYSTEM PROGRAMMING\", \"M W F 9:30-10:20\", \"CSH 104\", \"Qiang Ye\")";
		const char *insert_stmt3 = [insertSQL3 UTF8String];
		sqlite3_prepare_v2(database, insert_stmt3,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            done = YES;
        }
        else {
            done = NO;
        }
        
        
		NSString *insertSQL4 = @"insert into CourseInfo (CourseCode, CourseName, CourseTime, Location,  Professor) values (\"CS 306\", \"CLOUD COMPUTING\", \"M W F 12:30-1:20\", \"CSH 104\", \"Yingwei Wang\")";
		const char *insert_stmt4 = [insertSQL4 UTF8String];
		sqlite3_prepare_v2(database, insert_stmt4,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            done = YES;
        }
        else {
            done = NO;
        }
        
        
		NSString *insertSQL5 = @"insert into CourseInfo (CourseCode, CourseName, CourseTime, Location,  Professor) values (\"CS 322\", \"INTRODUCTION TO BIOINFORMATICS\", \"T TH 11:30-12:45\", \"CSH 104\", \"Yingwei Wang\")";
		const char *insert_stmt5 = [insertSQL5 UTF8String];
		sqlite3_prepare_v2(database, insert_stmt5,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            done = YES;
        }
        else {
            done = NO;
        }
        
        
		NSString *insertSQL6 = @"insert into CourseInfo (CourseCode, CourseName, CourseTime, Location,  Professor) values (\"CS 342\", \"COMPUTER COMMUNICATIONS\", \"M W F 11:30-12:20\", \"CSH 104\", \"Qiang Ye\")";
		const char *insert_stmt6 = [insertSQL6 UTF8String];
		sqlite3_prepare_v2(database, insert_stmt6,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            done = YES;
        }
        else {
            done = NO;
        }
        
        NSString *insertSQL7 = @"insert into CourseInfo (CourseCode, CourseName, CourseTime, Location,  Professor) values (\"CS 362\", \"OBJECT-ORIENTED DESIGN\", \"T TH 11:30-12:45\", \"CSH 104\", \"Stephen Howard\")";
		const char *insert_stmt7 = [insertSQL7 UTF8String];
		sqlite3_prepare_v2(database, insert_stmt7,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            done = YES;
        }
        else {
            done = NO;
        }
        
        NSString *insertSQL8 = @"insert into CourseInfo (CourseCode, CourseName, CourseTime, Location, Professor) values (\"CS 371\", \"DATABASE SYSTEMS\", \"M W F 10:30-11:20\", \"CSH 104\", \"Yingwei Wang\")";
		const char *insert_stmt8 = [insertSQL8 UTF8String];
		sqlite3_prepare_v2(database, insert_stmt8,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            done = YES;
        }
        else {
            done = NO;
        }
        
        NSString *insertSQL9 = @"insert into CourseInfo (CourseCode, CourseName, CourseTime, Location,  Professor) values (\"CS 436\", \"ADVANCED COMPUTER GRAPHICS PROGRAMMING\", \"W 7:00-9:45\", \"CSH 104\", \"Gordon Wood\")";
		const char *insert_stmt9 = [insertSQL9 UTF8String];
		sqlite3_prepare_v2(database, insert_stmt9,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            done = YES;
        }
        else {
            done = NO;
        }
        
        NSString *insertSQL10 = @"insert into CourseInfo (CourseCode, CourseName, CourseTime, Location,  Professor) values (\"CS 465\", \"VIDEO-GAME ARCHITECTURE\", \"M 7:00-9:45\", \"CSH 104\", \"Carel Boers\")";
		const char *insert_stmt10 = [insertSQL10 UTF8String];
		sqlite3_prepare_v2(database, insert_stmt10,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            done = YES;
        }
        else {
            done = NO;
        }
        
        NSString *insertSQL11 = @"insert into CourseInfo (CourseCode, CourseName, CourseTime, Location,  Professor) values (\"CS 482\", \"SOFTWARE SYSTEMS DEVELOPMENT PROJECT\", \"T TH 1:00-2:15\", \"CSH 104\", \"Scott Bateman\")";
		const char *insert_stmt11 = [insertSQL11 UTF8String];
		sqlite3_prepare_v2(database, insert_stmt11,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            done = YES;
        }
        else {
            done = NO;
        }
        
        NSString *insertSQL12 = @"insert into CourseInfo (CourseCode, CourseName, CourseTime, Location,  Professor) values (\"CS 483\", \"VIDEO GAME PROGRAMMING PROJECT\", \"W 6:00-7:00\", \"CSH 104\", \"Scott Bateman\")";
		const char *insert_stmt12 = [insertSQL12 UTF8String];
		sqlite3_prepare_v2(database, insert_stmt12,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            done = YES;
        }
        else {
            done = NO;
        }
        
        NSString *insertSQL13 = @"insert into CourseInfo (CourseCode, CourseName, CourseTime, Location,  Professor) values (\"CS 261\", \"Data Structure\", \"M 3:00-6:00\", \"CSH 104\", \"Scott Bateman\")";
		const char *insert_stmt13 = [insertSQL13 UTF8String];
		sqlite3_prepare_v2(database, insert_stmt13,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            done = YES;
        }
        else {
            done = NO;
        }
        
		
        sqlite3_reset(statement);
    }
    return done;
}

- (NSArray*) findByCourseCode:(NSString*)code
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"select CourseCode, CourseName, CourseTime, Location, Professor from CourseInfo where CourseCode=\"%@\"",code];
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        
        if (sqlite3_prepare_v2(database,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *code = [[NSString alloc] initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 0)];
                [resultArray addObject:code];
                NSString *name = [[NSString alloc] initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 1)];
                [resultArray addObject:name];
                NSString *time = [[NSString alloc] initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 2)];
                [resultArray addObject:time];
                NSString *location = [[NSString alloc] initWithUTF8String:
                                      (const char *) sqlite3_column_text(statement, 3)];
                
                [resultArray addObject:location];
                NSString *professor = [[NSString alloc]initWithUTF8String:
                                       (const char *) sqlite3_column_text(statement, 4)];
                [resultArray addObject:professor];
                return resultArray;
            }
            else{
                NSLog(@"Not found");
                return nil;
            }
            sqlite3_reset(statement);
        }
    }
    return nil;
}


- (NSArray*) listAll
{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"select CourseCode, CourseName, CourseTime, Location, Professor from CourseInfo"];
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        
        if (sqlite3_prepare_v2(database,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                Course *loadedCourse = [[Course alloc] init];
                NSString *code = [[NSString alloc] initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 0)];
                [resultArray addObject:code];
                loadedCourse.courseCode = code;
                
                NSString *name = [[NSString alloc] initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 1)];
                [resultArray addObject:name];
                loadedCourse.courseName = name;
                
                NSString *time = [[NSString alloc] initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 2)];
                [resultArray addObject:time];
                loadedCourse.courseTime = time;
                
                NSString *location = [[NSString alloc] initWithUTF8String:
                                      (const char *) sqlite3_column_text(statement, 3)];
                [resultArray addObject:location];
                loadedCourse.location = location;
                
                NSString *professor = [[NSString alloc]initWithUTF8String:
                                       (const char *) sqlite3_column_text(statement, 4)];
                [resultArray addObject:professor];
                loadedCourse.professor = professor;
                
                [list addObject:loadedCourse];
                //[courseList addObject:loadedCourse];
                
                //return resultArray;
            }
            
            sqlite3_reset(statement);
        }
    }
    return list;
    
}

- (BOOL)registerACourseCourseCode: (NSString *)courseCode UserEmail: (NSString *)userEmail
{
    BOOL done = NO;
	const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"insert into Registration (UserEmail, CourseCode) values (\"%@\", \"%@\")",userEmail, courseCode];
        
        const char *insert_stmt = [insertSQL UTF8String];
		sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            done = YES;
        }
        else {
            done = NO;
        }
        
		
        sqlite3_reset(statement);
    }
    return done;
}

- (NSArray*)getRegisteredCourseList: (NSString *)userEmail
{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        //NSString *querySQL = [NSString stringWithFormat: @"select CourseInfo.CourseCode, CourseName, CourseTime, Location, Professor from CourseInfo join Registration on Registration.PersonName = %@ and Registration.CourseCode = CourseInfo.CourseCode", userName];
        NSString *querySQL = [NSString stringWithFormat: @"select CourseInfo.CourseCode, CourseInfo.CourseName, CourseInfo.CourseTime, CourseInfo.Location, CourseInfo.Professor from CourseInfo join Registration on Registration.CourseCode = CourseInfo.CourseCode AND UserEmail = \"%@\" ",userEmail];

        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        
        if (sqlite3_prepare_v2(database,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                Course *loadedCourse = [[Course alloc] init];
                NSString *code = [[NSString alloc] initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 0)];
                [resultArray addObject:code];
                loadedCourse.courseCode = code;
                
                NSString *name = [[NSString alloc] initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 1)];
                [resultArray addObject:name];
                loadedCourse.courseName = name;
                
                NSString *time = [[NSString alloc] initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 2)];
                [resultArray addObject:time];
                loadedCourse.courseTime = time;
                
                NSString *location = [[NSString alloc] initWithUTF8String:
                                      (const char *) sqlite3_column_text(statement, 3)];
                [resultArray addObject:location];
                loadedCourse.location = location;
                
                NSString *professor = [[NSString alloc]initWithUTF8String:
                                       (const char *) sqlite3_column_text(statement, 4)];
                [resultArray addObject:professor];
                loadedCourse.professor = professor;
                
                [list addObject:loadedCourse];
                //[courseList addObject:loadedCourse];
                
                //return resultArray;
            }
            
            sqlite3_reset(statement);
        }
    }
    return list;
}

- (BOOL)addAnEventEventName: (NSString *)name
                    DueDate: (NSString *)dueDate
                  AlarmDate: (NSString *)alarmDate
                 CourseCode: (NSString *)code
                  userEmail: (NSString *)email
{
    
    BOOL done = NO;
	const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"insert into Event (EventName, DueDate, AlarmDate, CourseCode, UserEmail) values (\"%@\", \"%@\",\"%@\",\"%@\",\"%@\")",name, dueDate, alarmDate, code, email];
        
        const char *insert_stmt = [insertSQL UTF8String];
		sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            done = YES;
        }
        else {
            done = NO;
        }
        
		
        sqlite3_reset(statement);
    }
    return done;
    
}

- (NSArray*)getUnfinishedEvents: (NSString *)userEmail CourseCode: (NSString *)courseCode
{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        //NSString *querySQL = [NSString stringWithFormat: @"select CourseInfo.CourseCode, CourseName, CourseTime, Location, Professor from CourseInfo join Registration on Registration.PersonName = %@ and Registration.CourseCode = CourseInfo.CourseCode", userName];
        NSString *querySQL = [NSString stringWithFormat: @"select EventName, DueDate, AlarmDate, Finished, CourseCode, UserEmail from Event where UserEmail = \"%@\" and CourseCode = \"%@\" and Finished = 0",userEmail, courseCode];
        
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        
        if (sqlite3_prepare_v2(database,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                Event *loadedEvent = [[Event alloc] init];
                NSString *eventName = [[NSString alloc] initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 0)];
                [resultArray addObject:eventName];
                loadedEvent.eventName = eventName;
                
                NSString *dueDate = [[NSString alloc] initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 1)];
                [resultArray addObject:dueDate];
                loadedEvent.dueDate = dueDate;
                
                NSString *alarmDate = [[NSString alloc] initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 2)];
                [resultArray addObject:alarmDate];
                loadedEvent.alarmDate = alarmDate;
                
                NSString *finished = [[NSString alloc] initWithUTF8String:
                                      (const char *) sqlite3_column_text(statement, 3)];
                [resultArray addObject:finished];
                loadedEvent.finished = [finished intValue];
                
                NSString *code = [[NSString alloc]initWithUTF8String:
                                       (const char *) sqlite3_column_text(statement, 4)];
                [resultArray addObject:code];
                loadedEvent.courseCode = code;
                
                NSString *email = [[NSString alloc] initWithUTF8String:
                                     (const char *) sqlite3_column_text(statement, 5)];
                [resultArray addObject:email];
                loadedEvent.userEmail = email;
                [list addObject:loadedEvent];
                //[courseList addObject:loadedCourse];
                
                //return resultArray;
            }
            
            sqlite3_reset(statement);
        }
    }
    return list;

}

- (BOOL)finishedAnEvent:(NSString *)courseCode UserEmail: (NSString *)userEmail EventName: (NSString *)eventName
{
    BOOL done = NO;
	const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"update Event set Finished = 1 where UserEmail = \"%@\" and CourseCode = \"%@\" and EventName = \"%@\" ",userEmail, courseCode, eventName];
        
        const char *insert_stmt = [insertSQL UTF8String];
		sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            done = YES;
        }
        else {
            done = NO;
        }
        
		
        sqlite3_reset(statement);
    }
    return done;

}

- (BOOL) resetAlarmDate: (NSString *)alarmDate
             CourseCode: (NSString *)courseCode
              UserEmail: (NSString *)userEmail
              EventName: (NSString *)eventName
{
    BOOL done = NO;
	const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"update Event set AlarmDate = \"%@\" where UserEmail = \"%@\" and CourseCode = \"%@\" and EventName = \"%@\" ",alarmDate, userEmail, courseCode, eventName];
        
        const char *insert_stmt = [insertSQL UTF8String];
		sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            done = YES;
        }
        else {
            done = NO;
        }
        
		
        sqlite3_reset(statement);
    }
    return done;

}

- (BOOL)createNewCourse: (Course *)course
{
    BOOL done = NO;
	const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        /*
        @"insert into CourseInfo (CourseCode, CourseName, CourseTime, Location,  Professor) values (\"CS 436\", \"ADVANCED COMPUTER GRAPHICS PROGRAMMING\", \"W 7:00-9:45\", \"CSH 104\", \"Gordon Wood\")";
         */
        
        NSString *insertSQL = [NSString stringWithFormat:@"insert into CourseInfo(CourseCode, CourseName, CourseTime, Location,  Professor) values (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")  ",course.courseCode, course.courseName, course.courseTime, course.location, course.professor];
        
        const char *insert_stmt = [insertSQL UTF8String];
		sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            done = YES;
        }
        else {
            done = NO;
        }
        
		
        sqlite3_reset(statement);
    }
    return done;

}

- (BOOL)deleteACourse: (NSString *)courseCode UserEmail: (NSString *)userEmail
{
    BOOL done = NO;
	const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"Delete from Registration where CourseCode = \"%@\" and UserEmail = \"%@\" ",courseCode, userEmail];
        
        const char *insert_stmt = [insertSQL UTF8String];
		sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            done = YES;
        }
        else {
            done = NO;
        }
        
		
        sqlite3_reset(statement);
    }
    return done;

}

-(NSArray *) test
{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"select UserEmail, CourseCode from Registration"];
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        
        if (sqlite3_prepare_v2(database,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *personName= [[NSString alloc] initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 0)];
                NSLog(@"Nowww!code: %@",personName);
                [resultArray addObject:personName];
                //loadedCourse.courseCode = code;
                
                NSString *code = [[NSString alloc] initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 1)];
                NSLog(@"Nowww! %@",code);
                [resultArray addObject:code];
                //loadedCourse.courseName = name;
                
                //[courseList addObject:loadedCourse];
                
                //return resultArray;
            }
            
            sqlite3_reset(statement);
        }
    }
    return list;
}


@end