//
//  NotificationsTableViewCell.m
//  portal
//
//  Created by Neil Ballard on 11/22/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import "NotificationsTableViewCell.h"
#import "DeviceManager.h"
#import "DataAccess.h"


@implementation NotificationsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //    self.imageView.frame = CGRectMake(0,0,34,34);
    
    //  self.backgroundView.frame = CGRectMake(0, 0, 40, 70);
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // configure control(s)
        self.backgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.backgroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.backgroundView];
        
        [self addProfileBackground];
        [self addProfileImage];
   //     [self addSnapchatBackground];
        [self setupNameLabel];
        [self setupNotificationLabel];
        
    }
    return self;
}


- (void)addProfileBackground {
    
    self.pickbackground = [[UIView alloc]initWithFrame:self.backgroundView.frame];
    
    self.pickbackground.backgroundColor = [self titleColor];
    self.pickbackground.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pickbackground invalidateIntrinsicContentSize];
    
    //  self.pickbackground.alpha = 2.0;
    
    
    self.pickbackground.layer.masksToBounds = NO;
    self.pickbackground.layer.shadowOffset = CGSizeMake(-.1, .2);
    self.pickbackground.layer.shadowRadius = .5;
    self.pickbackground.layer.shadowOpacity = 0.5;
    
    self.pickbackground.userInteractionEnabled = YES;
    
    
    [self addSubview:self.pickbackground];
    
    CGFloat pad = 0, height = 0;
    CGFloat width = 0, pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 8;
        height = 58;
        width = 58;
        pad2 = 20;
        self.pickbackground.layer.cornerRadius = 28;


    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 8;
        height = 68;
        width = 68;
        pad2 = 22;
        self.pickbackground.layer.cornerRadius = 32;


    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 8;
        height = 74;
        width = 76;
        pad2 = 23;
        self.pickbackground.layer.cornerRadius = 35;

        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 6;
        height = 58;
        width = 58;
        pad2 = 19;
        self.pickbackground.layer.cornerRadius = 28;

    }
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.pickbackground, @"top": self.backgroundView};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self addConstraints:constraint1];
    [self addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pickbackground attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pickbackground attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self addConstraint:constraint4];
    
}

- (void)addProfileImage {
    
    self.pic = [[UIImageView alloc]initWithFrame:self.pickbackground.frame];
    
    self.pic.backgroundColor = [UIColor blueColor];
    self.pic.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pic invalidateIntrinsicContentSize];
    
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"ProfileImage"];
    UIImage* image = [UIImage imageWithData:imageData];
    
    self.pic.layer.masksToBounds = YES;

    
    
    if (image != nil) {
        self.pic.image = [[DataAccess singletonInstance] getProfileImage];
    }else{
        self.pic.image = [UIImage imageNamed:@"image_placeholder.png"];
    }
    
    self.pic.alpha = 2.0;
    
    self.pic.userInteractionEnabled = YES;
    
    
    
    
    [self.pickbackground addSubview:self.pic];
    
    CGFloat pad = 0, height = 0, width = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 3;
        height = 52;
        width = 54;
        self.pic.layer.cornerRadius = 28;

    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 0;
        width = 63;
        height = 61;
        self.pic.layer.cornerRadius = 32;

    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 0;
        height = 68;
        width = 70;
        self.pic.layer.cornerRadius = 35;

    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 3;
        height = 52;
        width = 54;
        self.pic.layer.cornerRadius = 28;

    }
    
    
    
    
    
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.pickbackground attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.pic attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:self.pickbackground attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.pic attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];

    [self.pickbackground addConstraint:constraint1];
    [self.pickbackground addConstraint:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pic attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.pickbackground addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pic attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.pickbackground addConstraint:constraint4];
    
}



- (void)setupNameLabel {

    
    self.nameLabel = [[UILabel alloc] init];
    
    
    
    
    [self.nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.nameLabel invalidateIntrinsicContentSize];
    self.nameLabel.textColor = [UIColor blackColor];
    
    self.nameLabel.text = [[DataAccess singletonInstance] getName];
    
    CGFloat pad = 0, pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
     //   self.nameLabel.font = [UIFont systemFontOfSize:5];
        pad = 34;
        pad2 = 2;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
    //    self.nameLabel.font = [UIFont systemFontOfSize:5];
        pad = 40;
        pad2 = 2;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 44;
        pad2 = 1;
        self.nameLabel.font = [UIFont systemFontOfSize:20];

    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 31;
        pad2 = 1;
    //    self.nameLabel.font = [UIFont systemFontOfSize:4];

    }
    
    [self addSubview:self.nameLabel];
    
    NSDictionary *viewsDictionary = @{@"top":self.pickbackground, @"label" : self.nameLabel};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self addConstraints:constraint2];
    
}


- (void)setupNotificationLabel {
    // UIFont *font;
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    
    CGFloat height = 0;
    
    self.notificationLabel = [[UILabel alloc] init];
    
    self.notificationLabel.font = [UIFont systemFontOfSize:5];
    height = 15;
    
    CGFloat pad = 0, pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        self.notificationLabel.font = [UIFont fontWithName:@"Verdana" size:13.0f];
        pad = 24;
        pad2 = 17;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        self.notificationLabel.font = [UIFont fontWithName:@"Verdana" size:15.0f];
        pad = 28;
        pad2 = 21;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 30;
        pad2 = 24;
        self.notificationLabel.font = [UIFont fontWithName:@"Verdana" size:17.0f];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 23;
        pad2 = 16;
        self.notificationLabel.font = [UIFont fontWithName:@"Verdana" size:12.0f];
        
    }
    
    
    
    [self.notificationLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.notificationLabel invalidateIntrinsicContentSize];
    self.notificationLabel.textColor = [UIColor blackColor];
    
    [self addSubview:self.notificationLabel];
    
    NSDictionary *viewsDictionary = @{@"pic":self.pickbackground, @"label" : self.notificationLabel};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[pic]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self addConstraints:constraint2];
    
}




-(UIColor*)titleColor{
    
    return [UIColor colorWithRed:0.20 green:0.80 blue:1.00 alpha:1.0];
}

-(UIColor*)grayColor{
    
    return [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.0];
}

- (UIColor *) cdBlue {
    return [UIColor colorWithRed:0.00 green:0.59 blue:0.84 alpha:1.0];
}

- (UIColor *) cdNavBlue {
    return [UIColor colorWithRed:0.00 green:0.59 blue:0.85 alpha:1.0];
}
@end
