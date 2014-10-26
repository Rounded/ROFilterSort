//
//  ROFilterSort.m
//  ROFilterSortBar
//
//  Created by bw on 8/25/14.
//  Copyright (c) 2014 Brian Weinreich. All rights reserved.
//

#import "ROFilterSort.h"
#import "ROFilterCollectionViewCell.h"
#import <POP.h>
#import <PureLayout.h>

@interface ROFilterSort () <ROFilterSortBarDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSLayoutConstraint *filterContainerLayoutConstraint;
@property (strong, nonatomic) NSMutableIndexSet *filterButtonSelectedIndexesTemp;
@property (nonatomic) NSInteger segmentedControlSelectedIndexTemp;

@end

@implementation ROFilterSort

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self styleView];
}

- (void)styleView
{
    [self.filterSortView.collectionView autoSetDimension:ALDimensionHeight toSize:35*((self.filterButtonTitles.count+2-1)/2)];
}


#pragma mark - Data setup

- (void)setupFilterButtonTitles:(NSArray *)titles andSelectedIndexes:(NSMutableIndexSet *)selectedIndexes
{
    self.filterButtonTitles = titles;
    self.filterButtonSelectedIndexes = selectedIndexes;
    self.filterButtonSelectedIndexesTemp = selectedIndexes;
    [self.filterSortBar refresh];
    [self styleView];
}

- (void)setupSegmentedControlTitles:(NSArray *)titles andSelectedIndex:(NSInteger)selectedIndex
{
    self.segmentedControlTitles = titles;
    self.segmentedControlSelectedIndex = selectedIndex;
    self.segmentedControlSelectedIndexTemp = selectedIndex;
    
    [self.filterSortView.segmentedControl removeAllSegments];
    [self.segmentedControlTitles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL *stop) {
        [self.filterSortView.segmentedControl insertSegmentWithTitle:title atIndex:idx animated:NO];
    }];
    [self.filterSortView.segmentedControl setSelectedSegmentIndex:self.segmentedControlSelectedIndexTemp];
    [self.filterSortBar refresh];
}

#pragma mark - CollectionView Delegate / Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.filterButtonTitles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ROFilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FilterCollectionViewCell" forIndexPath:indexPath];
    
    NSString *bundlePath = [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"ROFilterSort.bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    
    cell.titleLabel.text = self.filterButtonTitles[indexPath.row];
    cell.checkBox.image = [self.filterButtonSelectedIndexesTemp containsIndex:indexPath.row] ? [UIImage imageNamed:@"checked.png" inBundle:bundle compatibleWithTraitCollection:nil] : [UIImage imageNamed:@"ROFilterSort.bundle/unchecked"];
    
    cell.checkBox.alpha = self.disableFilterButtons==1 ? 0.4 : 1.0;
    cell.titleLabel.alpha = self.disableFilterButtons==1 ? 0.4 : 1.0;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((collectionView.frame.size.width/2)-5, 25);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.disableFilterButtons==0) {
        if ([self.filterButtonTitles[indexPath.row] isEqualToString:@"All"]) {
            if ([self.filterButtonSelectedIndexesTemp containsIndex:indexPath.row]) {
                self.filterButtonSelectedIndexesTemp = [NSMutableIndexSet new];
            } else {
                self.filterButtonSelectedIndexesTemp = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.filterButtonTitles.count)];
            }
        } else {
            if ([self.filterButtonSelectedIndexesTemp containsIndex:indexPath.row]) {
                [self.filterButtonSelectedIndexesTemp removeIndex:indexPath.row];
                [self.filterButtonSelectedIndexesTemp removeIndex:self.filterButtonTitles.count-1];
            } else {
                [self.filterButtonSelectedIndexesTemp addIndex:indexPath.row];
            }
        }
        [self.filterSortView.collectionView reloadData];
    }
}


#pragma mark - Actions

- (void)showFilterSortViewButtonPressed
{
    [self.filterSortView.collectionView reloadData];
    [self.delegate showFilterSortViewButtonPressed];
}

- (void)applyFilters
{
    self.filterButtonSelectedIndexes = self.filterButtonSelectedIndexesTemp;
    self.segmentedControlSelectedIndex = self.segmentedControlSelectedIndexTemp;
    [self.filterSortBar refresh];
    [self.delegate applyFiltersButtonPressed];
}

- (void)segmentChanged
{
    self.segmentedControlSelectedIndexTemp = self.filterSortView.segmentedControl.selectedSegmentIndex;
}

#pragma mark - Getters

- (NSMutableIndexSet *)filterButtonSelectedIndexes
{
    if (!_filterButtonSelectedIndexes) {
        _filterButtonSelectedIndexes = [[NSMutableIndexSet alloc] init];
    }

    return _filterButtonSelectedIndexes;
}

- (NSMutableIndexSet *)filterButtonSelectedIndexesTemp
{
    if (!_filterButtonSelectedIndexesTemp) {
        _filterButtonSelectedIndexesTemp = [[NSMutableIndexSet alloc] init];
    }

    return _filterButtonSelectedIndexesTemp;
}

- (ROFilterSortBar *)filterSortBar
{
    if (!_filterSortBar) {
        _filterSortBar = [[ROFilterSortBar alloc] initForAutoLayout];
        _filterSortBar.delegate = self;
        [_filterSortBar.showFilterSortViewButton addTarget:self action:@selector(showFilterSortViewButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _filterSortBar;
}

- (ROFilterSortView *)filterSortView
{
    if (!_filterSortView) {
        _filterSortView = [[ROFilterSortView alloc] initForAutoLayout];
        _filterSortView.collectionView.delegate = self;
        _filterSortView.collectionView.dataSource = self;
        [_filterSortView.segmentedControl addTarget:self action:@selector(segmentChanged) forControlEvents:UIControlEventValueChanged];
        [_filterSortView.applyFiltersButton addTarget:self action:@selector(applyFilters) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _filterSortView;
}

@end
