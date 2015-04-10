//
//  ResetAlarmViewController.m
//  ClassBuddyInterface
//
//  Created by iOS Developer on 2015-04-09.
//  Copyright (c) 2015 CS212 Group. All rights reserved.
//

#import "ResetAlarmViewController.h"

@interface ResetAlarmViewController ()

@end

@implementation ResetAlarmViewController

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
    _eventName.text = _event.eventName;
    _dueDate.text = _event.dueDate;
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)save{
    NSDate *alarmDate = [self.alarm date];
    NSDateFormatter *outputDateFormatter = [[NSDateFormatter alloc] init];
    [outputDateFormatter setDateStyle:NSDateFormatterFullStyle];
    [outputDateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    NSString *alarmDateString = [outputDateFormatter stringFromDate:alarmDate];
    if([_myDataBase resetAlarmDate:alarmDateString CourseCode:_courseCode UserEmail:_userEmail EventName:_event.eventName])
       NSLog(@"Alarm reseted!");
    else
       NSLog(@"Alarm not reseted!");
    [[self navigationController]popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    
}
@end
