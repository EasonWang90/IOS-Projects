//
//  CusTableViewCell.m
//  ClassBuddyInterface
//
//  Created by Eason on 2015-04-12.
//  Copyright (c) 2015 CS212 Group. All rights reserved.
//

#import "CusTableViewCell.h"

@implementation CusTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (UIView*)recursivelyFindConfirmationButtonInView:(UIView*)view
{
    for(UIView *subview in view.subviews) {
        if([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellDeleteConfirmationButton"]) return subview;
        UIView *recursiveResult = [self recursivelyFindConfirmationButtonInView:subview];
        if(recursiveResult) return recursiveResult;
    }
    return nil;
}

-(void)overrideConfirmationButtonColor
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *confirmationButton = [self recursivelyFindConfirmationButtonInView:self];
        if(confirmationButton) confirmationButton.backgroundColor = [UIColor colorWithRed:0.1 green:0.75 blue:0.9 alpha:0.6];
    });
}
@end
