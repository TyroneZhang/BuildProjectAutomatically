//
//  TYColorSpace.m
//  TYColorDisk
//
//  Created by Demon_Yao on 7/30/15.
//  Copyright (c) 2015 Tyrone Zhang. All rights reserved.
//

#import "TYColorSpace.h"

extern const float kMaxColorValue;

@implementation TYColorSpace

#pragma mark - Initialize method
#pragma mark -

- (instancetype)init
{
    return [self initWithStartRedValue:kMaxColorValue startGreenValue:kMaxColorValue startBlueValue:kMaxColorValue
                           endRedValue:kMaxColorValue endGreenValue:kMaxColorValue endBlueValue:kMaxColorValue];
}

- (instancetype)initWithStartRedValue:(float)startRed startGreenValue:(float)startGreen startBlueValue:(float)startBlue endRedValue:(float)endRed endGreenValue:(float)endGreed endBlueValue:(float)endBlue
{
    if (self = [super init]) {
        self.startColorValue = [[TYColorValue alloc] initWithRedValue:startRed
                                                           greenValue:startGreen
                                                            blueValue:startBlue];
        self.endColorValue = [[TYColorValue alloc] initWithRedValue:endRed
                                                         greenValue:endGreed
                                                          blueValue:endBlue];
    }
    
    return self;
}

#pragma mark - Public Methods
#pragma mark -

- (void)resetColorSpace
{
    [self.startColorValue resetColorValue];
    [self.endColorValue resetColorValue];
}

- (NSArray *)changeColorWithDegreeValue:(CGFloat)degree direction:(AnnulusRotateDirection)direction
{
    id sColorRef = (id)[self.startColorValue changeColorWithDegreeValue:degree direction:direction];
    id eColroRef = (id)[self.endColorValue changeColorWithDegreeValue:degree direction:direction];
    
    return @[sColorRef, eColroRef];
}

@end
