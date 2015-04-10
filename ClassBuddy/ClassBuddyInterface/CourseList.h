//
//  CourseList.h
//  ClassBuddyInterface
//
//  Created by Jon on 2015-03-27.
//  Copyright (c) 2015 CS212 Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Course;

@interface CourseList : NSObject

@property (nonatomic)NSArray *allCourses;

+(instancetype)sharedCourseList;
-(Course *)createCourseWithName:(NSString *)courseName CourseCode:(NSString *)courseCode CourseTime:(NSString *)courseTime Professor:(NSString *)professor Location:(NSString *)location;
-(void)removeCourse:(Course *)course;
-(void)addCourse:(Course *)course;
-(Course *)retrieveCourseAtIndex:(NSInteger)index;
-(void)moveItemAtIndex:(NSInteger)fromIndex ToIndex:(NSInteger)toIndex;

@end
