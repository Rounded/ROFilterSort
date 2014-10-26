//
//  ROTossableView.h
//  RoundedFilter
//
//  Created by bw on 8/31/14.
//  Copyright (c) 2014 rounded. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ROTossableViewDelegate

- (void)cardWasTossed;

@end

@interface ROTossableView : UIView

@property (nonatomic, assign) id <ROTossableViewDelegate> delegate;

@end
