//
//  AccountViewController.m
//  portal
//
//  Created by Neil Ballard on 10/10/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import "AccountViewController.h"
#import "DeviceManager.h"
#import "AlbumsTableViewController.h"
#import "DataAccess.h"
#import "InstagramFieldViewController.h"
#import "LinkedinFieldViewController.h"
#import "SnapchatFieldViewController.h"
#import "AccountTableViewCell.h"
#import "FacebookFieldViewController.h"
#import "ProfileViewController.h"
#import "FBAccountViewController.h"
#import "LinkedinAccountViewController.h"
#import "HomeViewController.h"


@interface AccountViewController ()

@property (nonatomic, retain) UIView * background;
@property (strong, nonatomic) IBOutlet UIImageView *pic;
@property (strong, nonatomic) IBOutlet UIView *topbackground;
@property (strong, nonatomic) IBOutlet UIView *pickbackground;
@property (strong, nonatomic) IBOutlet UIImageView *fb_logo;
@property (strong, nonatomic) IBOutlet UIImageView *insta_logo;
@property (strong, nonatomic) IBOutlet UIImageView *linkedin_logo;
@property (strong, nonatomic) IBOutlet UIImageView *snapchat_logo;

@property (strong, nonatomic) IBOutlet UIImageView *pic2;
@property (strong, nonatomic) IBOutlet UIView *pickbackground2;
@property (strong, nonatomic) IBOutlet UIImageView *pic3;
@property (strong, nonatomic) IBOutlet UIView *pickbackground3;
@property (strong, nonatomic) IBOutlet UIImageView *pic4;
@property (strong, nonatomic) IBOutlet UIView *pickbackground4;

@property (strong, nonatomic) IBOutlet UILabel *networksLabel;
@property (strong, nonatomic) IBOutlet UILabel *fbLabel;
@property (strong, nonatomic) IBOutlet UILabel *instaLabel;
@property (strong, nonatomic) IBOutlet UILabel *linkedinLabel;
@property (strong, nonatomic) IBOutlet UILabel *snapchatLabel;


@property (nonatomic, retain) UIView * Line;
@property (nonatomic, retain) UIView * Line1;
@property (nonatomic, retain) UIView * Line2;
@property (nonatomic, retain) UIView * Line3;
@property (nonatomic, retain) UIView * Line4;

@property (nonatomic,unsafe_unretained) CGRect mainScreenBounds;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIView * tableBack;



@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect full = [[UIScreen mainScreen]bounds];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationItem setHidesBackButton:YES];
    self.background = [[UIView alloc] initWithFrame:full];
    self.background.hidden = NO;
    self.background.backgroundColor = [UIColor whiteColor];
    self.background.contentMode = UIViewContentModeScaleAspectFill;
    self.pickbackground.userInteractionEnabled = YES;
    [self.view addSubview:self.background];
    
    // [self initViewItems];
    [self addTopBackground];
    [self styleNavBar];
    
    [self addProfileBackground];
    [self addProfileImage];
    [self addProfileBackground2];
    [self addProfileImage2];
    [self addProfileBackground3];
    [self addProfileImage3];
    [self addProfileBackground4];
    [self addProfileImage4];
    [self setupnetworkLabel];
    [self addLine];
    
    
    [self addTableContainer];
    
    [self initTableView];
    
    [self addBottomLine];
    
    //  [self addIcons];
    //  [self addLabels];
    //  [self addLines];
    //  [self addConstraints];
    
    
}


