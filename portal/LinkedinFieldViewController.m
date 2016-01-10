//
//  LinkedinFieldViewController.m
//  portal
//
//  Created by Neil Ballard on 10/29/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import "LinkedinFieldViewController.h"
#import "DataAccess.h"
#import "LoginViewController.h"

@interface LinkedinFieldViewController ()

@property (nonatomic, retain) UIView * background;
@property (nonatomic, retain) UIView * Line;
@property (nonatomic, retain) UIView * firstLine;
@property (nonatomic, retain) UIImageView * background_image;
@property (nonatomic,unsafe_unretained) CGRect mainScreenBounds;
@property (nonatomic, retain) UINavigationBar * navBar;

@property (nonatomic, strong) IBOutlet UIButton *logoutButton;


@end

@implementation LinkedinFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mainScreenBounds = [[UIScreen mainScreen]bounds];
    
    
    self.background = [[UIView alloc] initWithFrame:self.mainScreenBounds];
    self.background.hidden = NO;
    self.background.backgroundColor = [self grayColor];
    self.background.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.background];
    
    
    [self styleNavBar];
    [self initViewItems];
    
    //   [self addLogo];
    
    //   [self setupTopLabel];
    [self setupnetworkLabel];
    [self addFirstLine];
    [self addLine];
    [self setLogoutBtn];
}

- (void)initViewItems {

    
    self.Line = [[UIView alloc] init];
    [self.view addSubview:self.Line];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)addLine{
    
    
    self.Line.backgroundColor = [self lineColor];
    
    CGFloat width = self.mainScreenBounds.size.width - 20;
    CGFloat height = 0;
    
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        height = 1;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        height = 1;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        height = 1;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad])
    {
        height = 1;
    }
    
    [self.Line setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.Line invalidateIntrinsicContentSize];
    
    UITextField *top = self.networkTextField;
    NSDictionary *viewsDictionary = @{@"top":top, @"line" : self.Line};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[line(width)]"
                                                                   options:0 metrics:@{@"width":[NSNumber numberWithFloat:width]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-25-[line]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
    /*
     [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.Line attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width]];
     */
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.Line attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height]];
}

- (void)setupnetworkLabel {
    UIFont *font;
    
    CGFloat height = 0;
    
    self.networksLabel = [[UILabel alloc] init];
    
    self.networksLabel.font = [UIFont systemFontOfSize:5];
    height = 15;
    
    
    
    [self.networksLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.networksLabel invalidateIntrinsicContentSize];
    self.networksLabel.font = font;
    self.networksLabel.textColor = [UIColor lightGrayColor];
    
    self.networksLabel.text = @"Linkedin";
    
    [self.view addSubview:self.networksLabel];
    
    NSDictionary *viewsDictionary = @{@"top":self.navBar, @"label" : self.networksLabel};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-17-[label]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-6-[label]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
}


- (void)addFirstLine{
    
    self.firstLine = [[UIView alloc]init];
    
    self.firstLine.backgroundColor = [self lineColor];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    self.firstLine.translatesAutoresizingMaskIntoConstraints = NO;
    [self.firstLine invalidateIntrinsicContentSize];
    
    
    
    [self.view addSubview:self.firstLine];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 2;
        height = 1;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 2;
        height = 1;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 2;
        height = 1;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 2;
        height = 1;
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"top":self.networksLabel, @"line": self.firstLine};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.firstLine attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[line]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.firstLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.firstLine attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
}


-(void)setLogoutBtn{
    
    
    self.logoutButton = [[UIButton alloc] init];
    self.logoutButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.logoutButton.backgroundColor = [self linkedinBlue];
    [self.logoutButton setTitle: @"Logout of Linkedin" forState: UIControlStateNormal];
    // Handle clicks on the button
    [self.logoutButton
     addTarget:self
     action:@selector(logoutPressed) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.logoutButton.alpha = 1.0;
    self.logoutButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    
    self.logoutButton.layer.cornerRadius = 3.0;
    
    self.logoutButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.logoutButton invalidateIntrinsicContentSize];
    
    CGFloat buttonWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 30;
    
    [self.logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.logoutButton.titleEdgeInsets = UIEdgeInsetsMake(15, 0, 15, 0);
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 10;
        height = 50;
        self.logoutButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 10;
        height = ceilf(103/2);
        self.logoutButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 10;
        height = ceilf(171/3);
        self.logoutButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:25];
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 10;
        height = 35;
        self.logoutButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    }
    
    
    [self.view addSubview:self.logoutButton];
    
    NSDictionary *viewsDictionary = @{@"LinkedButton" : self.logoutButton, @"line": self.Line};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.logoutButton attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[line]-pad-[LinkedButton]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.logoutButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.logoutButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:buttonWidth];
    [self.view addConstraint:constraint4];
    
    
    
}

-(void)logoutPressed
{
    [LISDKSessionManager clearSession];
    [[DataAccess singletonInstance] setUselinkedinOptionStatus:NO];
    [[DataAccess singletonInstance] setLinkedin:nil];
    
    if([[DataAccess singletonInstance] LoggedInWithLinkedin]){
        //   [self logoutSuccess:^ {
        //    dispatch_async(dispatch_get_main_queue(), ^{
        
        [[DataAccess singletonInstance] setisLoggedInWithLinkedin:NO];
        [[DataAccess singletonInstance] setUserLoginStatus:NO];
        
        LoginViewController *root = [[LoginViewController alloc] init];
        [self.navigationItem setHidesBackButton:YES];
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.navigationController pushViewController:root animated:YES];
        
    }
    else{
        NSLog(@"hit");

        [[DataAccess singletonInstance] setAddedLinkedin:NO];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
    
}

- (UIColor *) linkedinBlue
{
    return [UIColor colorWithRed:0.00 green:0.48 blue:0.71 alpha:1.0];
}


- (void)styleNavBar {
    
    CGFloat height = 0, ypad = 0;
    
    height = 64;
    ypad = 36;
    
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        height = 64;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        height = 70;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        height = 80;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        height = 55;
    }
    
    // 1. hide the existing nav bar
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    // 2. create a new nav bar and style it
    self.navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), height)];
    self.navBar.translucent = YES;
    // 3. add a new navigation item w/title to the new nav bar
    UINavigationItem *newItem = [[UINavigationItem alloc] init];
    self.navBar.backgroundColor = [UIColor whiteColor];
    
    
    UIImage *image = [[UIImage imageNamed:@"back_button"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(goback)];
    
    
    newItem.leftBarButtonItem = leftBtn;
    
 /*
    
    UIButton *titleView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [titleView setUserInteractionEnabled:NO];
    
    UIImage *connections_image = [[UIImage imageNamed:@"connections"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [titleView setBackgroundImage:connections_image forState:UIControlStateNormal];
    //    NSString *titleText = @"Name";
    //    [titleView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    //    [titleView setTitle:titleText forState:UIControlStateNormal];
    
    
    newItem.titleView = titleView;
    
    
    */
    
    
    // newItem.titleView = backView;
    // 4. add the nav bar to the main view
    [self.navBar setItems:@[newItem]];
    [self.view addSubview:self.navBar];
    
    
}


-(void)goback{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(UIColor*)grayColor{
    
    return [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.0];
}

-(UIColor*)lineColor{
    
    return [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.0];
    
    
}



@end
