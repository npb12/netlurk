//
//  NotificationsTableViewCell.h
//  portal
//
//  Created by Neil Ballard on 11/22/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <linkedin-sdk/LISDK.h>


@interface NotificationsTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *pic;
@property (strong, nonatomic) IBOutlet UIView *pickbackground;


@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *notificationLabel;


@property (nonatomic, strong) NSString *linkedinId;
@property (nonatomic, strong) NSString *facebook;
@property (nonatomic, strong) NSString *instagram;
@property (nonatomic, strong) NSString *snapchat;

@end
