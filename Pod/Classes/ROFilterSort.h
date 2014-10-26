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

@protocol ROFilterDelegate

- (void)applyFiltersButtonPressed;
- (void)showFilterViewButtonPressed;

@end

@interface ROFilter : UIViewController

@property (nonatomic, assign) id <ROFilterDelegate> delegate;

// The Views
@property (strong, nonatomic) ROFilterView *filterView;
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
