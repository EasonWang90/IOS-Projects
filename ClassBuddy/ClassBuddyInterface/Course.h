//
//  Course.h
//  ClassBuddyInterface
//
//  Created by Jon on 2015-03-26.
//  Copyright (c) 2015 CS212 Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Course : NSObject

@property (nonatomic) NSString *courseName;
@property (nonatomic) NSString *courseCode;
@property (nonatomic) NSString *courseTime;
@property (nonatomic) NSString *professor;
@property (nonatomic) NSString *location;

-(instancetype)initWithName:(NSString *)name CourseCode:(NSString *)courseCode CourseTime:(NSString *)courseTime Professor:(NSString *)professor Location:(NSString *)location;

-(BOOL)sameCourseCode: (Course *)course;
@end
