//
//  Event.h
//  ClassBuddyInterface
//
//  Created by Jon on 2015-03-26.
//  Copyright (c) 2015 CS212 Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (nonatomic) NSInteger eventID;
@property (nonatomic) NSString *eventName;
@property (nonatomic) NSString *dueDate;
@property (nonatomic) NSString *alarmDate;
@property (nonatomic) NSInteger finished;
@property (nonatomic) NSString *courseCode;
@property (nonatomic) NSString *userEmail;

- (instancetype)initWithName: (NSString *)name
                     DueDate: (NSString *)dueDate
                   AlarmDate: (NSString *)alarmDate
                     Finished: (NSInteger )finished
                  CourseCode: (NSString *)code
                   userEmail: (NSString *)email;

@end
