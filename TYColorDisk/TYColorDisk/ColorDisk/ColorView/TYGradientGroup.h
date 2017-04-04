//
//  TYGradientGroup.h
//  TYColorDisk
//
//  Created by Demon_Yao on 8/1/15.
//  Copyright (c) 2015 Tyrone Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYGradientLayer.h"

@interface TYGradientGroup : NSObject

@property (nonatomic, strong, readonly) NSMutableArray *gradientArray;

- (NSArray *)createGradientLayersWithFrame:(CGRect)aFrame centerPoint:(CGPoint)aCenterPoint radius:(CGFloat)aRadius lineWidth:(CGFloat)lineWidth;

- (void)changeValueWithDegreeValue:(CGFloat)value direction:(AnnulusRotateDirection)direction animatable:(BOOL)animatable Block:(void (^)(CGFloat red, CGFloat green, CGFloat blue))completed;

@end
