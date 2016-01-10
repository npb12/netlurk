//
//  DraggableView.h
//  portal
//
//  Created by Neil Ballard on 10/9/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.


#import <UIKit/UIKit.h>
#import "OverlayView.h"
#import "DataAccess.h"
#import "DeviceManager.h"
#import <linkedin-sdk/LISDK.h>
//#import "SwipeViewController.h"






@protocol DraggableViewDelegate <NSObject>

-(void)cardSwipedLeft:(UIView *)card;
-(void)cardSwipedRight:(UIView *)card;

@end

@protocol DraggableViewPic <NSObject>


-(void)pushViewControllerUsingDelegate:(UIViewController *)viewController;


@end

@interface DraggableView : UIView


@property (weak) id <DraggableViewDelegate, DraggableViewPic> delegate;


@property (nonatomic, strong)UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic)CGPoint originalPoint;
@property (nonatomic,strong)OverlayView* overlayView;


@property (strong, nonatomic) IBOutlet UIImageView *pic;
@property (strong, nonatomic) IBOutlet UIView *pickbackground;
@property (strong, nonatomic) IBOutlet UIView *cellbackground;



@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contact_time;
@property (nonatomic, strong) UILabel *num_networks;

@property (nonatomic, strong) NSString *linkedinId;
@property (nonatomic, strong) NSString *facebook;
@property (nonatomic, strong) NSString *instagram;
@property (nonatomic, strong) NSString *snapchat;

@property (strong, nonatomic) IBOutlet UIView *socialbackground;
@property (strong, nonatomic) IBOutlet UIView *snapchatbackground;
@property (strong, nonatomic) IBOutlet UITextView *snapchatlabel;




@property (strong, nonatomic) IBOutlet UIButton *facebookIcon;
@property (strong, nonatomic) IBOutlet UIButton *instagramIcon;
@property (strong, nonatomic) IBOutlet UIButton *linkedinIcon;
@property (strong, nonatomic) IBOutlet UIButton *snapchatIcon;

@property (strong, nonatomic) IBOutlet UIButton *addIcon;


@property (unsafe_unretained, nonatomic) BOOL flipsocial;

-(void)leftClickAction;
-(void)rightClickAction;


@end
