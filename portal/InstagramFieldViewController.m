//
//  InstagramFieldViewController.m
//  portal
//
//  Created by Neil Ballard on 10/20/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import "InstagramFieldViewController.h"

@interface InstagramFieldViewController ()

@property (nonatomic, retain) UIView * background;
@property (nonatomic, retain) UIView * Line;
@property (nonatomic, retain) UIView * firstLine;
@property (nonatomic, retain) UIImageView * background_image;
@property (nonatomic,unsafe_unretained) CGRect mainScreenBounds;

@property (nonatomic, retain) UINavigationBar * navBar;

@end

@implementation InstagramFieldViewController

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
    [self setupnetworkTextField];
    [self addLine];
}

- (void)initViewItems {
    self.networkTextField = [[UITextField alloc] init];
    [self.view addSubview:self.networkTextField];
    

    
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
    
    self.networksLabel.text = @"Instagram";
    
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

- (void)setupnetworkTextField {
    self.networkTextField.delegate = self;
    self.networkTextField.layer.cornerRadius = 7.0;
    self.networkTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.networkTextField invalidateIntrinsicContentSize];
    
    if ([[DataAccess singletonInstance] getInstagram] != nil) {
        self.networkTextField.text = [[DataAccess singletonInstance] getInstagram];
    }
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat height = 0, width = 0, xpad = 0, ypad = 0;
    width = screen.size.width - 30;
    
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        self.networkTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:ceilf(32/2)];
        height = 40;
        xpad = 15;
        ypad = 8;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        self.networkTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:ceilf(38/2)];
        height = 35;
        xpad = 15;
        ypad = 10;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        self.networkTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:ceilf(62/3)];
        height = 45;
        xpad = 15;
        ypad = 10;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad])
    {
        self.networkTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:ceilf(28/2)];
        height = 30;
        xpad = 15;
        ypad = 0;
    }
    
    self.networkTextField.backgroundColor = [UIColor whiteColor];
    self.networkTextField.layer.borderColor = [UIColor blackColor].CGColor;
    self.networkTextField.layer.borderWidth = 1;
    self.networkTextField.layer.masksToBounds = true;
    
    NSMutableDictionary *viewsDictionary = [[NSMutableDictionary alloc] init];
    [viewsDictionary setObject:self.networkTextField forKey:@"textField"];
    [viewsDictionary setObject:self.firstLine forKey:@"label"];
    
    NSArray *hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-xpad-[textField]" options:0 metrics:@{@"xpad" : [NSNumber numberWithFloat:xpad], @"width" : [NSNumber numberWithFloat:width]} views:viewsDictionary];
    NSArray *vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[label]-pad-[textField(height)]" options:0 metrics:@{@"height" : [NSNumber numberWithFloat:height], @"pad" : [NSNumber numberWithFloat:ypad]} views:viewsDictionary];
    
    [self.view addConstraints:hConstraints];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.networkTextField attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width]];
    
    [self.view addConstraints:vConstraints];
    
}






- (void)textFieldDidChange {
    //
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [textField setReturnKeyType:UIReturnKeyDone];
    return TRUE;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.networkTextField resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [[DataAccess singletonInstance] setInstagram:self.networkTextField.text];
    [self.networkTextField resignFirstResponder];
    [self.networkTextField endEditing:YES];
}


- (void)touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event {
    NSArray *subviews = [self.view subviews];
    for (id objects in subviews) {
        if ([objects isKindOfClass:[UITextField class]]) {
            UITextField *theTextField = objects;
            if ([objects isFirstResponder]) {
                [theTextField resignFirstResponder];
            }
        }
    }
}

-(void)goback{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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

-(UIColor*)lineColor{
    
    return [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.0];
    
    
}


-(UIColor*)grayColor{
    
    return [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.0];
}
@end
