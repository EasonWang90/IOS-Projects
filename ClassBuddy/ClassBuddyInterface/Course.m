//
//  Course.m
//  ClassBuddyInterface
//
//  Created by Jon on 2015-03-26.
//  Copyright (c) 2015 CS212 Group. All rights reserved.
//

#import "Course.h"

@implementation Course

-(id)init
{
    if([super init]) {
       self = [self initWithName:@"" CourseCode:@"" CourseTime:@"" Professor:@"" Location:@""];
    }
    return self;
}

- (instancetype)initWithName:(NSString *)courseName CourseCode:(NSString *)courseCode CourseTime:(NSString *)courseTime Professor:(NSString *)professor Location:(NSString *)location
{
    if([super init]) {
        _courseName = courseName;
        _courseCode = courseCode;
        _courseTime = courseTime;
        _professor = professor;
        _location = location;
    }
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@ %@", _courseCode, _courseName, _courseTime];
}

-(void)dealloc
{
    NSLog(@"%@ deallocated", self.description);
}

-(BOOL)sameCourseCode: (Course *)course;
{
    if([self.courseCode isEqualToString:course.courseCode])
        return YES;
    else
        return FALSE;
}
@end
