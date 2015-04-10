//
//  EventListViewController.m
//  ClassBuddy
//
//  Created by Eason on 2015-03-26.
//  Copyright (c) 2015 Big data. All rights reserved.
//

#import "EventListViewController.h"

@interface EventListViewController ()
- (void)reloadTable;
@end

@implementation EventListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Event List"];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTable)
                                                 name:@"reloadData"
                                               object:nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)add{
    EventViewController *event = [[EventViewController alloc]initWithNibName:@"EventViewController" bundle:nil];
    UIViewController* next = event;
    
    
    [[self navigationController]pushViewController:next animated:YES];
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
    _numRows = [[[UIApplication sharedApplication] scheduledLocalNotifications] count];
    return _numRows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myCellId = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCellId];
    if( cell == nil )
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCellId];
    }
    // Get list of local notifications
    NSArray *localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    UILocalNotification *localNotification = [localNotifications objectAtIndex:indexPath.row];
    
    NSDateFormatter *outputDateFormatter = [[NSDateFormatter alloc] init];
    [outputDateFormatter setDateStyle:NSDateFormatterFullStyle];
    [outputDateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    NSString *outputString = [outputDateFormatter stringFromDate:localNotification.fireDate];
    // Display notification info
    [cell.textLabel setText:localNotification.alertBody];
    [cell.detailTextLabel setText:outputString];
    
    return cell;
}
- (void)reloadTable
{
    [self.tableView reloadData];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSArray *ipath = [NSArray arrayWithObject:indexPath];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
       // NSLog(@"%d",[[[UIApplication sharedApplication] scheduledLocalNotifications]count]);
        UILocalNotification *localNotification = [localNotifications objectAtIndex:indexPath.row];
       // NSLog(@"row:%d",[indexPath row]);
       // NSLog(@"%@",localNotification);
        //localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] - 1;
        [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
       // NSLog(@"%d",[[[UIApplication sharedApplication] scheduledLocalNotifications]count]);
        // Delete the row from the data source
        [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

@end