- (void)initTableView {
    CGRect frame = [[UIScreen mainScreen] bounds];
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableBack addSubview:self.tableView];
    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 1)];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 0;
        height = 100;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 0;
        height = 250;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 0;
        height = 260;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 0;
        height = 85;
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"top":self.tableBack, @"table": self.tableView};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.tableBack attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *YConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.tableBack attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    [self.view addConstraint:YConstraint];
    [self.tableBack addConstraint:constraint1];
    
    /*
     NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pic attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
     [self.pickbackground addConstraint:constraint3];*/
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.tableBack addConstraint:constraint4];
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
    //   self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    //   self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //    [self.navigationController.navigationBar setTranslucent:YES];
    //   [self.navigationItem setHidesBackButton:YES];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self styleNavBar];
    
    
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
        height = 70;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        height = 55;
    }
    
    
    // 1. hide the existing nav bar
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    // 2. create a new nav bar and style it
    UINavigationBar *newNavBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), height)];
    newNavBar.translucent = YES;
    // 3. add a new navigation item w/title to the new nav bar
    UINavigationItem *newItem = [[UINavigationItem alloc] init];
    
    UIButton* customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    newNavBar.backgroundColor = [UIColor whiteColor];
    newNavBar.barTintColor = [UIColor whiteColor];
    
    
    
    UIView *backView =[[UIView alloc] init];// Here you can set View width and height as per your requirement for displaying titleImageView position in navigationbar
    backView.translatesAutoresizingMaskIntoConstraints = NO;
    [backView invalidateIntrinsicContentSize];
    customButton.translatesAutoresizingMaskIntoConstraints = NO;
    [customButton invalidateIntrinsicContentSize];
    customButton.backgroundColor = [UIColor blueColor];
    
    customButton.userInteractionEnabled = YES;
    [customButton addTarget:self
                     action:@selector(Edit:) forControlEvents:UIControlEventTouchUpInside];
    
    //    UIBarButtonItem* customBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customButton];
    
    
    
    UIImage *proIcon = [[DataAccess singletonInstance] getProfileImage];
    UIImageView *viewImage = [[UIImageView alloc] init];
    viewImage.image = proIcon;
    viewImage.translatesAutoresizingMaskIntoConstraints = NO;
    [viewImage invalidateIntrinsicContentSize];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    
    nameLabel.font = [UIFont systemFontOfSize:18];
    
    
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        nameLabel.font = [UIFont systemFontOfSize:18];
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        nameLabel.font = [UIFont systemFontOfSize:18];
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        nameLabel.font = [UIFont systemFontOfSize:23];
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        nameLabel.font = [UIFont systemFontOfSize:18];
    }
    
    
    height = 15;
    
    viewImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *pictureTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(Edit:)];
    [viewImage addGestureRecognizer:pictureTap];
    
    
    
    [nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [nameLabel invalidateIntrinsicContentSize];
    nameLabel.textColor = [UIColor blackColor];
    
    nameLabel.text = [[DataAccess singletonInstance] getName];
    
    
    //  UIFont *fontStyle =  [NSFontAttributeName: UIFont(name: "Avenir Next", size: 27)!]
    UIImage *image = [[UIImage imageNamed:@"down_arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(Settings:)];
    
    
    newItem.rightBarButtonItem = rightBtn;
    
    
    [backView addSubview:nameLabel];
    
    
    
    
    viewImage.alpha = 1.0;
    viewImage.layer.masksToBounds = YES;
    
    
    
    
    //   backView.backgroundColor = [UIColor redColor];
    
    
    
    
    //  [backView addSubview:customButton];
    
    
    //  viewImage.backgroundColor = [UIColor clearColor];
    
    
    
    
    
    
    
    
    
    // newItem.titleView = backView;
    // 4. add the nav bar to the main view
    [newNavBar setItems:@[newItem]];
    [self.view addSubview:newNavBar];
    [newNavBar addSubview:backView];
    
    [backView addSubview:viewImage];
    
    
    /*
     NSDictionary *viewsDictionary = @{@"back":backView, @"nav": newNavBar};
     NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.topbackground attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
     NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:ypad]} views:viewsDictionary];
     [self.view addConstraint:constraint1];
     [self.view addConstraints:constraint2];
     */
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:backView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:backView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
    [self.view addConstraint:constraint4];
    
    NSDictionary *viewsDictionary = @{@"back":backView, @"nav": newNavBar, @"image": viewImage, @"name": nameLabel};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:newNavBar attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:backView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:20]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    
    CGFloat image_size = 0, v_pad = 0, h_pad = 0, n_pad = 10;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        image_size = 32;
        v_pad = 5;
        n_pad = 10;
        viewImage.layer.cornerRadius = 15;
        h_pad = -13;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        image_size = 35;
        v_pad = 8;
        viewImage.layer.cornerRadius = 18;
        n_pad = 16;
        h_pad = -18;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        image_size = 40;
        v_pad = 10;
        viewImage.layer.cornerRadius = 20;
        n_pad = 18;
        h_pad = -25;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        
        image_size = 28;
        v_pad = 0;
        viewImage.layer.cornerRadius = 14;
        n_pad = 5;
        h_pad = -11;
        
    }
    
    
    //    NSLayoutConstraint *constraint10 = [NSLayoutConstraint constraintWithItem:backView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:viewImage attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint10 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:10]} views:viewsDictionary];
    [self.view addConstraints:constraint10];
    NSArray *constraint20 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:v_pad]} views:viewsDictionary];
    //   [self.view addConstraint:constraint10];
    [self.view addConstraints:constraint20];
    NSLayoutConstraint *constraint5 = [NSLayoutConstraint constraintWithItem:viewImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:image_size];
    [self.view addConstraint:constraint5];
    
    NSLayoutConstraint *constraint6 = [NSLayoutConstraint constraintWithItem:viewImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:image_size];
    [self.view addConstraint:constraint6];
    
    
    
    NSLayoutConstraint *constraint15 = [NSLayoutConstraint constraintWithItem:backView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:nameLabel attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:h_pad];
    NSArray *constraint12 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[name]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:n_pad]} views:viewsDictionary];
    [self.view addConstraints:constraint12];
    [self.view addConstraint:constraint15];
    
    
    /*
     NSLayoutConstraint *constraint7 = [NSLayoutConstraint constraintWithItem:customButton.imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:35];
     [self.view addConstraint:constraint7];
     
     NSLayoutConstraint *constraint8 = [NSLayoutConstraint constraintWithItem:customButton.imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:35];
     [self.view addConstraint:constraint8];
     
     */
}

