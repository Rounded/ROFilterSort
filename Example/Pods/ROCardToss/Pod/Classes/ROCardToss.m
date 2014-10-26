//
//  ROCardToss.m
//  RoundedFilter
//
//  Created by bw on 9/21/14.
//  Copyright (c) 2014 rounded. All rights reserved.
//

#import "ROCardToss.h"
#import <PureLayout.h>

@interface ROCardToss ()

@property (strong, nonatomic) NSLayoutConstraint *verticalCardLayoutConstraint;

@end

@implementation ROCardToss


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)styleView
{
    [self.backgroundView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [self.card autoSetDimension:ALDimensionHeight toSize:380];
    [self.card autoSetDimension:ALDimensionWidth toSize:300];
    
    [self.card addSubview:self.closeButton];
    
    [self.closeButton autoSetDimension:ALDimensionHeight toSize:40];
    [self.closeButton autoSetDimension:ALDimensionWidth toSize:40];
    [self.closeButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.card withOffset:8];
    [self.closeButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.card withOffset:8];
}

#pragma mark - Public Methods

- (void)show
{
    
    if (![[[UIApplication sharedApplication].keyWindow subviews] containsObject:self.backgroundView]) {
        [[UIApplication sharedApplication].keyWindow addSubview:self.backgroundView];
    }
    
    if (![[[UIApplication sharedApplication].keyWindow subviews] containsObject:self.card]) {
        [[UIApplication sharedApplication].keyWindow addSubview:self.card];
    }
    
    CGRect keyWindowFrame = [UIApplication sharedApplication].keyWindow.frame;

    [self styleView];

    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    animation.springBounciness = 6;
    animation.springSpeed = 12;
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(keyWindowFrame.size.width/2, -keyWindowFrame.size.height)];
    animation.toValue = [NSValue valueWithCGPoint:[UIApplication sharedApplication].keyWindow.center];
    [self.card pop_addAnimation:animation forKey:@"animateCardIn"];
    animation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        
    };
    
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.fromValue = @(0.0);
    anim.toValue = @(0.8);
    [self.backgroundView pop_addAnimation:anim forKey:@"fadeIn"];
}

- (void)hide
{
    [self hideCard];
    [self hideBackgroundView];
    [self.delegate cardWasDismissed];
}

#pragma mark - Private Methods

- (void)hideCard
{

    CGRect keyWindowFrame = [UIApplication sharedApplication].keyWindow.frame;
    
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    animation.springBounciness = 6;
    animation.springSpeed = 12;
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(keyWindowFrame.size.width/2, -keyWindowFrame.size.height)];
    animation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
//        [self.card removeFromSuperview];
    };
    [self.card pop_addAnimation:animation forKey:@"animateCardOut"];
}

- (void)hideBackgroundView
{
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.fromValue = @(0.8);
    anim.toValue = @(0.0);
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
//        [self.backgroundView removeFromSuperview];
    };
    [self.backgroundView pop_addAnimation:anim forKey:@"fadeOut"];
}

#pragma mark - Delegate

- (void)cardWasTossed
{
    [self hideBackgroundView];
//    self.verticalCardLayoutConstraint.constant = -[UIApplication sharedApplication].keyWindow.frame.size.height;
    [self.delegate cardWasDismissed];
}

#pragma mark - Getters

- (ROTossableView *)card
{
    if (!_card) {
        _card = [[ROTossableView alloc] initForAutoLayout];
        _card.delegate = self;
    }
    return _card;
}

- (UIView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initForAutoLayout];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0.0;
    }
    
    return _backgroundView;
}

- (UIButton *)closeButton
{
    if (!_closeButton) {
        _closeButton = [[UIButton alloc] initForAutoLayout];
        [_closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _closeButton;
}

@end
