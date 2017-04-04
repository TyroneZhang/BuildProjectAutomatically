//
//  TYColorSpace.h
//  TYColorDisk
//
//  Created by Demon_Yao on 7/30/15.
//  Copyright (c) 2015 Tyrone Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYColorValue.h"

@interface TYColorSpace : NSObject

@property (nonatomic, strong) TYColorValue *startColorValue;
@property (nonatomic, strong) TYColorValue *endColorValue;

/**
 *  Initialize the object with start color value and end color value,and all of the number is in the range of [0, 255].
 */
- (instancetype)initWithStartRedValue:(float)startRed startGreenValue:(float)startGreen startBlueValue:(float)startBlue
                          endRedValue:(float)endRed endGreenValue:(float)endGreed endBlueValue:(float)endBlue;

/**
 *  Reset the start color and end color.
 */
- (void)resetColorSpace;

- (NSArray *)changeColorWithDegreeValue:(CGFloat)degree direction:(AnnulusRotateDirection)direction;

@end