- (void)setupTitleViewWithTitleText {
    
    //  UIImageView *imView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    UIImage *proIcon = [[DataAccess singletonInstance] getProfileImage];
    //   CGRect frame = CGRectMake(0, 0, 25, 25);
    
    
    UIImageView* v = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    v.image = proIcon;
    v.layer.masksToBounds = YES;
    v.layer.cornerRadius = 20;
    
    v.layer.shadowOffset = CGSizeMake(1.5, 1.5);
    v.layer.shadowRadius = 0.5;
    v.layer.shadowOpacity = 1.0;
    v.layer.shadowColor = [self titleColor].CGColor;
    
    UIBarButtonItem* rightBtn = [[UIBarButtonItem alloc] initWithCustomView:v];
    rightBtn.action = @selector(Edit:);
    
    //   self.navigationItem.rightBarButtonItem = rightBtn;
    /*
     //   imView.backgroundColor = [UIColor redColor];
     imView.image = proIcon;
     
     
     
     
     
     //   imView.contentMode = UIViewContentModeScaleAspectFill;
     //   imView.clipsToBounds = YES;
     //   imView.layer.cornerRadius = 25;
     //   imView.layer.masksToBounds = YES;
     
     
     
     UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
     [button setBackgroundImage:imView.image forState:UIControlStateNormal];
     [button setShowsTouchWhenHighlighted:YES];
     
     button.layer.cornerRadius = 25;
     
     
     
     [button addTarget:self action:@selector(Edit:) forControlEvents:UIControlEventTouchDown];
     
     
     
     UIBarButtonItem* rightBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
     
     
     //   UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:[proIcon imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
     //                                                               style:UIBarButtonItemStylePlain
     //                                                              target:self
     //                                                              action:@selector(Edit:)];
     
     
     
     UIButton *useButton = [UIButton buttonWithType:UIButtonTypeCustom];
     useButton.frame = CGRectMake(35, 35, 35, 35);
     useButton.layer.masksToBounds = NO;
     useButton.layer.cornerRadius = 25;
     useButton.layer.shadowOffset = CGSizeMake(1.5, 1.5);
     useButton.layer.shadowRadius = 0.5;
     useButton.layer.shadowOpacity = 1.0;
     useButton.layer.shadowColor = [UIColor blackColor].CGColor;
     useButton.backgroundColor = [UIColor redColor];
     
     UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:useButton];
     self.navigationItem.rightBarButtonItem = rightBtn;*/
    
    UIButton *titleView = [UIButton buttonWithType:UIButtonTypeCustom];
    titleView.frame = CGRectMake(0, 0, 30, 30);
    
    [titleView setUserInteractionEnabled:YES];
    [titleView setBackgroundImage:proIcon forState:UIControlStateNormal];
    [titleView setShowsTouchWhenHighlighted:YES];
    titleView.clipsToBounds = YES;
    titleView.layer.cornerRadius = 20;
    //    [titleView sizeToFit];
    [titleView addTarget:self action:@selector(Edit:) forControlEvents:UIControlEventTouchUpInside];
    
    //  titleView.layer.cornerRadius = 25;
    //  NSString *titleText = @"Portal";
    // [titleView setTitleColor:[self titleColor] forState:UIControlStateNormal];
    
    //  [titleView setTitle:titleText forState:UIControlStateNormal];
    
    
    
    
    
    self.navigationItem.titleView = titleView;
}



- (void)initViewItems {
    
    
    self.snapchatLabel = [[UILabel alloc] init];
    [self.view addSubview:self.snapchatLabel];
    self.fbLabel = [[UILabel alloc] init];
    [self.view addSubview:self.fbLabel];
    self.instaLabel = [[UILabel alloc] init];
    [self.view addSubview:self.instaLabel];
    self.linkedinLabel = [[UILabel alloc] init];
    [self.view addSubview:self.linkedinLabel];
    
    
    
    self.Line1 = [[UIView alloc] init];
    [self.view addSubview:self.Line1];
    self.Line2 = [[UIView alloc] init];
    [self.view addSubview:self.Line2];
    self.Line3 = [[UIView alloc] init];
    [self.view addSubview:self.Line3];
    self.Line4 = [[UIView alloc] init];
    [self.view addSubview:self.Line4];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addTopBackground {
    
    self.topbackground = [[UIView alloc]init];
    
    self.topbackground.backgroundColor = [UIColor whiteColor];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    self.topbackground.translatesAutoresizingMaskIntoConstraints = NO;
    [self.topbackground invalidateIntrinsicContentSize];
    
    
    
    [self.view addSubview:self.topbackground];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 64;
        height = 270;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 70;
        height = 310;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 80;
        height = 340;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 55;
        height = 231;
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.topbackground};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.topbackground attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.topbackground attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.topbackground attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
}

- (void)addProfileImage {
    
    self.pic = [[UIImageView alloc]init];
    
    self.pic.backgroundColor = [UIColor blueColor];
    CGFloat width = 0; // CGRectGetWidth([[UIScreen mainScreen] bounds]) - 10;
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
    
    
    
    [self.pickbackground addSubview:self.pic];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 1;
        height = 134;
        width = 138;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 1;
        height = 150;
        width = 158;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 1;
        height = 162;
        width = 178;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 1;
        height = 115;
        width = 138;
    }
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(picturePressed:)];
    [self.pic addGestureRecognizer:tapGesture];
    
    
    if ([[DataAccess singletonInstance] LoggedInWithFB]) {
        self.pic.userInteractionEnabled = YES;
    }
    
    
    NSDictionary *viewsDictionary = @{@"image":self.pic};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.pic attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.pickbackground attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.pickbackground addConstraint:constraint1];
    [self.pickbackground addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pic attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.pickbackground addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pic attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.pickbackground addConstraint:constraint4];
    
    
    
    
    
    
}



