//
//  SwipeViewController.h
//  portal
//
//  Created by Neil Ballard on 12/13/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DraggableView.h"

@interface SwipeViewController : UIViewController<DraggableViewPic>

@property (nonatomic, strong) UINavigationBar *navBar;
+ (id)singletonInstance;
-(void)pushToAlbum;



@end
