//
//  ROCardToss.h
//  RoundedFilter
//
//  Created by bw on 9/21/14.
//  Copyright (c) 2014 rounded. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <POP.h>
#import "ROTossableView.h"

@protocol ROCardTossDelegate

- (void)cardWasDismissed;

@end

@interface ROCardToss : UIViewController <ROTossableViewDelegate>

@property (nonatomic, assign) id <ROCardTossDelegate> delegate;
@property (strong, nonatomic) ROTossableView *card;
@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIButton *closeButton;

- (void)show;
- (void)hide;

@end
