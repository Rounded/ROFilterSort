//
//  FilterCollectionViewCell.m
//  ROFilterSort
//
//  Created by bw on 8/25/14.
//  Copyright (c) 2014 Brian Weinreich. All rights reserved.
//

#import "ROFilterCollectionViewCell.h"
#import <PureLayout.h>

@implementation ROFilterCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}
- (void)setupViews
{    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.checkBox];
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints
{
    [self.titleLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self];
    [self.titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.checkBox withOffset:10];
    
    [self.checkBox autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self];
    [self.checkBox autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:10];
    [self.checkBox autoSetDimension:ALDimensionWidth toSize:18];
    [self.checkBox autoSetDimension:ALDimensionHeight toSize:19];
    
    [super updateConstraints];
}

#pragma mark - Getters

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initForAutoLayout];
        _titleLabel.textColor = [UIColor blackColor];
    }
    
    return _titleLabel;
}

- (UIImageView *)checkBox
{
    if (!_checkBox) {
        _checkBox = [[UIImageView alloc] initForAutoLayout];
        _checkBox.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    return _checkBox;
}

@end