- (void)addProfileBackground {
    
    self.pickbackground = [[UIView alloc]init];
    
    self.pickbackground.backgroundColor = [self cdBlue];//[UIColor whiteColor];
    CGFloat width = 0; //CGRectGetWidth([[UIScreen mainScreen] bounds]) - 8;
    self.pickbackground.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pickbackground invalidateIntrinsicContentSize];
    
    //  self.pickbackground.alpha = 2.0;
    
    
    self.pickbackground.layer.masksToBounds = NO;
    self.pickbackground.layer.shadowOffset = CGSizeMake(-.1, .2);
    self.pickbackground.layer.shadowRadius = .5;
    self.pickbackground.layer.shadowOpacity = 0.5;
    
    
    [self.topbackground addSubview:self.pickbackground];
    
    CGFloat pad = 0, pad2 = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 8;
        pad2 = 14;
        height = 136;
        width = 140;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 8;
        height = 152;
        width = 160;
        pad2 = 15;
        
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 8;
        height = 164;
        width = 180;
        pad2 = 17;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 8;
        pad2 = 13;
        height = 117;
        width = 140;
        
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.pickbackground, @"top": self.topbackground};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.topbackground addConstraints:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pickbackground attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.topbackground addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pickbackground attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.topbackground addConstraint:constraint4];
    
}

- (void)addProfileImage2 {
    
    self.pic2 = [[UIImageView alloc]init];
    
    self.pic2.backgroundColor = [UIColor blueColor];
    CGFloat width = 0; // CGRectGetWidth([[UIScreen mainScreen] bounds]) - 10;
    self.pic2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pic2 invalidateIntrinsicContentSize];
    
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"ProfileImage2"];
    UIImage* image = [UIImage imageWithData:imageData];
    
    
    if (image != nil) {
        self.pic2.image = [[DataAccess singletonInstance] getProfileImage2];
    }else{
        self.pic2.image = [UIImage imageNamed:@"image_placeholder.png"];
    }
    
    self.pic2.alpha = 2.0;
    
    
    
    [self.pickbackground2 addSubview:self.pic2];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 1;
        height = 134;
        width = 138;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 1;
        height = 150;
        width = 158;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 1;
        height = 162;
        width = 178;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 1;
        height = 115;
        width = 138;
    }
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(picturePressed:)];
    [self.pic2 addGestureRecognizer:tapGesture];
    
    
    if ([[DataAccess singletonInstance] LoggedInWithFB]) {
        self.pic2.userInteractionEnabled = YES;
    }
    
    
    NSDictionary *viewsDictionary = @{@"image":self.pic2};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.pic2 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.pickbackground2 attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.pickbackground2 addConstraint:constraint1];
    [self.pickbackground2 addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pic2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.pickbackground2 addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pic2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.pickbackground2 addConstraint:constraint4];
    
    
    
    
    
    
}







- (void)addProfileBackground2 {
    
    self.pickbackground2 = [[UIView alloc]init];
    
    self.pickbackground2.backgroundColor = [UIColor whiteColor];
    CGFloat width = 0; //CGRectGetWidth([[UIScreen mainScreen] bounds]) - 8;
    self.pickbackground2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pickbackground2 invalidateIntrinsicContentSize];
    
    //  self.pickbackground.alpha = 2.0;
    
    
    self.pickbackground2.layer.masksToBounds = NO;
    self.pickbackground2.layer.shadowOffset = CGSizeMake(-.1, .2);
    self.pickbackground2.layer.shadowRadius = .5;
    self.pickbackground2.layer.shadowOpacity = 0.5;
    
    
    [self.topbackground addSubview:self.pickbackground2];
    
    CGFloat pad = 0, pad2 = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 8;
        pad2 = 14;
        height = 136;
        width = 140;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 8;
        height = 152;
        width = 160;
        pad2 = 15;
        
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 8;
        height = 164;
        width = 180;
        pad2 = 17;
        
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 8;
        pad2 = 13;
        height = 117;
        width = 140;
        
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.pickbackground, @"top": self.pickbackground2};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[top]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[back]-pad-[top]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.topbackground addConstraints:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pickbackground2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.topbackground addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pickbackground2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.topbackground addConstraint:constraint4];
    
}


- (void)addProfileBackground3 {
    
    self.pickbackground3 = [[UIView alloc]init];
    
    self.pickbackground3.backgroundColor = [UIColor whiteColor];
    CGFloat width = 0; //CGRectGetWidth([[UIScreen mainScreen] bounds]) - 8;
    self.pickbackground3.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pickbackground3 invalidateIntrinsicContentSize];
    
    //  self.pickbackground.alpha = 2.0;
    
    
    self.pickbackground3.layer.masksToBounds = NO;
    self.pickbackground3.layer.shadowOffset = CGSizeMake(-.1, .2);
    self.pickbackground3.layer.shadowRadius = .5;
    self.pickbackground3.layer.shadowOpacity = 0.5;
    
    
    [self.topbackground addSubview:self.pickbackground3];
    
    CGFloat pad = 0, pad2 = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 8;
        pad2 = 14;
        height = 136;
        width = 140;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 8;
        height = 152;
        width = 160;
        pad2 = 15;
        
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 8;
        height = 164;
        width = 180;
        pad2 = 17;
        
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 8;
        pad2 = 13;
        height = 117;
        width = 140;
        
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"top": self.pickbackground3};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[top]-pad-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[top]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.topbackground addConstraints:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pickbackground3 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.topbackground addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pickbackground3 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.topbackground addConstraint:constraint4];
    
}

