//
//  SwipeViewController.m
//  portal
//
//  Created by Neil Ballard on 12/13/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import "SwipeViewController.h"
#import "DraggableViewBackground.h"

@interface SwipeViewController ()

@end

@implementation SwipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self styleNavBar];
    [self addMainView];

    // Do any additional setup after loading the view.
}



-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
    [self.navigationItem setHidesBackButton:YES];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    [self styleNavBar];
    
}

-(void)addMainView{
    
    DraggableViewBackground *draggableBackground = [[DraggableViewBackground alloc]init];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    draggableBackground.translatesAutoresizingMaskIntoConstraints = NO;
    [draggableBackground invalidateIntrinsicContentSize];
    
 //   draggableBackground.layer.masksToBounds = NO;
 //   self.tableBack.layer.shadowOffset = CGSizeMake(-.1, .2);
 //   self.tableBack.layer.shadowRadius = .5;
 ///   self.tableBack.layer.shadowOpacity = 0.5;
    
    //
    
    //
    
    //
    
    //
    
    
    CGFloat pad = 0, sub;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 0;
        sub = 64;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 0;
        sub = 70;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 0;
        sub = 80;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 0;
        sub = 55;
    }
    
    CGFloat height = CGRectGetHeight([[UIScreen mainScreen] bounds]) - sub;

    
    [self.view addSubview:draggableBackground];
    
    
    
    NSDictionary *viewsDictionary = @{@"back":draggableBackground, @"top": self.navBar};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:draggableBackground attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:draggableBackground attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:draggableBackground attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
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
    
    UIImage *connections_image = [[UIImage imageNamed:@"connections"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:connections_image  style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonPressed:)];
    
    UIImage *image = [[UIImage imageNamed:@"settings"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonPressed:)];
    
    
    newItem.rightBarButtonItem = rightBtn;
    newItem.leftBarButtonItem = leftBtn;
    
    
    UIButton *titleView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [titleView setUserInteractionEnabled:NO];
    
    NSString *titleText = @"Portal";
    [titleView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [titleView setTitle:titleText forState:UIControlStateNormal];
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end