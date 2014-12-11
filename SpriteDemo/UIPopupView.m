//
//  UIPopupView.m
//  SpriteDemo
//
//  Created by Le Cong on 12/11/14.
//  Copyright (c) 2014 Lê Công. All rights reserved.
//

#import "UIPopupView.h"

@implementation UIPopupView {
    UIView *backgroundView;
    UIView *foregroundView;
    UIButton *btnClose;
    
}

- (id)init {
    self = [super init];
    if (self) {
        [self initCompoment];
    }
    return self;
}

- (void)initCompoment {
    backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 568, 320)];
    backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];

    foregroundView = [[UIView alloc] initWithFrame:CGRectMake(0, -320, 568, 320)];
    foregroundView.backgroundColor = [UIColor clearColor];
    
    UIImage *imageClose = [UIImage imageNamed:@"btnClose"];
    btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    btnClose.frame = CGRectMake(54, 284, imageClose.size.width, imageClose.size.height);
    [btnClose setImage:imageClose forState:UIControlStateNormal];
    [btnClose addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *bgContentView = [UIImage imageNamed:@"bgPopupView"];
    UIImageView *imvBgContentView = [[UIImageView alloc] initWithImage:bgContentView];
    imvBgContentView.frame = CGRectMake(54, 0, bgContentView.size.width, bgContentView.size.height);
    [foregroundView addSubview:imvBgContentView];
    
    [foregroundView addSubview:btnClose];
    
    [foregroundView addSubview:[self viewForContentView]];
}

- (UIView *)viewForContentView {
    return nil;
}

- (void)showinView:(UIView *)view {
    
    [view addSubview:backgroundView];
    [view addSubview:foregroundView];
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGRect frame = foregroundView.frame;
        frame.origin.y = 0;
        foregroundView.frame = frame;
    } completion:^(BOOL finished) {
    }];
}

- (void)closeView {
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGRect frame = foregroundView.frame;
        frame.origin.y = -320;
        foregroundView.frame = frame;
    } completion:^(BOOL finished) {
        [foregroundView removeFromSuperview];
        [backgroundView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

@end
