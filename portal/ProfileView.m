//
//  ProfileView.m
//  netlurk
//
//  Created by Neil Ballard on 12/30/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import "ProfileView.h"

@implementation ProfileView

@synthesize pickbackground;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        
        self.flipsocial = NO;
        
        self.facebook = [[DataAccess singletonInstance] getFacebook];
        self.instagram = [[DataAccess singletonInstance] getInstagram];
        self.linkedinId = [[DataAccess singletonInstance] getLinkedin];
        self.snapchat = [[DataAccess singletonInstance] getSnapchat];
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        
        [self addProfileBackground];
        [self addProfileImage];
        [self addSocialBackground];
        [self setupNameLabel];
        [self setupdateLabel];
        [self addFacebookIcon];
        [self addInstagramIcon];
        [self addLinkedinIcon];
        [self addSnapchatIcon];
        
    }
    return self;
}

-(void)setupView
{
    self.layer.cornerRadius = 4;
    self.layer.shadowRadius = 3;
    self.layer.shadowOpacity = 0.2;
    self.layer.shadowOffset = CGSizeMake(1, 1);
}

- (void)addProfileBackground {
    
    self.pickbackground = [[UIView alloc]initWithFrame:self.frame];
    
    self.pickbackground.backgroundColor = [self grayColor];
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
    CGFloat width = 250;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 6;
        height = 425;
        width = 292;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 7;
        height= 455;
        width = 312;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 8;
        height = 508;
        width = 350;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 5;
        height = 311;
        width = 275;
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.pickbackground, @"top": self};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.pickbackground attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self addConstraint:constraint1];
    [self addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pickbackground attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pickbackground attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self addConstraint:constraint4];
    
}

- (void)addProfileImage {
    
    self.pic = [[UIImageView alloc]initWithFrame:self.pickbackground.frame];
    
    self.pic.backgroundColor = [UIColor blueColor];
    CGFloat width = 0;
    self.pic.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pic invalidateIntrinsicContentSize];
    
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"ProfileImage"];
    UIImage* image = [UIImage imageWithData:imageData];
    
    
    
    
    if (image != nil) {
        self.pic.image = [[DataAccess singletonInstance] getProfileImage];
    }else{
        self.pic.image = [UIImage imageNamed:@"image_placeholder.png"];
    }
    
    self.pic.alpha = 2.0;
    
    self.pic.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *socialTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(socialPressed:)];
    [self.pic addGestureRecognizer:socialTap];
    
    
    
    [self.pickbackground addSubview:self.pic];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 1;
        height = 423;
        width = 290;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 1;
        height = 453;
        width = 310;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 1;
        height = 506;
        width = 348;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 1;
        height = 309;
        width = 273;
    }
    
    
    
    
    
    NSDictionary *viewsDictionary = @{@"image":self.pic};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.pickbackground attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.pic attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.pickbackground addConstraint:constraint1];
    [self.pickbackground addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pic attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.pickbackground addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pic attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.pickbackground addConstraint:constraint4];
    
}

- (void)addSocialBackground {
    
    self.socialbackground = [[UIView alloc]initWithFrame:self.pic.frame];
    
    self.socialbackground.backgroundColor = [UIColor clearColor];//[self grayColor];
    //  CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 8;
    self.socialbackground.translatesAutoresizingMaskIntoConstraints = NO;
    [self.socialbackground invalidateIntrinsicContentSize];
    
    //   self.socialbackground.alpha = 0.1;
    self.socialbackground.layer.cornerRadius = 20;
    
    self.socialbackground.userInteractionEnabled = YES;
    
    
    
    self.socialbackground.layer.masksToBounds = NO;
    self.socialbackground.layer.shadowOffset = CGSizeMake(-.1, .2);
    self.socialbackground.layer.shadowRadius = .5;
    self.socialbackground.layer.shadowOpacity = 0.5;
    
    UITapGestureRecognizer *socialTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(socialPressed:)];
    [self.socialbackground addGestureRecognizer:socialTap];
    
    
    
    
    [self.pic addSubview:self.socialbackground];
    
    CGFloat pad = 0, pad2 = 0, height = 0, width = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 10;
        pad2 = 5;
        height = 60;
        width = 190;
        self.socialbackground.layer.cornerRadius = 20;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 8;
        pad2 = 5;
        height = 60;
        width = 220;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 8;
        height = 65;
        width = 225;
        pad2 = 5;
        
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 8;
        pad2 = 5;
        height = 45;
        width = 160;
        self.socialbackground.layer.cornerRadius = 15;
        
    }
    
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.socialbackground, @"top": self.pickbackground};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[back]-pad-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self addConstraints:constraint1];
    [self addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.socialbackground attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.socialbackground attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self addConstraint:constraint4];
    
}

