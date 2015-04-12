//
//  CreateCourseTableViewController.m
//  ClassBuddyInterface
//
//  Created by Jon on 2015-03-26.
//  Copyright (c) 2015 CS212 Group. All rights reserved.
//

#import "CreateCourseTableViewController.h"
#import "ConfirmCourseViewController.h"
#import "CourseList.h"
#import "Course.h"
#import "DBManager.h"
#import "CourseListTableViewController.h"
#import "MGSwipeButton.h"
#import "MGSwipeTableCell.h"

@interface CreateCourseTableViewController ()

@end

@implementation CreateCourseTableViewController

@synthesize initialCourseArray;
@synthesize filteredCourseArray;
@synthesize registeredCourses;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Registered"
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(returnToPrevious:)];
        [navItem setLeftBarButtonItem:leftBarButton];
        UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Create New" style:UIBarButtonItemStylePlain target:self action:@selector(courseView:)];
        [navItem setRightBarButtonItem:rightBarButton];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    initialCourseArray = [NSMutableArray arrayWithArray:[_myDataBase listAll]];
    registeredCourses = [[NSMutableArray alloc] initWithArray:[_myDataBase getRegisteredCourseList:_userEmail]];
    filteredCourseArray = initialCourseArray;
    [self filtArray];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundHome.png"]];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnToPrevious:(id)sender
{
    CourseListTableViewController *courseListTableViewController = [[CourseListTableViewController alloc] initWithStyle:UITableViewStylePlain];
    [courseListTableViewController setMyDatabase:_myDataBase];
    [courseListTableViewController setUserEmail:_userEmail];
    [self.navigationController pushViewController:courseListTableViewController animated:YES];
}

- (IBAction)courseView:(id)sender
{
    ConfirmCourseViewController *confirmCourseViewController = [[ConfirmCourseViewController alloc] init];
    confirmCourseViewController.myDataBase = _myDataBase;
    confirmCourseViewController.userEmail = _userEmail;
    [self.navigationController pushViewController:confirmCourseViewController animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [filteredCourseArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"createCourseCell";
    MGSwipeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
   
    if(cell == nil) {
        cell = [[MGSwipeTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    // First get the corresponding course
    Course *newCourse = [filteredCourseArray objectAtIndex:indexPath.row];
    
    // Set the cells attributes
    cell.textLabel.numberOfLines = 3;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:11];
    cell.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    cell.textLabel.text = newCourse.description;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", newCourse.professor, newCourse.location];
    
    // Set the right button for the cell and set up the callback to addRegisteredCourseAt...
    cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@" Add " backgroundColor:[UIColor colorWithRed:0.1 green:0.75 blue:0.9 alpha:0.6] callback:^BOOL(MGSwipeTableCell *sender){
        [self addRegisteredCourseAt:indexPath forTableView:tableView];
        return YES;
    }]];
    // Set the transition type to MGSwipeTransition3D
    cell.rightSwipeSettings.transition = MGSwipeTransition3D;
    
    // Return the cell
    return cell;
}

// Set the cell height for each cell in the table
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

-(void)addRegisteredCourseAt:(NSIndexPath *)indexPath forTableView:(UITableView *)tableView
{
    // Delete the row from the data source and add it to the Registered courses.
        Course *selectedCourse = [initialCourseArray objectAtIndex:indexPath.row];
        NSString *courseCode = selectedCourse.courseCode;
        
        [_myDataBase registerACourseCourseCode:courseCode UserEmail:_userEmail];
        [_myDataBase getRegisteredCourseList:_userEmail];
        [initialCourseArray removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (NSArray *)filtArray
{
    int j;
    for(j=0; j<[registeredCourses count]; j++)
    {
        Course *course1 = [registeredCourses objectAtIndex:j];
        
        for(id course2 in filteredCourseArray)
        {
            if ([course1 sameCourseCode:course2])
            {
                [filteredCourseArray removeObject:course2];
                break;
            }
        }
    }
    return filteredCourseArray;
}

@end
