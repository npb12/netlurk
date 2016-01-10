//
//  SwipeAlbumViewController.m
//  netlurk
//
//  Created by Neil Ballard on 1/4/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import "SwipeAlbumViewController.h"
#import "DataAccess.h"
#import "DeviceManager.h"

@interface SwipeAlbumViewController ()

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *tempView;
@property (nonatomic, assign) CGPoint offset;
@property (strong, nonatomic) IBOutlet UIImageView *pic;
@property (strong, nonatomic) IBOutlet UIImageView *pic2;
@property (strong, nonatomic) IBOutlet UIImageView *pic3;
@property (strong, nonatomic) IBOutlet UIImageView *pic4;

@end

@implementation SwipeAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
    [self.navigationItem setHidesBackButton:YES];
    CGRect fullScreenRect=[[UIScreen mainScreen] bounds];
    
    self.tempView = [[UIView alloc] init];
    [self.tempView setFrame:fullScreenRect];
    self.tempView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tempView removeFromSuperview];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack:)];
    [self.view addGestureRecognizer:tapGesture];
    
    
    self.tempView.backgroundColor = [UIColor blackColor];
    
    self.scrollView.delegate = self;
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.scrollView.backgroundColor = [UIColor blackColor];
    
    
    UIView *tempView = self.tempView;
    UIScrollView *scrollView = self.scrollView;
    
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(scrollView, tempView);
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.tempView];
    
    self.scrollView.pagingEnabled = YES;
    
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tempView]|" options:0 metrics: 0 views:viewsDictionary]];
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tempView]|" options:0 metrics: 0 views:viewsDictionary]];
    [self.tempView addConstraint:[NSLayoutConstraint constraintWithItem:self.tempView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:fullScreenRect.size.width * 4]];
    
    NSArray *scrollConstraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|" options:0 metrics:0 views:viewsDictionary];
    [self.view addConstraints:scrollConstraint1];
    NSArray *scrollConstraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:0 metrics: 0 views:viewsDictionary];
    [self.view addConstraints:scrollConstraint2];
    
    [self.scrollView setExclusiveTouch:NO];
    
    //   CGFloat contentHeightModifier = 0.0;
    CGFloat scroll_height = CGRectGetHeight([[UIScreen mainScreen] bounds]);
    CGFloat scroll_width = CGRectGetWidth([[UIScreen mainScreen] bounds]) * 4;
    
    
    
    [self.tempView addConstraint:[NSLayoutConstraint constraintWithItem:self.tempView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:scroll_height]];
    
    [self.tempView addConstraint:[NSLayoutConstraint constraintWithItem:self.tempView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:scroll_width]];
    
    self.scrollView.contentInset = UIEdgeInsetsMake(0.0,0.0,0.0,0.0);
    CGRect cRect = scrollView.bounds;
    self.scrollView.contentSize = CGSizeMake(cRect.origin.x, self.scrollView.bounds.size.height);
    self.scrollView.contentOffset = CGPointMake(self.scrollView.bounds.size.width, 0);
    
    
    [self addPhoto];
    [self addPhoto2];
    [self addPhoto3];
    [self addPhoto4];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addPhoto{
    
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
    
    
    
    [self.tempView addSubview:self.pic];
    
    CGFloat pad = 0, pad2 = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 65;
        height = 434;
        pad2 = 0;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 70;
        height = 510;
        pad2 = 0;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 76;
        height = 550;
        pad2 = 0;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 50;
        height = 375;
        pad2 = 0;
        
    }
    
    //    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(picturePressed:)];
    //  [self.pic addGestureRecognizer:tapGesture];
    
    
    if ([[DataAccess singletonInstance] LoggedInWithFB]) {
        self.pic.userInteractionEnabled = YES;
    }
    
    
    NSDictionary *viewsDictionary = @{@"image":self.pic};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.tempView addConstraints:constraint1];
    [self.tempView addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pic attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.tempView addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pic attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.tempView addConstraint:constraint4];
    
}