- (void)addProfileImage3 {
    
    self.pic3 = [[UIImageView alloc]init];
    
    self.pic3.backgroundColor = [UIColor blueColor];
    CGFloat width = 0; // CGRectGetWidth([[UIScreen mainScreen] bounds]) - 10;
    self.pic3.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pic3 invalidateIntrinsicContentSize];
    
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"ProfileImage3"];
    UIImage* image = [UIImage imageWithData:imageData];
    
    
    if (image != nil) {
        self.pic3.image = [[DataAccess singletonInstance] getProfileImage3];
    }else{
        self.pic3.image = [UIImage imageNamed:@"image_placeholder.png"];
    }
    
    self.pic3.alpha = 2.0;
    
    
    
    [self.pickbackground3 addSubview:self.pic3];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 1;
        height = 134;
        width = 138;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 1;
        height = 150;
        width = 158;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 1;
        height = 162;
        width = 178;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 1;
        height = 115;
        width = 138;
    }
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(picturePressed:)];
    [self.pic3 addGestureRecognizer:tapGesture];
    
    
    if ([[DataAccess singletonInstance] LoggedInWithFB]) {
        self.pic3.userInteractionEnabled = YES;
    }
    
    
    NSDictionary *viewsDictionary = @{@"image":self.pic3};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.pic3 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.pickbackground3 attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.pickbackground3 addConstraint:constraint1];
    [self.pickbackground3 addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pic3 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.pickbackground3 addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pic3 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.pickbackground3 addConstraint:constraint4];
    
    
    
    
    
    
}

- (void)addProfileImage4 {
    
    self.pic4 = [[UIImageView alloc]init];
    
    self.pic4.backgroundColor = [UIColor blueColor];
    CGFloat width = 0; // CGRectGetWidth([[UIScreen mainScreen] bounds]) - 10;
    self.pic4.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pic4 invalidateIntrinsicContentSize];
    
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"ProfileImage4"];
    UIImage* image = [UIImage imageWithData:imageData];
    
    
    if (image != nil) {
        self.pic4.image = [[DataAccess singletonInstance] getProfileImage4];
    }else{
        self.pic4.image = [UIImage imageNamed:@"image_placeholder.png"];
    }
    
    self.pic4.alpha = 2.0;
    
    
    
    [self.pickbackground4 addSubview:self.pic4];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 1;
        height = 134;
        width = 138;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 1;
        height = 150;
        width = 158;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 1;
        height = 162;
        width = 178;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 1;
        height = 115;
        width = 138;
    }
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(picturePressed:)];
    [self.pic4 addGestureRecognizer:tapGesture];
    
    
    if ([[DataAccess singletonInstance] LoggedInWithFB]) {
        self.pic4.userInteractionEnabled = YES;
    }
    
    
    NSDictionary *viewsDictionary = @{@"image":self.pic4};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.pic4 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.pickbackground4 attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.pickbackground4 addConstraint:constraint1];
    [self.pickbackground4 addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pic4 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.pickbackground4 addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pic4 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.pickbackground4 addConstraint:constraint4];
    
    
    
    
    
    
}







- (void)addProfileBackground4 {
    
    self.pickbackground4 = [[UIView alloc]init];
    
    self.pickbackground4.backgroundColor = [UIColor whiteColor];
    CGFloat width = 0; //CGRectGetWidth([[UIScreen mainScreen] bounds]) - 8;
    self.pickbackground4.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pickbackground4 invalidateIntrinsicContentSize];
    
    //  self.pickbackground.alpha = 2.0;
    
    
    self.pickbackground4.layer.masksToBounds = NO;
    self.pickbackground4.layer.shadowOffset = CGSizeMake(-.1, .2);
    self.pickbackground4.layer.shadowRadius = .5;
    self.pickbackground4.layer.shadowOpacity = 0.5;
    
    
    [self.topbackground addSubview:self.pickbackground4];
    
    CGFloat pad = 0, pad2 = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 8;
        pad2 = 14;
        height = 136;
        width = 140;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 8;
        height = 152;
        width = 160;
        pad2 = 15;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 8;
        height = 164;
        width = 180;
        pad2 = 17;
        
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 8;
        pad2 = 13;
        height = 117;
        width = 140;
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.pickbackground3, @"top": self.pickbackground4};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[top]-pad-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[back]-pad-[top]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.topbackground addConstraints:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pickbackground4 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.topbackground addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pickbackground4 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.topbackground addConstraint:constraint4];
    
}


- (void)addTableContainer {
    
    self.tableBack = [[UIView alloc]init];
    
    self.tableBack.backgroundColor = [UIColor whiteColor];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    self.tableBack.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tableBack invalidateIntrinsicContentSize];
    
    self.tableBack.layer.masksToBounds = NO;
    self.tableBack.layer.shadowOffset = CGSizeMake(-.1, .2);
    self.tableBack.layer.shadowRadius = .5;
    self.tableBack.layer.shadowOpacity = 0.5;
    
    [self.view addSubview:self.tableBack];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 0;
        height = 180;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 0;
        height = 195;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 0;
        height = 210;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 0;
        height = 180;
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.tableBack, @"top": self.Line};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.tableBack attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.tableBack attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.tableBack attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
}




