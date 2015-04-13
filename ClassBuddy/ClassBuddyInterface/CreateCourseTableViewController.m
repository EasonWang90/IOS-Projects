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
#import "CusTableViewCell.h"
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
        //searchResults = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    /*the search bar widht must be > 1, the height must be at least 44
     (the real size of the search bar)*/
    searchBar.delegate = self;
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    /*contents controller is the UITableViewController, this let you to reuse
     the same TableViewController Delegate method used for the main table.*/
    
    searchDisplayController.delegate = self;
    searchDisplayController.searchResultsDataSource = self;
    //set the delegate = self. Previously declared in ViewController.h
    
    self.tableView.tableHeaderView = searchBar;
    searchDisplayController.searchResultsDataSource = self;
    
    initialCourseArray = [NSMutableArray arrayWithArray:[_myDataBase listAll]];
    registeredCourses = [[NSMutableArray alloc] initWithArray:[_myDataBase getRegisteredCourseList:_userEmail]];
    filteredCourseArray = initialCourseArray;
    [self filtArray];
    
    self.searchResults = [NSMutableArray arrayWithCapacity:[self.filteredCourseArray count]];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundHome.png"]];
    self.isSearching = NO;
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
    if (self.isSearching == true)
    {
        return [self.searchResults count];
    }
    else
    {
        return [self.filteredCourseArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"createCourseCell";
    CusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
   
    if(cell == nil) {
        cell = [[CusTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    // First get the corresponding course
    
    
    // Set the cells attributes
    cell.textLabel.numberOfLines = 3;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:11];
    cell.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    if (self.isSearching == true && self.searchResults.count > 0) {
        Course *searchCourse = [self.searchResults objectAtIndex:indexPath.row];
        cell.textLabel.text = searchCourse.description;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", searchCourse.professor, searchCourse.location];
    } else {
        Course *newCourse = [filteredCourseArray objectAtIndex:indexPath.row];
        cell.textLabel.text = newCourse.description;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", newCourse.professor, newCourse.location];
    }
    
    // Set the right button for the cell and set up the callback to addRegisteredCourseAt...
    /*
    cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@" Add " backgroundColor:[UIColor colorWithRed:0.1 green:0.75 blue:0.9 alpha:0.6] callback:^BOOL(MGSwipeTableCell *sender){
        [self addRegisteredCourseAt:indexPath forTableView:tableView];
        return YES;
    }]];
     */
    // Set the transition type to MGSwipeTransition3D
    //cell.rightSwipeSettings.transition = MGSwipeTransition3D;
    
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
    NSLog(@"adding row:%d",indexPath.row);
    NSString *courseCode;
    Course *selectedCourse;
    if (self.searchResults.count > 0) {
        selectedCourse = [self.searchResults objectAtIndex:indexPath.row];
        courseCode = selectedCourse.courseCode;
        [self.searchResults removeObjectIdenticalTo:selectedCourse];
    }
    else{
        selectedCourse = [filteredCourseArray objectAtIndex:indexPath.row];
        courseCode = selectedCourse.courseCode;
    }
    [_myDataBase registerACourseCourseCode:courseCode UserEmail:_userEmail];
    [_myDataBase getRegisteredCourseList:_userEmail];
    [filteredCourseArray removeObjectIdenticalTo:selectedCourse];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSArray *ipath = [NSArray arrayWithObject:indexPath];
    if (editingStyle == UITableViewCellEditingStyleDelete){
        NSString *courseCode;
        Course *selectedCourse;
        if (self.searchResults.count > 0) {
            selectedCourse = [self.searchResults objectAtIndex:indexPath.row];
            courseCode = selectedCourse.courseCode;
            [self.searchResults removeObjectIdenticalTo:selectedCourse];
        }
        else{
            selectedCourse = [filteredCourseArray objectAtIndex:indexPath.row];
            courseCode = selectedCourse.courseCode;
        }
        [_myDataBase registerACourseCourseCode:courseCode UserEmail:_userEmail];
        [_myDataBase getRegisteredCourseList:_userEmail];
        [filteredCourseArray removeObjectIdenticalTo:selectedCourse];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
-(void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    CusTableViewCell *cell = (CusTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    [cell overrideConfirmationButtonColor];
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"Add";
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
- (void)filterListForSearchText:(NSString *)searchText
{
    [self.searchResults removeAllObjects]; //clears the array from all the string objects it might contain from the previous searches
    
    for (Course *course in self.filteredCourseArray) {
        NSString *courseCode = course.courseCode;
        NSRange nameRange = [courseCode rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if (nameRange.location != NSNotFound) {
            [self.searchResults addObject:course];
        }
    }
}
- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller {
    //When the user taps the search bar, this means that the controller will begin searching.
    self.isSearching = YES;
}

- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller {
    //When the user taps the Cancel Button, or anywhere aside from the view.
    self.isSearching = NO;
    [self.tableView reloadData];
}
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterListForSearchText:searchString];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterListForSearchText:[self.searchDisplayController.searchBar text]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

@end
