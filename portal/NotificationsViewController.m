//
//  NotificationsViewController.m
//  portal
//
//  Created by Neil Ballard on 11/22/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import "NotificationsViewController.h"
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
#import "UserProfileViewController.h"
#import "UserAlbumViewController.h"

@interface NotificationsViewController ()

@property (nonatomic, retain) UIView * background;
@property (strong, nonatomic) IBOutlet UIImageView *pic;
@property (strong, nonatomic) IBOutlet UIView *topbackground;
@property (strong, nonatomic) IBOutlet UIView *pickbackground;

@property (strong, nonatomic) IBOutlet UILabel *networksLabel;

@property (nonatomic, retain) UINavigationBar * navBar;



@property (nonatomic, retain) UIView * Line;
@property (nonatomic, retain) UIView * Line2;

@property (nonatomic,unsafe_unretained) CGRect mainScreenBounds;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIView * tableBack;

@end

@implementation NotificationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect full = [[UIScreen mainScreen]bounds];
    self.background = [[UIView alloc] initWithFrame:full];
    self.background.hidden = NO;
    self.background.backgroundColor = [UIColor whiteColor];
    self.background.contentMode = UIViewContentModeScaleAspectFill;
    self.pickbackground.userInteractionEnabled = YES;
    [self.view addSubview:self.background];
    
    [self styleNavBar];
    
    [self setupSearchTextField];
    [self setupnetworkLabel];
    [self addLine];
    
    
    [self addTableContainer];
    
    [self initTableView];
    
    [self addBottomLine];
    

    
    
    
}


- (void)initTableView {
    CGRect frame = [[UIScreen mainScreen] bounds];
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableBack addSubview:self.tableView];
    self.tableView.scrollEnabled = YES;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 1)];
    

    
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    
    
    CGFloat pad = 0, height = 0, edgeInset = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 0;
        height = 500;
        edgeInset = 100;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 0;
        height = 570;
        edgeInset = 100;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 0;
        height = 700;
        edgeInset = 110;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 0;
        height = 500;
        edgeInset = 80;
    }
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, edgeInset, 0);

    
    
    
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
    self.navBar.barTintColor = [UIColor whiteColor];

    
    
    UIImage *image = [[UIImage imageNamed:@"logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(goback)];
    
    
    newItem.leftBarButtonItem = leftBtn;
    
    
    
    UIButton *titleView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [titleView setUserInteractionEnabled:NO];
   
    UIImage *Notifications_image = [[UIImage imageNamed:@"connections"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [titleView setBackgroundImage:Notifications_image forState:UIControlStateNormal];
//    NSString *titleText = @"Name";
//    [titleView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
//    [titleView setTitle:titleText forState:UIControlStateNormal];
    
    
    newItem.titleView = titleView;
    
    
    
    
    
    // newItem.titleView = backView;
    // 4. add the nav bar to the main view
    [self.navBar setItems:@[newItem]];
    [self.view addSubview:self.navBar];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupSearchTextField {
    self.searchTextField = [[UITextField alloc] init];
    [self.view addSubview:self.searchTextField];
    self.searchTextField.delegate = self;
    self.searchTextField.layer.cornerRadius = 7.0;
    self.searchTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.searchTextField invalidateIntrinsicContentSize];

    
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat height = 0, width = 0, xpad = 0, ypad = 0;
    width = screen.size.width - 30;
    
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        self.searchTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:ceilf(32/2)];
        height = 40;
        xpad = 15;
        ypad = 8;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        self.searchTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:ceilf(38/2)];
        height = 35;
        xpad = 15;
        ypad = 10;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        self.searchTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:ceilf(62/3)];
        height = 45;
        xpad = 15;
        ypad = 10;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad])
    {
        self.searchTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:ceilf(28/2)];
        height = 36;
        xpad = 15;
        ypad = 7;
    }
    
    self.searchTextField.backgroundColor = [self grayColor];
    self.searchTextField.placeholder = @"Search Notifications";
    self.searchTextField.textAlignment = NSTextAlignmentCenter;
    self.searchTextField.textColor = [UIColor blackColor];
    self.searchTextField.layer.shadowRadius = 0.01;
    self.searchTextField.layer.shadowOpacity = 0.01;
    
    self.searchTextField.layer.masksToBounds = NO;
    
    //    self.searchTextField.layer.shouldRasterize = YES;
    //   self.searchTextField.layer.borderColor = [UIColor grayColor].CGColor;
    //   self.searchTextField.layer.borderWidth = 1;
    //   self.searchTextField.layer.masksToBounds = true;
    
    NSMutableDictionary *viewsDictionary = [[NSMutableDictionary alloc] init];
    [viewsDictionary setObject:self.searchTextField forKey:@"textField"];
    [viewsDictionary setObject:self.navBar forKey:@"nav"];
    
    NSArray *hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-xpad-[textField]" options:0 metrics:@{@"xpad" : [NSNumber numberWithFloat:xpad], @"width" : [NSNumber numberWithFloat:width]} views:viewsDictionary];
    NSArray *vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[nav]-pad-[textField(height)]" options:0 metrics:@{@"height" : [NSNumber numberWithFloat:height], @"pad" : [NSNumber numberWithFloat:ypad]} views:viewsDictionary];
    
    [self.view addConstraints:hConstraints];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.searchTextField attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width]];
    
    [self.view addConstraints:vConstraints];
    
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
        height = 500;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 0;
        height = 570;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 0;
        height = 700;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 0;
        height = 470;
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
   // UIFont *font;
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    
    CGFloat width = window.frame.size.width - 30;
    CGFloat height = 0;
    
    self.networksLabel = [[UILabel alloc] init];
    
    self.networksLabel.font = [UIFont systemFontOfSize:5];
    height = 15;
    
    
    
    [self.networksLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.networksLabel invalidateIntrinsicContentSize];
    self.networksLabel.font = [UIFont fontWithName:@"Verdana" size:17.0f];
    self.networksLabel.textColor = [self cdBlue];
    
    self.networksLabel.text = @"Notifications";
    
    [self.view addSubview:self.networksLabel];
    
    NSDictionary *viewsDictionary = @{@"top":self.searchTextField, @"label" : self.networksLabel};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-17-[label]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-6-[label]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
}