- (void)setupnetworkLabel {
    UIFont *font;
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    
    CGFloat height = 0;
    
    self.networksLabel = [[UILabel alloc] init];
    
    self.networksLabel.hidden = YES;
    
    self.networksLabel.font = [UIFont systemFontOfSize:5];
    height = 15;
    
    CGFloat pad = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 6;
        height = 180;
        self.networksLabel.font = [UIFont systemFontOfSize:16];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 7;
        height = 180;
        self.networksLabel.font = [UIFont systemFontOfSize:17];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 8;
        height = 180;
        self.networksLabel.font = [UIFont systemFontOfSize:18];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 5;
        height = 180;
        self.networksLabel.font = [UIFont systemFontOfSize:15];
        
    }
    
    
    
    [self.networksLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.networksLabel invalidateIntrinsicContentSize];
    self.networksLabel.font = [UIFont fontWithName:@"Verdana" size:17.0f];
    self.networksLabel.textColor = [self cdBlue];
    
    self.networksLabel.text = @"Networks";
    
    [self.view addSubview:self.networksLabel];
    
    UIView *top = self.topbackground;
    NSDictionary *viewsDictionary = @{@"top":top, @"label" : self.networksLabel};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-17-[label]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
}




- (void)addIcons {
    
    self.fb_logo = [[UIImageView alloc] init];
    self.insta_logo = [[UIImageView alloc] init];
    self.linkedin_logo = [[UIImageView alloc] init];
    self.snapchat_logo = [[UIImageView alloc] init];
    
    self.fb_logo.translatesAutoresizingMaskIntoConstraints = NO;
    [self.fb_logo invalidateIntrinsicContentSize];
    self.insta_logo.translatesAutoresizingMaskIntoConstraints = NO;
    [self.insta_logo invalidateIntrinsicContentSize];
    self.linkedin_logo.translatesAutoresizingMaskIntoConstraints = NO;
    [self.linkedin_logo invalidateIntrinsicContentSize];
    self.snapchat_logo.translatesAutoresizingMaskIntoConstraints = NO;
    [self.snapchat_logo invalidateIntrinsicContentSize];
    
    
    
    self.fb_logo.image = [UIImage imageNamed:@"facebook_icon"];
    self.insta_logo.image = [UIImage imageNamed:@"instagram_icon1.png"];
    self.linkedin_logo.image = [UIImage imageNamed:@"linkedin_icon.png"];
    self.snapchat_logo.image = [UIImage imageNamed:@"snapchat_icon.png"];
    
    
    CGFloat pad, pad1 = 0, pad2, height = 0, width = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad1 = 10;
        pad = 20;
        pad2 = 25;
        height = 25;
        width = 25;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 20;
        height = 25;
        width = 25;
        pad2 = 25;
        pad1 = 10;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 20;
        height = 25;
        width = 25;
        pad2 = 25;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 20;
        height = 25;
        width = 25;
        pad2 = 25;
        pad1 = 10;
        
    }
    
    
    [self.view addSubview:self.fb_logo];
    [self.view addSubview:self.insta_logo];
    [self.view addSubview:self.linkedin_logo];
    [self.view addSubview:self.snapchat_logo];
    
    NSDictionary *viewsDictionary = @{@"fb":self.fb_logo, @"snap":self.snapchat_logo, @"insta":self.insta_logo, @"linkedin":self.linkedin_logo, @"top": self.Line};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[fb]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[snap]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint3 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-27-[insta]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint4 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[linkedin]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint5 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad1-[fb]-pad-[insta]-pad-[linkedin]-pad-[snap]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad], @"pad1":[NSNumber numberWithFloat:pad1]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    [self.view addConstraints:constraint2];
    [self.view addConstraints:constraint3];
    [self.view addConstraints:constraint4];
    [self.view addConstraints:constraint5];
    
    NSLayoutConstraint *constraint6 = [NSLayoutConstraint constraintWithItem:self.fb_logo attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint6];
    
    NSLayoutConstraint *constraint7 = [NSLayoutConstraint constraintWithItem:self.fb_logo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint7];
    
    NSLayoutConstraint *constraint8 = [NSLayoutConstraint constraintWithItem:self.insta_logo attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:22];
    [self.view addConstraint:constraint8];
    
    NSLayoutConstraint *constraint9 = [NSLayoutConstraint constraintWithItem:self.insta_logo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:22];
    [self.view addConstraint:constraint9];
    
    NSLayoutConstraint *constraint10 = [NSLayoutConstraint constraintWithItem:self.linkedin_logo attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint10];
    
    NSLayoutConstraint *constraint11 = [NSLayoutConstraint constraintWithItem:self.linkedin_logo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint11];
    
    NSLayoutConstraint *constraint12 = [NSLayoutConstraint constraintWithItem:self.snapchat_logo attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint12];
    
    NSLayoutConstraint *constraint13 = [NSLayoutConstraint constraintWithItem:self.snapchat_logo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint13];
    
    
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1
    ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    AccountTableViewCell *cell = (AccountTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    
    if (cell == nil) {
        cell = [[AccountTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    
    UIFont *myFont = [ UIFont fontWithName: @"Arial" size: 19.0 ];
    cell.textLabel.font  = myFont;
    cell.textLabel.textColor = [UIColor lightGrayColor];
    
    if (indexPath.row == 0) {
        
        cell.pic.image = [UIImage imageNamed:@"facebook_icon"];
        cell.Label.text = @"Facebook";
        
    }else if (indexPath.row == 1) {
        cell.pic.image = [UIImage imageNamed:@"instagram_icon"];
        
        //      if ([[DataAccess singletonInstance] getInstagram] != nil) {
        //          cell.textLabel.text = [[DataAccess singletonInstance] getInstagram];
        //      }else{
        cell.Label.text = @"Instagram";
        //      }
        
    }
    else if (indexPath.row == 2) {
        
        cell.pic.image = [UIImage imageNamed:@"linkedin_icon"];
        
        //      if ([[DataAccess singletonInstance] getLinkedin] != nil) {
        //         cell.textLabel.text = [[DataAccess singletonInstance] getLinkedin];
        //      }else{
        cell.Label.text = @"Linkedin";
        //      }
        
    }
    else if (indexPath.row == 3) {
        // cell.imageView.image = [UIImage imageNamed:@"snapchat_icon"];
        cell.pic.image = [UIImage imageNamed:@"snapchat_icon"];
        //        if ([[DataAccess singletonInstance] getSnapchat] != nil) {
        //            cell.textLabel.text = [[DataAccess singletonInstance] getSnapchat];
        //       }else{
        cell.Label.text = @"Snapchat";
        //       }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //  CGFloat height = self.tableBack.frame.size.height;
    CGFloat height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        height = 45;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        height = 48;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        height = 52;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        height = 34;
    }
    return height; //(height / 5);//[self getCellHeight];
}


/*
 -(CGFloat)getCellHeight {
 CGFloat cellHeight = 0.0;
 if([[DeviceManager sharedInstance] getIsIPhone5Screen])
 {
 cellHeight =  ceilf(163/2);
 }
 else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
 {
 cellHeight = ceilf(180/2);
 }
 else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
 {
 cellHeight = ceil(300/3);
 }
 else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
 cellHeight = ceilf(140/2);
 }
 
 return cellHeight;
 }
 
 -(CGFloat)getAccessoryViewWidth {
 CGFloat modifier = 0.0;
 if([[DeviceManager sharedInstance] getIsIPhone5Screen])
 {
 modifier =  42;
 }
 else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
 {
 modifier = 42;
 }
 else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
 {
 modifier = 48;
 }
 else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
 modifier = 42;
 }
 
 return modifier;
 }
 
 -(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
 if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
 [cell setSeparatorInset:UIEdgeInsetsZero];
 }
 if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
 [cell setLayoutMargins:UIEdgeInsetsZero];
 }
 }*/


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 0) {
        
        if ([[DataAccess singletonInstance] LoggedInWithFB] || [[DataAccess singletonInstance] AddedFB]) {
            FacebookFieldViewController *account = [[FacebookFieldViewController alloc] init];
            [self.navigationItem setHidesBackButton:NO];
            [self.navigationController setNavigationBarHidden:NO animated:NO];
            [self.navigationController pushViewController:account animated:YES];
        }else{
            FBAccountViewController *account = [[FBAccountViewController alloc] init];
            [self.navigationItem setHidesBackButton:NO];
            [self.navigationController setNavigationBarHidden:NO animated:NO];
            [self.navigationController pushViewController:account animated:YES];
            
        }
        
        
        
    }else if(indexPath.row == 1){
        InstagramFieldViewController *account = [[InstagramFieldViewController alloc] init];
        [self.navigationItem setHidesBackButton:NO];
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.navigationController pushViewController:account animated:YES];
        
    }else if(indexPath.row == 2){
        
        
        if ([[DataAccess singletonInstance] LoggedInWithLinkedin] || [[DataAccess singletonInstance] AddedLinkedin]) {
            LinkedinFieldViewController *account = [[LinkedinFieldViewController alloc] init];
            [self.navigationItem setHidesBackButton:NO];
            [self.navigationController setNavigationBarHidden:NO animated:NO];
            [self.navigationController pushViewController:account animated:YES];
        }
        else{
            LinkedinAccountViewController *account = [[LinkedinAccountViewController alloc] init];
            [self.navigationItem setHidesBackButton:NO];
            [self.navigationController setNavigationBarHidden:NO animated:NO];
            [self.navigationController pushViewController:account animated:YES];
        }
        
        
        
        
    }else if(indexPath.row == 3){
        SnapchatFieldViewController *account = [[SnapchatFieldViewController alloc] init];
        [self.navigationItem setHidesBackButton:NO];
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.navigationController pushViewController:account animated:YES];
        
    }
    
    
}




