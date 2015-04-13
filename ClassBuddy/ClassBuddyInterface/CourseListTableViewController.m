//
//  CourseListTableViewController.m
//  ClassBuddyInterface
//
//  Created by Jonathan Cudmore on 2015-03-25.
//  Copyright (c) 2015 CS212 Group. All rights reserved.
//

#import "CourseListTableViewController.h"
#import "HomeViewController.h"
#import "CreateCourseTableViewController.h"
#import "CourseViewController.h"
#import "Course.h"
#import "CourseList.h"

@interface CourseListTableViewController ()

@end

@implementation CourseListTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Registered Courses";
        UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                             target:self
                                                                             action:@selector(addNewItem:)];
        // Set this bar button item as the right item in the navigationItem
        navItem.rightBarButtonItem = rightBarButton;
        //Create and set the leftBarButtonItem
        UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Home"
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(returnHome:)];
        navItem.leftBarButtonItem = leftBarButton;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _courseArray = [[NSMutableArray alloc] initWithArray:[_myDatabase getRegisteredCourseList:_userEmail]];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"AddedCourseCell"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundHome.png"]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_courseArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddedCourseCell"];
    // Get the course and setup the cell accessory
    Course *course = [_courseArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    // Add the course code label to the cells view
    UILabel *courseCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
    [courseCodeLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:16]];
    [courseCodeLabel center];
    courseCodeLabel.text = course.courseCode;
    [cell.contentView addSubview:courseCodeLabel];
    
    
    // Set up the rest of the cell
    UILabel *courseDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, 235, 60)];
    courseDescLabel.numberOfLines = 3;
    courseDescLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    courseDescLabel.text = [NSString stringWithFormat:@"%@, %@", course.courseName, course.courseTime];
    [courseDescLabel center];
    [cell.contentView addSubview:courseDescLabel];
    // Set the background to be transparent
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Course *selectedCourse = [_courseArray objectAtIndex: indexPath.row];
    CourseViewController *courseViewController = [[CourseViewController alloc] init];
    courseViewController.course = selectedCourse;
    courseViewController.myDataBase = _myDatabase;
    courseViewController.userEmail = _userEmail;
    [self.navigationController pushViewController:courseViewController animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (IBAction)addNewItem:(id)sender
{
    CreateCourseTableViewController *createCourseViewController = [[CreateCourseTableViewController alloc] init];
    [createCourseViewController setMyDataBase:_myDatabase];
    [createCourseViewController setUserEmail:_userEmail];
    [self.navigationController pushViewController:createCourseViewController animated:YES];
}

- (IBAction)returnHome:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Course *selectedCourse = [_courseArray objectAtIndex:indexPath.row];
        if([_myDatabase deleteACourse:selectedCourse.courseCode UserEmail:_userEmail])
        {
            NSLog(@"Course deleted!");
        }
        else
            NSLog(@"Course Not Deleted!");
        
        [_courseArray removeObjectIdenticalTo:selectedCourse];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

@end
