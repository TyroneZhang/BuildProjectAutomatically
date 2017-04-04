//
//  TYGradientLayer.m
//  TYColorDisk
//
//  Created by Demon_Yao on 7/30/15.
//  Copyright (c) 2015 Tyrone Zhang. All rights reserved.
//

#import "TYGradientLayer.h"
#import <UIKit/UIKit.h>

@implementation TYGradientLayer

#pragma mark - Initialize Method
#pragma mark -

- (instancetype)initGradientLayerWithFrame:(CGRect)aFrame shape:(CAShapeLayer *)aShape colors:(NSArray *)aColors locations:(NSArray *)aLocations drawPoints:(NSArray *)aPoints
{
    self = [[super class] layer];
    if (self) {
        self.frame = aFrame;
        self.colors = [self getColorArrayByColorNumberArray:aColors];
        self.locations = aLocations;
        self.startPoint = [[aPoints firstObject] CGPointValue];
        self.endPoint = [[aPoints lastObject] CGPointValue];
        self.mask = aShape;
    }
    
    return self;
}

#pragma mark - Private Methods
#pragma mark -

- (NSArray *)getColorArrayByColorNumberArray:(NSArray *)aColors
{
    NSArray *startColorNumberArray = [aColors firstObject];
    NSArray *endColorNumberArray = [aColors lastObject];
    
    if (startColorNumberArray.count < 3 || endColorNumberArray.count < 3)
        return nil;
    
    UIColor *startColor = [UIColor colorWithRed:[startColorNumberArray[0] floatValue] / 255.f green:[startColorNumberArray[1] floatValue] / 255.f blue:[startColorNumberArray[2] floatValue] / 255.f alpha:1.0];
    UIColor *endColor = [UIColor colorWithRed:[endColorNumberArray[0] floatValue] / 255.f green:[endColorNumberArray[1] floatValue] / 255.f blue:[endColorNumberArray[2] floatValue] / 255.f alpha:1.0];
    
    self.colorSpace = [[TYColorSpace alloc] initWithStartRedValue:[startColorNumberArray[0] floatValue] startGreenValue:[startColorNumberArray[1] floatValue] startBlueValue:[startColorNumberArray[2] floatValue]
                                                      endRedValue:[endColorNumberArray[0] floatValue] endGreenValue:[endColorNumberArray[1] floatValue] endBlueValue:[endColorNumberArray[2] floatValue]];
    
    return @[(id)[startColor CGColor], (id)[endColor CGColor]];
}

#pragma mark - Public Methods
#pragma mark -

- (void)changeColorWithDegreeValue:(CGFloat)value direction:(AnnulusRotateDirection)direction animatable:(BOOL)animatable
{
 
    [CATransaction begin];
    [CATransaction setDisableActions:!animatable];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:0.5];
    [self setColors:[self.colorSpace changeColorWithDegreeValue:value direction:direction]];
    [CATransaction commit];
    
//    [self setColors:[self.colorSpace changeColorWithDegreeValue:value direction:direction]];
}

@end
