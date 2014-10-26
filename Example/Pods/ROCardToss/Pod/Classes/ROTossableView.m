//
//  ROTossableView.m
//  RoundedFilter
//
//  Created by bw on 8/31/14.
//  Copyright (c) 2014 rounded. All rights reserved.
//
// Credit to: Guti ( https://github.com/ngutman )
//

#import "ROTossableView.h"
#import <POP.h>

@interface ROTossableView ()

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property(nonatomic) CGPoint originalPoint;

@end

@implementation ROTossableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self styleView];
        self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragged:)];
        [self addGestureRecognizer:self.panGestureRecognizer];
    }
    return self;
}

- (void)styleView
{
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
}

- (void)dragged:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGFloat xDistance = [gestureRecognizer translationInView:self].x;
    CGFloat yDistance = [gestureRecognizer translationInView:self].y;
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:{
            self.originalPoint = self.center;
            break;
        };
        case UIGestureRecognizerStateChanged:{
            CGFloat rotationStrength = MIN(xDistance / 320, 1);
            CGFloat rotationAngel = (CGFloat) (2*M_PI/16 * rotationStrength);
            CGFloat scaleStrength = 1 - fabsf(rotationStrength) / 4;
            CGFloat scale = MAX(scaleStrength, 0.93);
            CGAffineTransform transform = CGAffineTransformMakeRotation(rotationAngel);
            CGAffineTransform scaleTransform = CGAffineTransformScale(transform, scale, scale);
            self.transform = scaleTransform;
            self.center = CGPointMake(self.originalPoint.x + xDistance, self.originalPoint.y + yDistance);
            break;
        };
        case UIGestureRecognizerStateEnded: {
            [self afterSwipeAction];
            break;
        };
        case UIGestureRecognizerStatePossible:break;
        case UIGestureRecognizerStateCancelled:break;
        case UIGestureRecognizerStateFailed:break;
    }
}

- (void)afterSwipeAction
{
    if (self.center.y > 280+120) {
        [self throwAwayCardToPoint:CGPointMake(self.center.x, 960)];
    } else if (self.center.y < 280-120) {
        [self throwAwayCardToPoint:CGPointMake(self.center.x, -480)];
    } else if (self.center.x > 290) {
        [self throwAwayCardToPoint:CGPointMake(640, self.center.y)];
    } else if (self.center.x < 20) {
        [self throwAwayCardToPoint:CGPointMake(-320, self.center.y)];
    } else {

        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
        animation.springBounciness = 6;
        animation.springSpeed = 12;
        animation.toValue = [NSValue valueWithCGPoint:self.originalPoint];
        [self pop_addAnimation:animation forKey:@"animateBackToCenter"];

        [UIView animateWithDuration:0.2 animations:^{
            self.transform = CGAffineTransformMakeRotation(0);
        }];
    }
}

- (void)throwAwayCardToPoint:(CGPoint)finishPoint
{
    [UIView animateWithDuration:0.3 animations:^{
        NSLog(@"before: %f %f",self.center.x, self.center.y);
        self.center = finishPoint;
        NSLog(@"after: %f %f",self.center.x, self.center.y);
        
        BOOL xVector = finishPoint.x > 160;
        BOOL yVector = finishPoint.y < 280;
        
        if (xVector) {
            // Flung right
            if (yVector) {
                // Flung up
                self.transform = CGAffineTransformMakeRotation(-180);
            } else {
                // Flung down
                self.transform = CGAffineTransformMakeRotation(-180);
            }
        } else {
            // Flung left
            if (yVector) {
                // Flung up
                self.transform = CGAffineTransformMakeRotation(180);
            } else {
                // Flung down
                self.transform = CGAffineTransformMakeRotation(180);
            }
        }
        
    } completion:^(BOOL complete){
//        [self removeFromSuperview];
        self.transform = CGAffineTransformMakeRotation(0);
    }];
    
    [self.delegate cardWasTossed];
}


@end
