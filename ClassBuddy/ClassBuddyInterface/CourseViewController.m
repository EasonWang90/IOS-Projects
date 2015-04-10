//
//  CourseViewController.m
//  ClassBuddyInterface
//
//  Created by iOS Developer on 2015-03-29.
//  Copyright (c) 2015 CS212 Group. All rights reserved.
//

#import "CourseViewController.h"
#import "Course.h"

@interface CourseViewController ()

@property (weak, nonatomic) IBOutlet UILabel *courseIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *professorLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end

@implementation CourseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // Set Labels here
    if(_course) {
        self.courseIdLabel.text = _course.courseCode;
        self.courseNameLabel.text = _course.courseName;
        self.courseTimeLabel.text = _course.courseTime;
        self.professorLabel.text = _course.professor;
        self.locationLabel.text = _course.location;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addEvents:(id)sender
{
    EventViewController *eventViewController = [[EventViewController alloc] initWithNibName:@"EventViewController" bundle:nil];
   
    eventViewController.myDataBase = _myDataBase;
    eventViewController.courseCode = _course.courseCode;
    eventViewController.userEmail = _userEmail;
    [self.navigationController pushViewController:eventViewController animated:YES];
}

- (IBAction)showEvents:(id)sender
{
    EventListViewController *eventList = [[EventListViewController alloc] init];
    eventList.myDataBase = _myDataBase;
    eventList.courseCode = _course.courseCode;
    eventList.userEmail = _userEmail;
    [self.navigationController pushViewController:eventList animated:YES];
}

@end
