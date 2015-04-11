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

@interface CreateCourseTableViewController ()

@end

/*
@implementation UITableViewCell (customdelete)

- (void)layoutSubviews
{
    [super layoutSubviews];
    UIColor *colour = [UIColor colorWithRed:0.1 green:0.75 blue:0.0 alpha:0.7];
    for (UIView *subview in self.subviews) {
        //iterate through subviews until UITableViewCellDeleteConfirmationView
        for(UIView *subview2 in subview.subviews){
            if ([NSStringFromClass([subview2 class]) isEqualToString:@"UITableViewCellDeleteConfirmationView"]) {
                //Set background to green
                ((UIView*)[subview2.subviews firstObject]).backgroundColor=colour;
            }
        }
    }
}

@end
/**/

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [filteredCourseArray count];
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Add";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"createCourseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
   
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    // First get the course
    Course *newCourse = [filteredCourseArray objectAtIndex:indexPath.row];
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:11];
    cell.textLabel.text = newCourse.description;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", newCourse.professor, newCourse.location];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source and add it to the Registered courses.
        //[[CourseList sharedCourseList] addCourse:[courseArray objectAtIndex:indexPath.row]];
        Course *selectedCourse = [initialCourseArray objectAtIndex:indexPath.row];
        NSString *courseCode = selectedCourse.courseCode;
        [_myDataBase registerACourseCourseCode:courseCode UserEmail:_userEmail];
        [_myDataBase getRegisteredCourseList:_userEmail];
        [initialCourseArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else /*** As of right now we aren't adding new rows ***/
        if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
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
/*
// Show Green colour when editing
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView reloadData];
}
*/

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