- (void)setupNameLabel {
    
    
    self.nameLabel = [[UILabel alloc] init];
    [self.nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.nameLabel invalidateIntrinsicContentSize];
    self.nameLabel.textColor = [UIColor whiteColor];
    
    self.nameLabel.text = [[DataAccess singletonInstance] getName];
    
    self.nameLabel.text = [self.nameLabel.text stringByAppendingString:@", 24"];
    
    self.nameLabel.layer.shadowRadius = 3.0;
    self.nameLabel.layer.shadowOpacity = 0.5;
    
    self.nameLabel.layer.masksToBounds = NO;
    
    self.nameLabel.layer.shouldRasterize = YES;
    
    CGFloat pad = 0, pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        self.nameLabel.font = [UIFont systemFontOfSize:24];
        pad = 7;
        pad2 = 5;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        self.nameLabel.font = [UIFont systemFontOfSize:26];
        pad = 8;
        pad2 = 8;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 9;
        pad2 = 8;
        self.nameLabel.font = [UIFont systemFontOfSize:27];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 6;
        pad2 = 4;
        self.nameLabel.font = [UIFont systemFontOfSize:19];
        
    }
    
    self.nameLabel.alpha = 100.0;
    
    [self.socialbackground addSubview:self.nameLabel];
    
    NSDictionary *viewsDictionary = @{@"top":self.pic, @"label" : self.nameLabel};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self addConstraints:constraint2];
    
}


- (void)setupdateLabel {
    
    
    self.contact_time = [[UILabel alloc] init];
    
    
    
    
    [self.contact_time setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contact_time invalidateIntrinsicContentSize];
    self.contact_time.textColor = [UIColor whiteColor];
    
    self.contact_time.text = @"Encountered an hour ago";
    
    self.contact_time.layer.shadowRadius = 3.0;
    self.contact_time.layer.shadowOpacity = 0.5;
    
    self.contact_time.layer.masksToBounds = NO;
    
    self.contact_time.layer.shouldRasterize = YES;
    
    CGFloat pad = 0, pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        self.contact_time.font = [UIFont systemFontOfSize:14];
        pad = 7;
        pad2 = 7;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        self.contact_time.font = [UIFont systemFontOfSize:15];
        pad = 8;
        pad2 = 6;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 9;
        pad2 = 7;
        self.contact_time.font = [UIFont systemFontOfSize:17];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 6;
        pad2 = 5;
        self.contact_time.font = [UIFont systemFontOfSize:11];
        //    self.nameLabel.font = [UIFont systemFontOfSize:4];
        
    }
    
    [self.socialbackground addSubview:self.contact_time];
    
    NSDictionary *viewsDictionary = @{@"label" : self.contact_time};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[label]-pad-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self addConstraints:constraint2];
    
}

