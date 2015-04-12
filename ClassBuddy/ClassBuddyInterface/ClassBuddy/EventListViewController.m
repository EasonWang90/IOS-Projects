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
    _unfinishedEventList = [NSMutableArray arrayWithArray:[_myDataBase getUnfinishedEvents:_userEmail CourseCode:_courseCode]];
        UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTable)
                                                 name:@"reloadData"
                                               object:nil];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundHome.png"]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)add{
    EventViewController *event = [[EventViewController alloc]initWithNibName:@"EventViewController" bundle:nil];
    event.myDataBase = _myDataBase;
    event.courseCode = _courseCode;
    event.userEmail = _userEmail;
    UIViewController* next = event;
    
    
    [[self navigationController]pushViewController:next animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_unfinishedEventList count];
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
    //NSArray *localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    //UILocalNotification *localNotification = [localNotifications objectAtIndex:indexPath.row];
    
    //NSDateFormatter *outputDateFormatter = [[NSDateFormatter alloc] init];
    //[outputDateFormatter setDateStyle:NSDateFormatterFullStyle];
    //[outputDateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    //NSString *outputString = [outputDateFormatter stringFromDate:localNotification.fireDate];
    // Display notification info
    
    Event *event = [_unfinishedEventList objectAtIndex:indexPath.row];
    NSString *labelText = [NSString stringWithFormat:@"%@ Due on %@", event.eventName, event.dueDate];
    NSString *subText = [NSString stringWithFormat:@"Alarm: %@",event.alarmDate];
    [cell.textLabel setText:labelText];
    [cell.detailTextLabel setText:subText];
    // Configure the cell...
    
    return cell;
}

- (void)reloadTable
{
    _unfinishedEventList = [NSMutableArray arrayWithArray:[_myDataBase getUnfinishedEvents:_userEmail CourseCode:_courseCode]];
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
       
        /*Set the finished from 0 to 1*/
        NSArray *localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
        NSLog(@"%lu",(unsigned long)[[[UIApplication sharedApplication] scheduledLocalNotifications]count]);
        long notificationCount =[[[UIApplication sharedApplication] scheduledLocalNotifications]count];
        if (notificationCount != 0) {
            UILocalNotification *localNotification = [localNotifications objectAtIndex:indexPath.row];
            NSLog(@"row:%lu",(long)[indexPath row]);
            // NSLog(@"%@",localNotification);
            //localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] - 1;
            [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
            NSLog(@"%lu",(unsigned long)[[[UIApplication sharedApplication] scheduledLocalNotifications]count]);
        }
        
        
        Event *event = [_unfinishedEventList objectAtIndex:indexPath.row];
        _finishedEvent = [_unfinishedEventList objectAtIndex:indexPath.row];
        if([_myDataBase finishedAnEvent:_courseCode UserEmail:_userEmail EventName:event.eventName])
        {
            //[_unfinishedEventList removeObjectIdenticalTo:event];
            NSLog(@"Event removed!");
        }
        else
            NSLog(@"Event not removed!");
        
        [_unfinishedEventList removeObjectIdenticalTo:event];
       
        
        // Delete the row from the data source
        
        [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Do you want to SHARE?" delegate:self cancelButtonTitle:@"Not this time" destructiveButtonTitle:nil otherButtonTitles:@"Facebook", nil];
        [actionSheet showInView:self.view];

        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"Finished";
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            [self FBPostStatus];
            break;
        default:
            break;
    }
}
- (void)performPublishAction:(void(^)(void))action {
    // we defer request for permission to post to the moment of post, then we check for the permission
    if ([FBSession.activeSession.permissions indexOfObject:@"publish_actions"] == NSNotFound) {
        // if we don't already have the permission, then we request it now
        [FBSession.activeSession requestNewPublishPermissions:@[@"publish_actions"]
                                              defaultAudience:FBSessionDefaultAudienceFriends
                                            completionHandler:^(FBSession *session, NSError *error) {
                                                if (!error) {
                                                    action();
                                                } else if (error.fberrorCategory != FBErrorCategoryUserCancelled) {
                                                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Permission denied"
                                                                                                        message:@"Unable to get permission to post"
                                                                                                       delegate:nil
                                                                                              cancelButtonTitle:@"OK"
                                                                                              otherButtonTitles:nil];
                                                    [alertView show];
                                                }
                                            }];
    } else {
        action();
    }
    
}
-(void)FBPostStatus{
    
    BOOL isSuccessful = NO;
    if (!isSuccessful) {
        [self performPublishAction:^{
            NSString *message = [NSString stringWithFormat:@"I successfully finished %@ %@ at %@. Thanks ClassBuddy!", _courseCode,_finishedEvent.eventName, _finishedEvent.alarmDate];
            
            FBRequestConnection *connection = [[FBRequestConnection alloc] init];
            
            connection.errorBehavior = FBRequestConnectionErrorBehaviorReconnectSession
            | FBRequestConnectionErrorBehaviorAlertUser
            | FBRequestConnectionErrorBehaviorRetry;
            
            [connection addRequest:[FBRequest requestForPostStatusUpdate:message]
                 completionHandler:^(FBRequestConnection *innerConnection, id result, NSError *error) {
                     [self showAlert:message result:result error:error];
                 }];
            [connection start];
        }];
    }

}

// UIAlertView helper for post buttons
- (void)showAlert:(NSString *)message
           result:(id)result
            error:(NSError *)error {
    
    NSString *alertMsg;
    NSString *alertTitle;
    if (error) {
        alertTitle = @"Error";
        // Since we use FBRequestConnectionErrorBehaviorAlertUser,
        // we do not need to surface our own alert view if there is an
        // an fberrorUserMessage unless the session is closed.
        if (error.fberrorUserMessage && FBSession.activeSession.isOpen) {
            alertTitle = nil;
            
        } else {
            // Otherwise, use a general "connection problem" message.
            alertMsg = @"Operation failed due to a connection problem, retry later.";
        }
    } else {
        NSDictionary *resultDict = (NSDictionary *)result;
        alertMsg = [NSString stringWithFormat:@"Successfully posted '%@'.", message];
        NSString *postId = [resultDict valueForKey:@"id"];
        if (!postId) {
            postId = [resultDict valueForKey:@"postId"];
        }
        if (postId) {
            alertMsg = [NSString stringWithFormat:@"%@\nPost ID: %@", alertMsg, postId];
        }
        alertTitle = @"Success";
    }
    
    if (alertTitle) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle
                                                            message:alertMsg
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
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


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    if ([localNotifications count] != 0) {
        UILocalNotification *localNotification = [localNotifications objectAtIndex:indexPath.row];
        NSLog(@"row:%ld",(long)[indexPath row]);
        // NSLog(@"%@",localNotification);
        //localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] - 1;
        [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
        NSLog(@"%lu",(unsigned long)[[[UIApplication sharedApplication] scheduledLocalNotifications]count]);
    }

    Event *selectedEvent = [_unfinishedEventList objectAtIndex:indexPath.row];
    ResetAlarmViewController * resetAlarmViewController = [[ResetAlarmViewController alloc] initWithNibName:@"ResetAlarmViewController" bundle:nil];
    resetAlarmViewController.event = selectedEvent;
    resetAlarmViewController.myDataBase = _myDataBase;
    resetAlarmViewController.courseCode = _courseCode;
    resetAlarmViewController.userEmail = _userEmail;
    [self.navigationController pushViewController:resetAlarmViewController animated:YES];

}


@end
