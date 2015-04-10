//
//  Event.m
//  ClassBuddyInterface
//
//  Created by Jon on 2015-03-26.
//  Copyright (c) 2015 CS212 Group. All rights reserved.
//

#import "Event.h"

@implementation Event

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [self initWithName:@"" DueDate:@"" AlarmDate:@"" Finished:0 CourseCode:@"" userEmail:@""];
    }
    return self;
}

- (instancetype)initWithName: (NSString *)name
                     DueDate: (NSString *)dueDate
                   AlarmDate: (NSString *)alarmDate
                     Finished: (NSInteger )finished
                  CourseCode: (NSString *)code
                   userEmail: (NSString *)email
{
    if(self = [super init]) {
        _eventName = name;
        _dueDate = dueDate;
        _alarmDate = alarmDate;
        _finished = finished;
        _courseCode = code;
        _userEmail = email;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@", _eventName, _dueDate];
}

@end