- (void)addFacebookIcon{
    
    self.facebookIcon = [[UIButton alloc]initWithFrame:self.socialbackground.frame];
    UIImage *image = [UIImage imageNamed:@"facebook_icon"];
    
    self.facebookIcon.backgroundColor = [UIColor blackColor];
    //  CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 8;
    self.facebookIcon.translatesAutoresizingMaskIntoConstraints = NO;
    [self.facebookIcon invalidateIntrinsicContentSize];
    
    [self.facebookIcon setBackgroundImage:image forState:UIControlStateNormal];
    
    if (self.facebook != nil && [[DataAccess singletonInstance] useFBOption]) {
        self.facebookIcon.userInteractionEnabled = YES;
        [self.facebookIcon
         addTarget:self
         action:@selector(FacebookButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        self.facebookIcon.alpha = 100.0;
        self.facebookIcon.layer.shadowOffset = CGSizeMake(-.1, .2);
        self.facebookIcon.layer.shadowRadius = 4.0;
        self.facebookIcon.layer.shadowOpacity = 0.5;
    }else{
        self.facebookIcon.userInteractionEnabled = NO;
        self.facebookIcon.alpha = 0.2;
    }
    
    self.facebookIcon.hidden = YES;
    
    
    
    [self.facebookIcon setBackgroundColor:[UIColor  clearColor]];
    
    
    
    
    self.facebookIcon.layer.masksToBounds = YES;
    
    
    
    
    [self addSubview:self.facebookIcon];
    
    CGFloat pad = 0, height = 0, pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 15;
        height = 30;
        pad2 = 27;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 13;
        height = 37;
        pad2 = 13;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 15;
        height = 39;
        pad2 = 15;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 10;
        pad2 = 12;
        height = 28;
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"icon": self.facebookIcon};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[icon]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[icon]-pad-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self addConstraints:constraint1];
    [self addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.facebookIcon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.facebookIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self addConstraint:constraint4];
    
}

