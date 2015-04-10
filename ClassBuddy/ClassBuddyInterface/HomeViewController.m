//
//  HomeViewController.m
//  ClassBuddyInterface
//
//  Created by Jonathan Cudmore on 2015-03-25.
//  Copyright (c) 2015 CS212 Group. All rights reserved.
//

#import "HomeViewController.h"
#import "CourseListTableViewController.h"
#import "CreateCourseTableViewController.h"
#import "DBManager.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UIButton *viewCourses;
@property (weak, nonatomic) IBOutlet UIButton *addACourse;

@end

@implementation HomeViewController

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
    
    _myDataBase = [DBManager getSharedInstance];
    
    [self.navigationController setNavigationBarHidden:YES];
    [self.loginView setReadPermissions:@[@"public_profile", @"email", @"user_friends"]];
    self.loginView.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    self.profilePictureView.profileID = user.objectID;
    self.nameLabel.text = [NSString stringWithFormat:@"Hello %@", user.first_name];
    NSLog(@"email: %@", [user objectForKey:@"email"]);
    self.userEmail = [user objectForKey:@"email"];
}
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    self.statusLabel.text = @"You're logged in";
    [self.viewCourses setEnabled:true];
    [self.addACourse setEnabled:true];
}
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.profilePictureView.profileID = nil;
    self.nameLabel.text = @"";
    self.statusLabel.text= @"Please log in!";
    [self.viewCourses setEnabled:true];
    [self.addACourse setEnabled:true];
}

- (IBAction)addCourse:(id)sender
{
    [self.navigationController setNavigationBarHidden:NO];
    CreateCourseTableViewController *createCourseViewController = [[CreateCourseTableViewController alloc] init];
    [createCourseViewController setMyDataBase:_myDataBase];
    [createCourseViewController setUserEmail:_userEmail];
    [self.navigationController pushViewController:createCourseViewController animated:YES];
}

- (IBAction)courseList:(id)sender
{
    [self.navigationController setNavigationBarHidden:NO];
    CourseListTableViewController *courseListTableViewController = [[CourseListTableViewController alloc] initWithStyle:UITableViewStylePlain];
    [courseListTableViewController setMyDatabase:_myDataBase];
    [courseListTableViewController setUserEmail:_userEmail];
    [self.navigationController pushViewController:courseListTableViewController animated:YES];
}

@end