- (void)addLine{
    
    self.Line = [[UIView alloc]init];
    
    self.Line.backgroundColor = [UIColor whiteColor];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    self.Line.translatesAutoresizingMaskIntoConstraints = NO;
    [self.Line invalidateIntrinsicContentSize];
    
    
    
    [self.view addSubview:self.Line];
    
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
    
    
    
    NSDictionary *viewsDictionary = @{@"top":self.networksLabel, @"line": self.Line};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.Line attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[line]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.Line attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.Line attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
}

- (void)addBottomLine{
    
    self.Line2 = [[UIView alloc]init];
    
    self.Line2.backgroundColor = [UIColor whiteColor];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    self.Line2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.Line2 invalidateIntrinsicContentSize];
    
    
    
    [self.tableBack addSubview:self.Line2];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 0;
        height = 1;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 0;
        height = 1;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 0;
        height = 1;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 0;
        height = 1;
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"top":self.tableView, @"line": self.Line2};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.tableBack attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.Line2 attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[line]-pad-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.tableBack addConstraint:constraint1];
    [self.tableBack addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.Line2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.tableBack addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.Line2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.tableBack addConstraint:constraint4];
    
}



- (void)addLabels{
    UIFont *font;
    self.fbLabel = [[UILabel alloc] init];
    self.fbLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [self.fbLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.fbLabel invalidateIntrinsicContentSize];
    self.fbLabel.font = font;
    self.fbLabel.textColor = [UIColor blackColor];
    
    self.fbLabel.text = @"Facebook";
    
    [self.view addSubview:self.fbLabel];
    
    
    self.instaLabel = [[UILabel alloc] init];
    self.instaLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [self.instaLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.instaLabel invalidateIntrinsicContentSize];
    self.instaLabel.font = font;
    self.instaLabel.textColor = [UIColor blackColor];
    
    self.instaLabel.text = @"Instagram";
    
    [self.view addSubview:self.instaLabel];
    
    
    self.linkedinLabel = [[UILabel alloc] init];
    self.linkedinLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [self.linkedinLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.linkedinLabel invalidateIntrinsicContentSize];
    self.linkedinLabel.font = font;
    self.linkedinLabel.textColor = [UIColor blackColor];
    
    self.linkedinLabel.text = @"Linkedin";
    
    [self.view addSubview:self.linkedinLabel];
    
    
    self.snapchatLabel = [[UILabel alloc] init];
    self.snapchatLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [self.snapchatLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.snapchatLabel invalidateIntrinsicContentSize];
    self.snapchatLabel.font = font;
    self.snapchatLabel.textColor = [UIColor blackColor];
    
    self.snapchatLabel.text = @"Snapchat";
    
    [self.view addSubview:self.snapchatLabel];
    
    
    
}

