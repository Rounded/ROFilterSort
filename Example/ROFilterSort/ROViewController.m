//
//  ROViewController.m
//  ROFilterSort
//
//  Created by Brian Weinreich on 10/26/2014.
//  Copyright (c) 2014 Brian Weinreich. All rights reserved.
//

#import "ROViewController.h"
#import <ROCardToss.h>
#import <ROFilterSort.h>
#import <PureLayout.h>

@interface ROViewController () <ROCardTossDelegate, ROFilterSortDelegate>

@property (strong,nonatomic) ROFilterSort *filterSort;
@property (strong,nonatomic) ROCardToss *cardToss;

@end

@implementation ROViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // This example uses the card toss to display the filterSortView, but you can use any view you'd like!
    [self filterSortWithCard];
}

- (void)filterSortWithCard
{
    // Setup the data
    [self.filterSort setupFilterButtonTitles:@[@"Red", @"Green", @"White", @"Black", @"Yellow", @"Orange", @"Purple", @"All"] andSelectedIndexes:RSNSMutableIndexSetMake(1,3)];
    [self.filterSort setupSegmentedControlTitles:@[@"Date", @"Alpha", @"Rating"] andSelectedIndex:2];
    
    // Add the filterSortBar to this View and filterSortView to the Card
    [self.view addSubview:self.filterSort.filterSortBar];
    [self.cardToss.card addSubview:self.filterSort.filterSortView];
    
    // Setup their constraints (We use PureLayout)
    [self.filterSort.filterSortBar autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.filterSort.filterSortBar autoSetDimension:ALDimensionHeight toSize:44];
    [self.filterSort.filterSortView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

#pragma mark - Delegates

- (void)showFilterSortViewButtonPressed
{
    [self.cardToss show];
}

- (void)applyFiltersButtonPressed
{
    [self.cardToss hide];
}

- (void)cardWasDismissed
{
    NSLog(@"Card was dismissed");
}

# pragma mark - Getters

- (ROCardToss *)cardToss
{
    if (!_cardToss) {
        _cardToss = [ROCardToss new];
        _cardToss.delegate = self;
    }
    
    return _cardToss;
}

- (ROFilterSort *)filterSort
{
    if (!_filterSort) {
        _filterSort = [ROFilterSort new];
        _filterSort.delegate = self;
    }
    return _filterSort;
}

@end