/*







*****USE left swipe view for able view
 Press NB to reveal social posibilities









*/




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    NotificationsTableViewCell *cell = (NotificationsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    
    if (cell == nil) {
        cell = [[NotificationsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    
    
    
    UIFont *myFont = [ UIFont fontWithName: @"Arial" size: 19.0 ];
    cell.textLabel.font  = myFont;
    cell.textLabel.textColor = [UIColor lightGrayColor];
    
    cell.pic.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(picturePressed:)];
    [cell.pic addGestureRecognizer:tapGesture];
    
    
    if (indexPath.row  % 3 == 0) {
        
        cell.notificationLabel.text = @"Bob viewed your instagram";
        cell.notificationLabel.numberOfLines = 2;
        
    }else if(indexPath.row  % 3 == 1){
        cell.notificationLabel.text = @"Aaron right swiped you";
        
    }else{
        cell.notificationLabel.text = @"Three people viewed your twitter";

    }
    

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //  CGFloat height = self.tableBack.frame.size.height;
    
    CGFloat height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        height =  90;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        height = 100;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        height = 110;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        height = 85;
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
    

    NotificationsTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    
    
}




- (void)addLine{
    
    self.Line = [[UIView alloc]init];
    
    self.Line.backgroundColor = [self lineColor];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    self.Line.translatesAutoresizingMaskIntoConstraints = NO;
    [self.Line invalidateIntrinsicContentSize];
    
    self.Line.hidden = YES;
    
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

-(void)goback{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (UIColor *) cdBlue {
    return [UIColor colorWithRed:0.00 green:0.59 blue:0.84 alpha:1.0];
}

- (UIColor *) cdNavBlue {
    return [UIColor colorWithRed:0.00 green:0.59 blue:0.85 alpha:1.0];
}

- (void)picturePressed:(id)sender {
    
    UserAlbumViewController *albums = [[UserAlbumViewController alloc] init];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController pushViewController:albums animated:NO];
    //[self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    /*
     InstagramFieldViewController *account = [[InstagramFieldViewController alloc] init];
     [self.navigationItem setHidesBackButton:YES];
     [self.navigationController setNavigationBarHidden:NO animated:NO];
     [self.navigationController pushViewController:account animated:YES];*/
    
}


@end
