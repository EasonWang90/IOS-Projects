//
//  EventViewController.m
//  ClassBuddy
//
//  Created by Eason on 2015-03-27.
//  Copyright (c) 2015 Big data. All rights reserved.
//

#import "EventViewController.h"

@interface EventViewController ()

@end

@implementation EventViewController

@synthesize eventDueDate;

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
    [self setTitle:@"Event Info"];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    self.itemText.delegate = self;
    self.dueDate.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

-(void)save{
    [self.itemText resignFirstResponder];
    [self.dueDate resignFirstResponder];

    // Get the current date
    //self.datePicker.timeZone = [NSTimeZone localTimeZone];
    NSDate *pickerDate = [self.datePicker date];
    eventDueDate = [self.dueDatePicker date];
    
    // Schedule the notification
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = pickerDate;
    NSLog(@"%@",pickerDate.description);
    localNotification.alertBody = [NSString stringWithFormat:@"%@: %@",self.itemText.text,self.dueDate.text];
    //localNotification.
    localNotification.alertAction = @"Show me the Event";
    //localNotification.soundName = @"soundname";
    localNotification.timeZone = [NSTimeZone localTimeZone];
    //localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    [[self navigationController]popViewControllerAnimated:YES];
    // Request to reload table view data
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    
    // Dismiss the view controller
    //[self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.itemText resignFirstResponder];
    [self.dueDate resignFirstResponder];
    return YES;
}

@end
