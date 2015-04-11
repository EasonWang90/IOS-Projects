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
    [self.view insertSubview:self.logoView atIndex:0];
}
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.profilePictureView.profileID = nil;
    self.nameLabel.text = @"";
    self.statusLabel.text= @"Please log in!";
    [self.viewCourses setEnabled:false];
    [self.view insertSubview:self.logoView aboveSubview:self.profilePictureView];
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
