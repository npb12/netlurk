//
//  UserProfileViewController.h
//  portal
//
//  Created by Neil Ballard on 12/29/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserProfileViewController : UIViewController

@property (nonatomic, strong) UINavigationBar *navBar;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contact_time;
@property (nonatomic, strong) UILabel *num_networks;

@property (nonatomic, strong) NSString *linkedinId;
@property (nonatomic, strong) NSString *facebook;
@property (nonatomic, strong) NSString *instagram;
@property (nonatomic, strong) NSString *snapchat;
@property (strong, nonatomic) IBOutlet UIView *socialbackground;

@property (strong, nonatomic) IBOutlet UIButton *facebookIcon;
@property (strong, nonatomic) IBOutlet UIButton *instagramIcon;
@property (strong, nonatomic) IBOutlet UIButton *linkedinIcon;
@property (strong, nonatomic) IBOutlet UIButton *snapchatIcon;


@end
