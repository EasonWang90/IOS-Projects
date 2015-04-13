//
//  ConfirmCourseViewController.m
//  ClassBuddyInterface
//
//  Created by Jonathan Cudmore on 2015-03-25.
//  Copyright (c) 2015 CS212 Group. All rights reserved.
//

#import "ConfirmCourseViewController.h"
#import "CourseListTableViewController.h"
#import "EventViewController.h"
#import "EventListViewController.h"
#import "Course.h"
#import "CourseList.h"

@interface ConfirmCourseViewController ()

@end

@implementation ConfirmCourseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Return"
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(returnToPrevious:)];
        [navItem setLeftBarButtonItem:leftBarButton];
        UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Finish"
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:@selector(finish:)];
        [navItem setRightBarButtonItem:rightBarButton];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set the text fields delegate to self
    self.courseCodeField.delegate = self;
    self.courseNameField.delegate = self;
    self.dateTimeField.delegate = self;
    self.professorField.delegate = self;
    self.locationField.delegate = self;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundHome.png"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.courseCodeField resignFirstResponder];
    [self.courseNameField resignFirstResponder];
    [self.dateTimeField resignFirstResponder];
    [self.professorField resignFirstResponder];
    [self.locationField resignFirstResponder];
    
    return YES;
}

- (IBAction)returnToPrevious:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)finish:(id)sender
{
    if(!_course && _courseCodeField.text && _courseNameField.text && _locationField.text) {
        _course = [[Course alloc] initWithName:_courseNameField.text CourseCode:_courseCodeField.text CourseTime:_dateTimeField.text Professor:_professorField.text Location:_locationField.text];
        
        if([_myDataBase createNewCourse:_course])
            NSLog(@"Course created!");
        else
            NSLog(@"Course not created!");
        
        CreateCourseTableViewController *createCourseTableViewController = [[CreateCourseTableViewController alloc] init];
        createCourseTableViewController.myDataBase = _myDataBase;
        createCourseTableViewController.userEmail = _userEmail;
        [self.navigationController pushViewController:createCourseTableViewController animated:YES];
    }
}

@end
