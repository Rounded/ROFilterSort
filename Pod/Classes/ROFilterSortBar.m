//
//  FilterSortBarView.m
//  RoundedSortView
//
//  Created by bw on 8/31/14.
//  Copyright (c) 2014 rounded. All rights reserved.
//

#import "ROFilterSortBar.h"
#import "ROFilterSort.h"
#import <POP.h>
#import <PureLayout.h>

@interface ROFilterSortBar ()

@property (strong, nonatomic) NSMutableArray *filterBarLabels;
@property (strong, nonatomic) NSMutableArray *constraints;

@end

@implementation ROFilterSortBar

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
    self.backgroundColor = [UIColor lightGrayColor];
    
    [self addSubview:self.showFilterSortViewButton];
    [self addSubview:self.scrollView];
    
    [self.showFilterSortViewButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeLeft];

    [self.scrollView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeRight];
    [self.scrollView autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.showFilterSortViewButton withOffset:-10];
}

- (void)refresh
{
    if (self.filterBarLabels.count == 0) {
        [((ROFilter *)self.delegate).filterButtonTitles enumerateObjectsUsingBlock:^(NSString *filterButtonTitle, NSUInteger idx, BOOL *stop) {

            UILabel *label = [[UILabel alloc] initForAutoLayout];
            label.text = [NSString stringWithFormat:@" %@ ", filterButtonTitle]; // whoa this is a hack! ill get to fixing it
            label.lineBreakMode = NSLineBreakByClipping;
            label.translatesAutoresizingMaskIntoConstraints = NO;
            [label sizeToFit];
            [self.scrollView addSubview:label];

            if (idx==0) {
                [label autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.scrollView withOffset:12];
            } else {
                [label autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:[self.filterBarLabels objectAtIndex:idx-1] withOffset:0];
            }
            
            [label autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
            NSLayoutConstraint *constraint = [label autoSetDimension:ALDimensionWidth toSize:label.frame.size.width];
            [self.filterBarLabels addObject:label];
            [self.constraints addObject:constraint];
        }];
    }
    
    [((ROFilter *)self.delegate).filterButtonTitles enumerateObjectsUsingBlock:^(NSString *filterButtonTitle, NSUInteger idx, BOOL *stop) {
        if ([((ROFilter *)self.delegate).filterButtonSelectedIndexes containsIndex:idx]) {
            // We're showing a label in the bar!
            if (((UILabel *)[self.filterBarLabels objectAtIndex:idx]).alpha == 0) {
                POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayoutConstraintConstant];
                [[self.filterBarLabels objectAtIndex:idx] sizeToFit];
                animation.toValue = @(((UILabel *)[self.filterBarLabels objectAtIndex:idx]).frame.size.width);
                animation.duration = 0.1;
                [[self.constraints objectAtIndex:idx] pop_addAnimation:animation forKey:@"popInWidth"];
                animation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
                    [[self.filterBarLabels objectAtIndex:idx] setAlpha:1.0];

                    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
                    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
                    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
                    animation.springBounciness = 8;
                    animation.springSpeed = 14;
                    [[self.filterBarLabels objectAtIndex:idx] pop_addAnimation:animation forKey:@"popInScale"];
                    [self resizeScrollView];
                };
            }
        } else {
            // We're hiding a label in the bar!
            POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerSize];
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            animation.toValue = [NSValue valueWithCGSize:CGSizeMake(0, 0)];
            animation.duration = 0.2;
            [[self.filterBarLabels objectAtIndex:idx] pop_addAnimation:animation forKey:@"popOutSize"];
            animation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
                [[self.filterBarLabels objectAtIndex:idx] setAlpha:0];
                POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayoutConstraintConstant];
                animation.toValue = @0;
                [[self.constraints objectAtIndex:idx] pop_addAnimation:animation forKey:@"popOutWidth"];
                animation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
                    [self resizeScrollView];
                };
            };
        }
    }];
}

// Resize ScrollView based on content
- (void)resizeScrollView
{
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrollView.subviews) {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.scrollView.contentSize = CGSizeMake(contentRect.size.width, self.frame.size.height);
}

#pragma mark - Getters

- (UIButton *)showFilterSortViewButton
{
    if (!_showFilterSortViewButton) {
        _showFilterSortViewButton = [[UIButton alloc] initForAutoLayout];
        [_showFilterSortViewButton setBackgroundColor:[UIColor blackColor]];
        [_showFilterSortViewButton setTitle:@"Launch Filter" forState:UIControlStateNormal];
        [_showFilterSortViewButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    return _showFilterSortViewButton;
}

- (NSMutableArray *)constraints
{
    if (!_constraints) {
        _constraints = [NSMutableArray new];
    }
    
    return _constraints;
}

- (NSMutableArray *)filterBarLabels
{
    if (!_filterBarLabels) {
        _filterBarLabels = [NSMutableArray new];
    }
    
    return _filterBarLabels;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initForAutoLayout];
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.clipsToBounds = YES;

    }
    
    return _scrollView;
}

@end
