//
//  ROFilterSortView.m
//  RoundedSortView
//
//  Created by bw on 10/19/14.
//  Copyright (c) 2014 rounded. All rights reserved.
//

#import "ROFilterSortView.h"
#import "ROFilterCollectionViewCell.h"
#import <PureLayout.h>

@interface ROFilterSortView ()

@end

@implementation ROFilterSortView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self styleView];
    }
    return self;
}

- (void)styleView
{            
    [self addSubview:self.filterButtonTitleLabel];
    [self addSubview:self.collectionView];
    [self addSubview:self.segmentControlTitleLabel];
    [self addSubview:self.segmentedControl];
    [self addSubview:self.applyFiltersButtonBorderTop];
    [self addSubview:self.applyFiltersButton];
    
    [self.filterButtonTitleLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.filterButtonTitleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:30];
    
    [self.collectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(65, 10, 10, 10) excludingEdge:ALEdgeBottom];
    
    [self.segmentControlTitleLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.segmentControlTitleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.collectionView withOffset:20];
    
    [self.segmentedControl autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.segmentedControl autoSetDimension:ALDimensionHeight toSize:36];
    [self.segmentedControl autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.segmentControlTitleLabel withOffset:10];
    [self.segmentedControl autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:20];
    [self.segmentedControl autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self withOffset:-20];
    
    [self.applyFiltersButtonBorderTop autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self];
    [self.applyFiltersButtonBorderTop autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self];
    [self.applyFiltersButtonBorderTop autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.applyFiltersButton];
    [self.applyFiltersButtonBorderTop autoSetDimension:ALDimensionHeight toSize:1];
    
    [self.applyFiltersButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.applyFiltersButton autoSetDimension:ALDimensionHeight toSize:50];
}

#pragma mark - Getters

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[ROFilterCollectionViewCell class] forCellWithReuseIdentifier:@"FilterCollectionViewCell"];
    }
    return _collectionView;
}

- (UILabel *)filterButtonTitleLabel
{
    if (!_filterButtonTitleLabel) {
        _filterButtonTitleLabel = [[UILabel alloc] initForAutoLayout];
        _filterButtonTitleLabel.textColor = [UIColor blackColor];
        _filterButtonTitleLabel.textAlignment = NSTextAlignmentCenter;
        _filterButtonTitleLabel.text = @"FILTER BY";
    }
    
    return _filterButtonTitleLabel;
}

- (UILabel *)segmentControlTitleLabel
{
    if (!_segmentControlTitleLabel) {
        _segmentControlTitleLabel = [[UILabel alloc] initForAutoLayout];
        _segmentControlTitleLabel.textColor = [UIColor blackColor];
        _segmentControlTitleLabel.textAlignment = NSTextAlignmentCenter;
        _segmentControlTitleLabel.text = @"SORT BY";
    }
    
    return _segmentControlTitleLabel;
}

- (UISegmentedControl *)segmentedControl
{
    if (!_segmentedControl) {
        _segmentedControl = [[UISegmentedControl alloc] initForAutoLayout];
        _segmentedControl.tintColor = [UIColor blackColor];
    }
    
    return _segmentedControl;
}

- (UIButton *)applyFiltersButton
{
    if (!_applyFiltersButton) {
        _applyFiltersButton = [[UIButton alloc] initForAutoLayout];
        [_applyFiltersButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_applyFiltersButton setTitle:@"APPLY" forState:UIControlStateNormal];
    }
    
    return _applyFiltersButton;
}

- (UIView *)applyFiltersButtonBorderTop
{
    if (!_applyFiltersButtonBorderTop) {
        _applyFiltersButtonBorderTop = [[UIView alloc] initForAutoLayout];
        _applyFiltersButtonBorderTop.backgroundColor = [UIColor grayColor];
    }
    
    return _applyFiltersButtonBorderTop;
}

@end