-(void)addPhoto2{
    
    self.pic2 = [[UIImageView alloc]init];
    
    self.pic2.backgroundColor = [UIColor blueColor];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    self.pic2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pic2 invalidateIntrinsicContentSize];
    
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"ProfileImage"];
    UIImage* image = [UIImage imageWithData:imageData];
    
    
    if (image != nil) {
        self.pic2.image = [[DataAccess singletonInstance] getProfileImage];
    }else{
        self.pic2.image = [UIImage imageNamed:@"image_placeholder.png"];
    }
    
    self.pic2.alpha = 2.0;
    
    
    
    [self.tempView addSubview:self.pic2];
    
    CGFloat pad = 0, pad2 = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 65;
        height = 434;
        pad2 = 0;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 70;
        height = 510;
        pad2 = 0;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 76;
        height = 550;
        pad2 = 0;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 50;
        height = 375;
        pad2 = 0;
        
    }
    
    //    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(picturePressed:)];
    //  [self.pic addGestureRecognizer:tapGesture];
    
    
    if ([[DataAccess singletonInstance] LoggedInWithFB]) {
        self.pic2.userInteractionEnabled = YES;
    }
    
    
    NSDictionary *viewsDictionary = @{@"image":self.pic2, @"pic1":self.pic};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[pic1]-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.tempView addConstraints:constraint1];
    [self.tempView addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pic2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.tempView addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pic2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.tempView addConstraint:constraint4];
    
}

-(void)addPhoto3{
    
    self.pic3 = [[UIImageView alloc]init];
    
    self.pic3.backgroundColor = [UIColor blueColor];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    self.pic3.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pic3 invalidateIntrinsicContentSize];
    
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"ProfileImage"];
    UIImage* image = [UIImage imageWithData:imageData];
    
    
    if (image != nil) {
        self.pic3.image = [[DataAccess singletonInstance] getProfileImage];
    }else{
        self.pic3.image = [UIImage imageNamed:@"image_placeholder.png"];
    }
    
    self.pic3.alpha = 2.0;
    
    
    
    [self.tempView addSubview:self.pic3];
    
    CGFloat pad = 0, pad2 = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 65;
        height = 434;
        pad2 = 0;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 70;
        height = 510;
        pad2 = 0;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 76;
        height = 550;
        pad2 = 0;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 50;
        height = 375;
        pad2 = 0;
        
    }
    
    //    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(picturePressed:)];
    //  [self.pic addGestureRecognizer:tapGesture];
    
    
    if ([[DataAccess singletonInstance] LoggedInWithFB]) {
        self.pic3.userInteractionEnabled = YES;
    }
    
    
    NSDictionary *viewsDictionary = @{@"image":self.pic3, @"pic2":self.pic2};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[pic2]-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.tempView addConstraints:constraint1];
    [self.tempView addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pic3 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.tempView addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pic3 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.tempView addConstraint:constraint4];
    
}

-(void)addPhoto4{
    
    self.pic4 = [[UIImageView alloc]init];
    
    self.pic4.backgroundColor = [UIColor blueColor];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    self.pic4.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pic4 invalidateIntrinsicContentSize];
    
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"ProfileImage"];
    UIImage* image = [UIImage imageWithData:imageData];
    
    
    if (image != nil) {
        self.pic4.image = [[DataAccess singletonInstance] getProfileImage];
    }else{
        self.pic4.image = [UIImage imageNamed:@"image_placeholder.png"];
    }
    
    self.pic4.alpha = 2.0;
    
    
    
    [self.tempView addSubview:self.pic4];
    
    CGFloat pad = 0, pad2 = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 65;
        height = 434;
        pad2 = 0;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 70;
        height = 510;
        pad2 = 0;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 76;
        height = 550;
        pad2 = 0;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 50;
        height = 375;
        pad2 = 0;
        
    }
    
    //    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(picturePressed:)];
    //  [self.pic addGestureRecognizer:tapGesture];
    
    
    if ([[DataAccess singletonInstance] LoggedInWithFB]) {
        self.pic4.userInteractionEnabled = YES;
    }
    
    
    NSDictionary *viewsDictionary = @{@"image":self.pic4, @"pic3":self.pic3};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[pic3]-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.tempView addConstraints:constraint1];
    [self.tempView addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pic4 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.tempView addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pic4 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.tempView addConstraint:constraint4];
    
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

-(IBAction)goBack:(id)sender{
    
    //[self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:NO];
}

@end
