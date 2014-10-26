//
//  FilterBarSortView.h
//  ROFilterSortBar
//
//  Created by bw on 8/31/14.
//  Copyright (c) 2014 rounded. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ROFilterSortBarDelegate
@end

@interface ROFilterSortBar : UIView

@property (strong, nonatomic) UIButton *showFilterSortViewButton;
@property (nonatomic, assign) id <ROFilterSortBarDelegate> delegate;
@property (strong, nonatomic) UIScrollView *scrollView;

- (void)refresh;

@end