- (void)addInstagramIcon{
    
    self.instagramIcon = [[UIButton alloc]init];
    
    self.instagramIcon.backgroundColor = [UIColor blackColor];
    //  CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 8;
    self.instagramIcon.translatesAutoresizingMaskIntoConstraints = NO;
    [self.instagramIcon invalidateIntrinsicContentSize];
    
    UIImage *image = [UIImage imageNamed:@"instagram_icon"];
    
    [self.instagramIcon setBackgroundColor:[UIColor  clearColor]];
    [self.instagramIcon setBackgroundImage:image forState:UIControlStateNormal];
    
    self.instagramIcon.hidden = YES;
    
    
    if (self.instagram != nil) {
        
        self.instagramIcon.alpha =100.0;
        self.instagramIcon.userInteractionEnabled = YES;
        [self.instagramIcon
         addTarget:self
         action:@selector(InstagramButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        self.instagramIcon.layer.shadowOffset = CGSizeMake(-.1, .2);
        self.instagramIcon.layer.shadowRadius = 4.0;
        self.instagramIcon.layer.shadowOpacity = 0.5;
        
    }else{
        self.instagramIcon.userInteractionEnabled = NO;
        self.instagramIcon.alpha = 0.2;
    }
    
    
    
    self.instagramIcon.layer.masksToBounds = NO;
    //    self.socialbackground.layer.shadowOffset = CGSizeMake(-.1, .2);
    //    self.socialbackground.layer.shadowRadius = .5;
    //    self.socialbackground.layer.shadowOpacity = 0.5;
    
    [self.instagramIcon
     addTarget:self
     action:@selector(InstagramButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self addSubview:self.instagramIcon];
    
    CGFloat pad = 0, pad2 = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 15;
        height = 30;
        pad2 = 15;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 13;
        height = 37;
        pad2 = 13;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 15;
        height = 39;
        pad2 = 13;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 10;
        height = 28;
        pad2 = 8;
        
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"icon": self.instagramIcon, @"fb": self.facebookIcon};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[fb]-pad-[icon]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[icon]-pad-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self addConstraints:constraint1];
    [self addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.instagramIcon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.instagramIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self addConstraint:constraint4];
    
}


- (void)addLinkedinIcon{
    
    self.linkedinIcon = [[UIButton alloc]init];
    
    self.linkedinIcon.backgroundColor = [UIColor blackColor];
    //  CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 8;
    self.linkedinIcon.translatesAutoresizingMaskIntoConstraints = NO;
    [self.linkedinIcon invalidateIntrinsicContentSize];
    
    UIImage *image = [UIImage imageNamed:@"linkedin_icon"];
    
    [self.linkedinIcon setBackgroundImage:image forState:UIControlStateNormal];
    
    [self.linkedinIcon setBackgroundColor:[UIColor  clearColor]];
    
    self.linkedinIcon.hidden = YES;
    self.linkedinIcon.layer.masksToBounds = NO;
    
    
    if (self.linkedinId != nil && [[DataAccess singletonInstance] uselinkedinOption]) {
        
        self.linkedinIcon.alpha =100.0;
        self.linkedinIcon.userInteractionEnabled = YES;
        [self.linkedinIcon
         addTarget:self
         action:@selector(LinkedinButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        self.linkedinIcon.layer.shadowOffset = CGSizeMake(-.1, .2);
        self.linkedinIcon.layer.shadowRadius = 4.0;
        self.linkedinIcon.layer.shadowOpacity = 0.5;
        
    }else{
        self.linkedinIcon.userInteractionEnabled = NO;
        self.linkedinIcon.alpha = 0.2;
    }
    
    
    [self addSubview:self.linkedinIcon];
    
    CGFloat pad = 0, height = 0 , pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 15;
        height = 30;
        pad2 = 15;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 13;
        height = 37;
        pad2 = 13;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 15;
        height = 39;
        pad2 = 13;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 10;
        height = 28;
        pad2 = 8;
        
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"icon": self.instagramIcon, @"link": self.linkedinIcon};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[icon]-pad-[link]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[link]-pad-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self addConstraints:constraint1];
    [self addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.linkedinIcon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.linkedinIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self addConstraint:constraint4];
    
}





- (void)addSnapchatIcon{
    
    self.snapchatIcon = [[UIButton alloc]init];
    
    self.snapchatIcon.backgroundColor = [UIColor blackColor];
    //  CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 8;
    self.snapchatIcon.translatesAutoresizingMaskIntoConstraints = NO;
    [self.snapchatIcon invalidateIntrinsicContentSize];
    
    
    if (self.snapchat != nil) {
        
        self.snapchatIcon.alpha =100.0;
        self.snapchatIcon.userInteractionEnabled = YES;
        [self.snapchatIcon
         addTarget:self
         action:@selector(SnapchatButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        self.snapchatIcon.layer.shadowOffset = CGSizeMake(-.1, .2);
        self.snapchatIcon.layer.shadowRadius = 4.0;
        self.snapchatIcon.layer.shadowOpacity = 0.5;
        
    }else{
        self.snapchatIcon.userInteractionEnabled = NO;
        self.snapchatIcon.alpha = 0.2;
    }
    
    self.snapchatIcon.hidden = YES;
    
    
    
    UIImage *image = [UIImage imageNamed:@"snapchat_icon"];
    
    [self.snapchatIcon setBackgroundImage:image forState:UIControlStateNormal];
    
    [self.snapchatIcon setBackgroundColor:[UIColor  clearColor]];
    
    
    
    self.snapchatIcon.layer.masksToBounds = NO;
    //    self.socialbackground.layer.shadowOffset = CGSizeMake(-.1, .2);
    //    self.socialbackground.layer.shadowRadius = .5;
    //    self.socialbackground.layer.shadowOpacity = 0.5;
    
    
    [self addSubview:self.snapchatIcon];
    
    CGFloat pad = 0, height = 0, pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 15;
        height = 30;
        pad2 = 15;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 13;
        height = 38;
        pad2 = 13;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 15;
        height = 39;
        pad2 = 13;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 10;
        height = 28;
        pad2 = 8;
        
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"icon": self.linkedinIcon, @"snap": self.snapchatIcon};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[icon]-pad-[snap]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[snap]-pad-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self addConstraints:constraint1];
    [self addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.snapchatIcon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.snapchatIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self addConstraint:constraint4];
    
}



- (void)socialPressed:(id)sender {
    
    /*
     CALayer *layer = self.socialbackground.layer;
     CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
     rotationAndPerspectiveTransform.m34 = 1.0 / -1000;
     // rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, M_PI / 0.3, 0.0f, 1.0f, 0.0f);
     rotationAndPerspectiveTransform = CATransform3DMakeRotation(M_PI, 1.0f, 0.0f, 0.0f);
     layer.transform = rotationAndPerspectiveTransform;
     [UIView animateWithDuration:0.3 animations:^{
     layer.transform = CATransform3DIdentity;
     
     }];  */
    
    
    if (self.flipsocial == YES) {
        self.flipsocial = NO;
        self.nameLabel.hidden = NO;
        self.contact_time.hidden = NO;
        self.facebookIcon.hidden = YES;
        self.instagramIcon.hidden = YES;
        self.linkedinIcon.hidden = YES;
        self.snapchatIcon.hidden = YES;
        self.socialbackground.hidden = NO;
        
    }else{
        self.flipsocial = YES;
        self.facebookIcon.hidden = NO;
        self.instagramIcon.hidden = NO;
        self.linkedinIcon.hidden = NO;
        self.snapchatIcon.hidden = NO;
        self.nameLabel.hidden = YES;
        self.contact_time.hidden = YES;
        self.socialbackground.hidden = YES;
        
        
    }
    
    
    
    
}

-(void)FacebookButtonClicked{
    
    //    NSString *facebook =  [[DataAccess singletonInstance] getFacebook];
    
    NSString *url = @"fb://profile/";
    //  NSURL *bUrl = [NSURL URLWithString:url];
    //  NSURL *fbURL = [bUrl URLByAppendingPathComponent:facebook];
    
    NSURL *fbURL = [NSURL URLWithString:url];
    
    NSLog(@"%@", fbURL);
    
    //    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
    NSLog(@"trying to open");
    [[UIApplication sharedApplication] openURL:fbURL];
    //   }
    
    // fb://profile/<id>
}


-(void)InstagramButtonClicked{
    
    NSString *insta =  [[DataAccess singletonInstance] getInstagram];
    
    NSString *url = @"instagram://user?username=";
    NSString *bURL = [url stringByAppendingString:insta];
    NSURL *instagramURL = [NSURL URLWithString:bURL];
    //NSURL *instagramURL = [bUrl URLByAppendingPathComponent:insta];
    
    NSLog(@"%@", instagramURL);
    
    //    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
    NSLog(@"trying to open");
    [[UIApplication sharedApplication] openURL:instagramURL];
    //   }
    
}



-(void)LinkedinButtonClicked{
    
    //    NSURL *linkURL = [NSURL URLWithString:@"linkedin://#profile/45b862b6"];
    //    [[UIApplication sharedApplication] openURL:linkURL];
    
    
    
    [[LISDKDeeplinkHelper sharedInstance] viewOtherProfile:self.linkedinId withState:self.linkedinId showGoToAppStoreDialog:YES success:nil error:nil];
    
}

-(void)SnapchatButtonClicked{
    
    self.snapchatlabel.hidden = NO;
    self.snapchatbackground.hidden = NO;
    
    
}

//UI Colors

-(UIColor*)grayColor{
    
    return [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.0];
}

-(UIColor*)titleColor{
    
    return [UIColor colorWithRed:0.20 green:0.80 blue:1.00 alpha:1.0];
}


-(UIColor*)backgroundColor{
    
    return [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0];
    
    
}

//

-(UIColor*)lineColor{
    
    return [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.0];
    
    
}

@end
