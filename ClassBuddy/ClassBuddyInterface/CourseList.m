//
//  CourseList.m
//  ClassBuddyInterface
//
//  Created by Jon on 2015-03-27.
//  Copyright (c) 2015 CS212 Group. All rights reserved.
//

#import "CourseList.h"
#import "Course.h"

@interface CourseList ()

@property (nonatomic)NSMutableArray *privateCourseList;

@end

@implementation CourseList

+(instancetype)sharedCourseList
{
    static CourseList *sharedCourseList;
    
    // If no sharedCourseList create one
    if (!sharedCourseList) {
        sharedCourseList = [[self alloc] initPrivate];
    }
    
    return sharedCourseList;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[CourseList sharedCourseList]" userInfo:nil];
}

- (instancetype) initPrivate
{
    if ([super init]) {
        _privateCourseList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)allCourses
{
    // Return an immutable copy of the array
    // so that it is not modified elsewhere
    return [self.privateCourseList copy];
}

- (void)moveItemAtIndex:(NSInteger)fromIndex ToIndex:(NSInteger)toIndex
{
    // Don't perform any operations if the course remains in the same place
    if(fromIndex == toIndex)
        return;
    else {
        Course *course = _privateCourseList[fromIndex];
        // Remove the item and then reinsert it into its new position
        [_privateCourseList removeObjectIdenticalTo:course];
        [_privateCourseList insertObject:course atIndex:toIndex];
    }
}

- (void)addCourse:(Course *)course
{
    [self.privateCourseList addObject:course];
}

- (Course *)createCourseWithName:(NSString *)courseName CourseCode:(NSString *)courseCode CourseTime:(NSString *)courseTime Professor:(NSString *)professor Location:(NSString *)location
{
    // Create the course and add it to the courseList
    Course *course = [[Course alloc] initWithName:courseName CourseCode:courseCode CourseTime:courseTime Professor:professor Location:location];
    [_privateCourseList addObject:course];
    return course;
}

- (Course *)retrieveCourseAtIndex:(NSInteger)index
{
    Course *course = _privateCourseList[index];
    return course;
}

- (void)removeCourse:(Course *)course
{
    // Remove the course from the courseList
    [_privateCourseList removeObjectIdenticalTo:course];
}

@end