-(void)addLines{
    
    self.Line1 = [[UIView alloc]init];
    
    //   self.Line1.backgroundColor = [self lineColor];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 30;
    self.Line1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.Line1 invalidateIntrinsicContentSize];
    
    
    
    [self.view addSubview:self.Line1];
    
    self.Line2 = [[UIView alloc]init];
    
    //    self.Line2.backgroundColor = [self lineColor];
    self.Line2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.Line2 invalidateIntrinsicContentSize];
    
    
    
    [self.view addSubview:self.Line2];
    
    self.Line3 = [[UIView alloc]init];
    
    //  self.Line3.backgroundColor = [self lineColor];
    self.Line3.translatesAutoresizingMaskIntoConstraints = NO;
    [self.Line3 invalidateIntrinsicContentSize];
    
    
    
    [self.view addSubview:self.Line3];
    
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 4;
        height = 1;
        width = 200;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 4;
        height = 1;
        width = 200;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 4;
        height = 1;
        width = 200;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 4;
        height = 1;
        width = 200;
        
    }
    
    
    
    
}

-(void)addConstraints{
    
    
    NSDictionary *viewsDictionary = @{@"top":self.Line, @"line1":self.Line1, @"line2":self.Line2, @"line3":self.Line3, @"fblabel" : self.fbLabel,  @"instalabel" : self.instaLabel,  @"linklabel" : self.linkedinLabel, @"snaplabel" : self.snapchatLabel, @"image": self.fb_logo};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[image]-20-[fblabel]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[image]-20-[instalabel]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint2];
    NSArray *constraint3 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[image]-20-[snaplabel]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint3];
    NSArray *constraint4 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[image]-20-[linklabel]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint4];
    NSArray *constraint5 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[image]-20-[line1]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint5];
    NSArray *constraint6 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[image]-20-[line2]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint6];
    NSArray *constraint7 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[image]-20-[line3]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint7];
    
    
    NSArray *constraint8 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-13-[fblabel]-12-[line1]-11-[instalabel]-12-[line2]-11-[linklabel]-12-[line3]-12-[snaplabel]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint8];
    
    
    CGFloat pad = 0, height = 0, width = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 4;
        height = 1;
        width = 250;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 4;
        height = 1;
        width = 250;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 4;
        height = 1;
        width = 250;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 4;
        height = 1;
        width = 250;
        
    }
    
    
    NSLayoutConstraint *constraint9 = [NSLayoutConstraint constraintWithItem:self.Line1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint9];
    
    NSLayoutConstraint *constraint10 = [NSLayoutConstraint constraintWithItem:self.Line1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint10];
    
    NSLayoutConstraint *constraint11 = [NSLayoutConstraint constraintWithItem:self.Line2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint11];
    
    NSLayoutConstraint *constraint12 = [NSLayoutConstraint constraintWithItem:self.Line2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint12];
    
    NSLayoutConstraint *constraint13 = [NSLayoutConstraint constraintWithItem:self.Line3 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint13];
    
    NSLayoutConstraint *constraint14 = [NSLayoutConstraint constraintWithItem:self.Line3 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint14];
    
    
    
}






- (void)picturePressed:(id)sender {
    
    AlbumsTableViewController *albums = [[AlbumsTableViewController alloc] init];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController pushViewController:albums animated:YES];
    /*
     InstagramFieldViewController *account = [[InstagramFieldViewController alloc] init];
     [self.navigationItem setHidesBackButton:YES];
     [self.navigationController setNavigationBarHidden:NO animated:NO];
     [self.navigationController pushViewController:account animated:YES];*/
    
}

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


-(IBAction)Edit:(id)sender{
    
    ProfileViewController *account = [[ProfileViewController alloc] init];
    [self.navigationItem setHidesBackButton:NO];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController pushViewController:account animated:YES];
    
}

-(IBAction)Settings:(id)sender{
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.35;
    transition.timingFunction =
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromBottom;
    
    // NSLog(@"%s: self.view.window=%@", _func_, self.view.window);
    UIView *containerView = self.view.window;
    [containerView.layer addAnimation:transition forKey:nil];
    
    [self.navigationController popViewControllerAnimated:NO];
    
    
}



- (UIColor *) cdBlue {
    return [UIColor colorWithRed:0.00 green:0.59 blue:0.84 alpha:1.0];
}





@end
