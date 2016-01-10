//
//  DraggableViewBackground.h
//  portal
//
//  Created by Neil Ballard on 10/9/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "DraggableView.h"

@interface DraggableViewBackground : UIView <DraggableViewDelegate, UITextFieldDelegate>

//methods called in DraggableView
-(void)cardSwipedLeft:(UIView *)card;
-(void)cardSwipedRight:(UIView *)card;

@property (retain,nonatomic)NSArray* exampleCardLabels; //%%% the labels the cards
@property (retain,nonatomic)NSMutableArray* allCards; //%%% the labels the cards

@property (strong, nonatomic) IBOutlet UITextField *searchTextField;



@property (strong, nonatomic) IBOutlet UILabel *label123;
@property (strong, nonatomic) IBOutlet UILabel *a;
@property (strong, nonatomic) IBOutlet UILabel *b;
@property (strong, nonatomic) IBOutlet UILabel *c;
@property (strong, nonatomic) IBOutlet UILabel *d;
@property (strong, nonatomic) IBOutlet UILabel *e;
@property (strong, nonatomic) IBOutlet UILabel *f;
@property (strong, nonatomic) IBOutlet UILabel *g;
@property (strong, nonatomic) IBOutlet UILabel *h;
@property (strong, nonatomic) IBOutlet UILabel *i;
@property (strong, nonatomic) IBOutlet UILabel *j;
@property (strong, nonatomic) IBOutlet UILabel *k;
@property (strong, nonatomic) IBOutlet UILabel *l;
@property (strong, nonatomic) IBOutlet UILabel *m;
@property (strong, nonatomic) IBOutlet UILabel *n;
@property (strong, nonatomic) IBOutlet UILabel *o;
@property (strong, nonatomic) IBOutlet UILabel *p;
@property (strong, nonatomic) IBOutlet UILabel *q;
@property (strong, nonatomic) IBOutlet UILabel *r;
@property (strong, nonatomic) IBOutlet UILabel *s;
@property (strong, nonatomic) IBOutlet UILabel *t;
@property (strong, nonatomic) IBOutlet UILabel *u;
@property (strong, nonatomic) IBOutlet UILabel *v;
@property (strong, nonatomic) IBOutlet UILabel *w;
@property (strong, nonatomic) IBOutlet UILabel *x;
@property (strong, nonatomic) IBOutlet UILabel *y;
@property (strong, nonatomic) IBOutlet UILabel *z;



@end
