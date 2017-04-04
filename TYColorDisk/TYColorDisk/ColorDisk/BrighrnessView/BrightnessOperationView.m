//
//  BrightnessOperationView.m
//  TYColorDisk
//
//  Created by Demon_Yao on 8/3/15.
//  Copyright (c) 2015 Tyrone Zhang. All rights reserved.
//

#import "BrightnessOperationView.h"

const NSInteger kMaxOfBrightnessNumber = 100;
static const NSInteger kMinOfBrightnessNumber = 1;

@interface BrightnessOperationView () <UIScrollViewDelegate>
{
    float _maxHeight;
    float _perHeight;
    NSInteger _brightNum;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation BrightnessOperationView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
}


- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [self initializeScrollView];
}

- (void)initializeScrollView
{
    if (self.scrollView) {
        [self.scrollView removeFromSuperview];
    }
    
    //  The width of scroll view
    float scrollViewWidth = sqrtf(2) * (CGRectGetWidth(self.frame) / 2.0);
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, scrollViewWidth, scrollViewWidth)];
    self.scrollView.center = CGPointMake(CGRectGetWidth(self.frame)/2.0, CGRectGetHeight(self.frame)/2.0);
    self.scrollView.backgroundColor = [UIColor clearColor];
    float lineWidth = scrollViewWidth/4.0;
    for (int i = 0; i < 3; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((scrollViewWidth - lineWidth)/2.0,i*scrollViewWidth + (scrollViewWidth - lineWidth)/2.0, lineWidth, lineWidth)];
        imgView.image = [UIImage imageNamed:@"body_ gliding_42x42.png"];
        [self.scrollView addSubview:imgView];
    }
    self.scrollView.delegate = self;
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    self.scrollView.contentSize = CGSizeMake(scrollViewWidth, scrollViewWidth * 3);
    [self addSubview:self.scrollView];
    
    _maxHeight = scrollViewWidth * 2;
    _perHeight = _maxHeight/100.0;
}

#pragma mark - Delegate
#pragma mark - 

#pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y <= _perHeight) { // 1%
        _brightNum = kMinOfBrightnessNumber;
    } else if (scrollView.contentOffset.y >= _maxHeight) { // 100%
        _brightNum = kMaxOfBrightnessNumber;
    } else {
        float distance = scrollView.contentOffset.y;
        _brightNum = distance/_perHeight;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(brightnessDidChanged:)]) {
        [self.delegate brightnessDidChanged:_brightNum];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y <= _perHeight) {
        _brightNum = kMinOfBrightnessNumber;
    } else if (scrollView.contentOffset.y >= _maxHeight) {
        _brightNum = kMaxOfBrightnessNumber;
    } else {
        float distance = scrollView.contentOffset.y;
        _brightNum = distance/_perHeight;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(brightnessDidChanged:)]) {
        [self.delegate brightnessDidChanged:_brightNum];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (decelerate == NO) {
        if(scrollView.contentOffset.y <= _perHeight) {
            _brightNum = kMinOfBrightnessNumber;
        } else if (scrollView.contentOffset.y >= _maxHeight) {
            _brightNum = kMaxOfBrightnessNumber;
        } else {
            float distance = scrollView.contentOffset.y;
            _brightNum = distance/_perHeight;
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(brightnessDidChanged:)]) {
        [self.delegate brightnessDidChanged:_brightNum];
    }
}

@end
