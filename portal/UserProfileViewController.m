//
//  UserProfileViewController.m
//  portal
//
//  Created by Neil Ballard on 12/29/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import "UserProfileViewController.h"
#import "DeviceManager.h"
#import "DataAccess.h"

@interface UserProfileViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *pic;
@property (strong, nonatomic) IBOutlet UIView *background;

@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect full = [[UIScreen mainScreen]bounds];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationItem setHidesBackButton:YES];
    self.background = [[UIView alloc] initWithFrame:full];
    self.background.hidden = NO;
    self.background.backgroundColor = [UIColor blackColor];
    self.background.contentMode = UIViewContentModeScaleAspectFill;
    
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack:)];
      [self.view addGestureRecognizer:tapGesture];
    [self.view addSubview:self.background];
    [self addProfileImage];
    [self addFacebookIcon];
    [self addInstagramIcon];
    [self addLinkedinIcon];
    [self addSnapchatIcon];
    [self setupNameLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
    [self.navigationItem setHidesBackButton:YES];
    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    
}

- (void)addProfileImage {
    
    self.pic = [[UIImageView alloc]init];
    
    self.pic.backgroundColor = [UIColor blueColor];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
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
    
    
    
    [self.view addSubview:self.pic];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 65;
        height = 434;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 70;
        height = 510;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 76;
        height = 550;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 60;
        height = 375;
    }
    

    
    
    if ([[DataAccess singletonInstance] LoggedInWithFB]) {
        self.pic.userInteractionEnabled = YES;
    }
    
    
    NSDictionary *viewsDictionary = @{@"image":self.pic};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.pic attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pic attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pic attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
    
    
    
    
    
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
        pad = 17;
        pad2 = 5;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        self.nameLabel.font = [UIFont systemFontOfSize:26];
        pad = 24;
        pad2 = 8;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 24;
        pad2 = 8;
        self.nameLabel.font = [UIFont systemFontOfSize:27];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 15;
        pad2 = 4;
        self.nameLabel.font = [UIFont systemFontOfSize:19];
        
    }
    
    self.nameLabel.alpha = 100.0;
    
    [self.pic addSubview:self.nameLabel];
    
    NSDictionary *viewsDictionary = @{@"bottom":self.facebookIcon, @"label" : self.nameLabel};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[label]-pad-[bottom]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
}



- (void)addFacebookIcon{
    
    self.facebookIcon = [[UIButton alloc]initWithFrame:self.pic.frame];
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
    
    
    
    
    [self.facebookIcon setBackgroundColor:[UIColor  clearColor]];
    
    
    
    
    self.facebookIcon.layer.masksToBounds = YES;
    
    
    
    
    [self.pic addSubview:self.facebookIcon];
    
    CGFloat pad = 0, height = 0, pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 15;
        height = 30;
        pad2 = 17;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 13;
        height = 37;
        pad2 = 24;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 15;
        height = 39;
        pad2 = 24;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 10;
        pad2 = 15;
        height = 20;
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"icon": self.facebookIcon};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[icon]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[icon]-pad-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.facebookIcon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.facebookIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint4];
    
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
    
    
    [self.pic addSubview:self.instagramIcon];
    
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
        
        height = 20;
        pad = 10;
        pad2 = 12;
        
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"icon": self.instagramIcon, @"fb": self.facebookIcon};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[fb]-pad-[icon]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[icon]-pad-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.instagramIcon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.instagramIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint4];
    
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
    
    
    
    
    
    
    
    
    
    
    
    [self.pic addSubview:self.linkedinIcon];
    
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
        
        height = 20;
        pad = 10;
        pad2 = 12;
        
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"icon": self.instagramIcon, @"link": self.linkedinIcon};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[icon]-pad-[link]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[link]-pad-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.linkedinIcon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.linkedinIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint4];
    
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
    
    
    
    UIImage *image = [UIImage imageNamed:@"snapchat_icon"];
    
    [self.snapchatIcon setBackgroundImage:image forState:UIControlStateNormal];
    
    [self.snapchatIcon setBackgroundColor:[UIColor  clearColor]];
    
    
    
    self.snapchatIcon.layer.masksToBounds = NO;
    //    self.socialbackground.layer.shadowOffset = CGSizeMake(-.1, .2);
    //    self.socialbackground.layer.shadowRadius = .5;
    //    self.socialbackground.layer.shadowOpacity = 0.5;
    
    
    [self.pic addSubview:self.snapchatIcon];
    
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
        
        height = 20;
        pad = 10;
        pad2 = 12;
        
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"icon": self.linkedinIcon, @"snap": self.snapchatIcon};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[icon]-pad-[snap]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[snap]-pad-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.snapchatIcon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.snapchatIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint4];
    
}


-(UIColor*)navColor{
    
    return [UIColor colorWithRed:0.0 green:172.0f/255.0f blue:237.0f/255.0f alpha:1.0];
}


-(IBAction)goBack:(id)sender{
    
    //[self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:NO];
    
}




@end
