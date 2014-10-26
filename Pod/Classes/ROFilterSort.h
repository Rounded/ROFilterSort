//
//  ROFilterSort.h
//  Rounded
//
//  Created by bw on 8/25/14.
//  Copyright (c) 2014 Brian Weinreich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ROFilterSortBar.h"
#import "ROFilterSortView.h"

@protocol ROFilterSortDelegate

- (void)applyFiltersButtonPressed;
- (void)showFilterSortViewButtonPressed;

@end

@interface ROFilterSort : UIViewController

@property (nonatomic, assign) id <ROFilterSortDelegate> delegate;

// The Views
@property (strong, nonatomic) ROFilterSortView *filterSortView;
@property (strong, nonatomic) ROFilterSortBar *filterSortBar;

// The Data
@property (strong, nonatomic) NSArray *filterButtonTitles;
@property (strong, nonatomic) NSMutableIndexSet *filterButtonSelectedIndexes;
@property (strong, nonatomic) NSArray *segmentedControlTitles;
@property (nonatomic) NSInteger segmentedControlSelectedIndex;

@property (nonatomic) BOOL disableFilterButtons;

// Methods to set the data
- (void)setupFilterButtonTitles:(NSArray *)titles andSelectedIndexes:(NSMutableIndexSet *)selectedIndexes;
- (void)setupSegmentedControlTitles:(NSArray *)titles andSelectedIndex:(NSInteger)selectedIndex;

@end
