//
//  HomeViewController.h
//  ClassBuddyInterface
//
//  Created by Jonathan Cudmore on 2015-03-25.
//  Copyright (c) 2015 CS212 Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "DBManager.h"
#import "Person.h"

@interface HomeViewController : UIViewController <FBLoginViewDelegate>

@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet FBLoginView *loginView;
@property (nonatomic) DBManager* myDataBase;
@property (nonatomic) NSString* userEmail;
@property (nonatomic) NSArray* shownCourses;
@end
