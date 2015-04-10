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
    _courseArray = [[NSMutableArray alloc] initWithArray:[_myDatabase getRegisteredCourseList:_userEmail]];
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"AddedCourseCell"];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddedCourseCell" forIndexPath:indexPath];
    // Set the text on the cell to the courses description
    //NSArray *courses = [[CourseList sharedCourseList] allCourses];
    
    Course *course = [_courseArray objectAtIndex:indexPath.row];
    cell.textLabel.text = course.description;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", course.professor, course.courseTime];
    
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


/***********************************************************
 * Implement add, remove, and editing methods. Look in to 
 * the functionality for editing on touch. And changing 
 * the delete to ADD with a green background
 ***********************************************************/

/*
- (IBAction)returnHome:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


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


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
