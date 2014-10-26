//
//  FilterSortView.h
//  RoundedSortView
//
//  Created by bw on 10/19/14.
//  Copyright (c) 2014 rounded. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ROFilterSortView : UIView

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) UILabel *filterButtonTitleLabel;

@property (strong, nonatomic) UILabel *segmentControlTitleLabel;
@property (strong, nonatomic) UISegmentedControl *segmentedControl;

@property (strong, nonatomic) UIButton *applyFiltersButton;
@property (strong, nonatomic) UIView *applyFiltersButtonBorderTop;

@end
