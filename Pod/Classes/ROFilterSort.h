//
//  ROFilterSort.h
//  Rounded
//
//  Created by bw on 8/25/14.
//  Copyright (c) 2014 Brian Weinreich. All rights reserved.
//

// Mutiple Index Sets
#ifndef RSNSMutableIndexSetMake
#ifndef RSNSIndexSetMake
#define RSNSMutableIndexSetMake(INDEXES...)                                              \
({                                                                                   \
NSUInteger indexes[] = {INDEXES};                                                \
NSUInteger count = sizeof(indexes)/sizeof(NSUInteger);                           \
NSMutableIndexSet *mutableIndexSet = [NSMutableIndexSet indexSet];               \
for (int i = 0; i < count; ++i){                                                 \
[mutableIndexSet addIndex:indexes[i]];                                       \
}                                                                                \
mutableIndexSet;                                                                 \
})
#define RSNSIndexSetMake(INDEXES...)                                                     \
({                                                                                   \
[[NSIndexSet alloc] initWithIndexSet:RSNSMutableIndexSetMake(INDEXES)];          \
})
#endif
#endif


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
