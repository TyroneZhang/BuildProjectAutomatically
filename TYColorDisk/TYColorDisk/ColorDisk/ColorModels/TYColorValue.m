//
//  TYColorValue.m
//  TYColorDisk
//
//  Created by Demon_Yao on 7/30/15.
//  Copyright (c) 2015 Tyrone Zhang. All rights reserved.
//

#import "TYColorValue.h"

const float kMaxColorValue = 255.f;

typedef NS_ENUM(NSInteger, ColorRange) {
    ErrorColorRange,
    RedColorRange,        // [FF0000,FFFF00]
    YellowColorRange,     // [FFFF00,00FF00]
    GreenColorRange,      // [00FF00,00FFFF]
    CyanColorRange,       // [00FFFF,0000FF]
    BlueColorRange,       // [0000FF,FF00FF]
    PurpleColorRange,     // [FF00FF,FF0000]
};

@interface TYColorValue ()

@property (nonatomic, assign) float sourceRedValue;
@property (nonatomic, assign) float sourceGreenValue;
@property (nonatomic, assign) float sourceBlueValue;

@end

@implementation TYColorValue

#pragma mark - Initialize method
#pragma mark -

- (instancetype)init
{
    return [self initWithRedValue:kMaxColorValue
                       greenValue:kMaxColorValue
                        blueValue:kMaxColorValue];
}

- (id)initWithRedValue:(float)red greenValue:(float)green blueValue:(float)blue
{
    self = [super init];
    if (self) {
        self.redValue = MIN(red, kMaxColorValue);
        self.greenValue = MIN(green, kMaxColorValue);
        self.blueValue = MIN(blue, kMaxColorValue);
        
        self.sourceRedValue = self.redValue;
        self.sourceGreenValue = self.greenValue;
        self.sourceBlueValue = self.sourceBlueValue;
    }
    
    return self;
}

#pragma mark - Public Methods
#pragma mark - 

- (void)resetColorValue
{
    self.redValue = self.sourceRedValue;
    self.greenValue = self.sourceGreenValue;
    self.blueValue = self.sourceBlueValue;
}

- (CGColorRef)changeColorWithDegreeValue:(CGFloat)degree direction:(AnnulusRotateDirection)direction
{
    ColorRange range = [self judgeColorRange];
    
    switch (range) {
        case RedColorRange:
            [self changeFromRedRange:degree direction:direction];
            break;
        case YellowColorRange:
            [self changeFromYellowRange:degree direction:direction];
            break;
        case GreenColorRange:
            [self changeFromGreenRange:degree direction:direction];
            break;
        case CyanColorRange:
            [self changeFromCyanRange:degree direction:direction];
            break;
        case BlueColorRange:
            [self changeFromBlueRange:degree direction:direction];
            break;
        case PurpleColorRange:
            [self changeFromPurpleRange:degree direction:direction];
            break;
        default:
            break;
    }
    
    return [UIColor colorWithRed:self.redValue/kMaxColorValue green:self.greenValue/kMaxColorValue blue:self.blueValue/kMaxColorValue alpha:1.0].CGColor;
}

#pragma mark - Private Methods
#pragma mark -

- (ColorRange)judgeColorRange
{
    //[FF0000,FFFF00]
    if(self.redValue == kMaxColorValue && (self.greenValue >= 0 && self.greenValue < kMaxColorValue) && self.blueValue == 0)
    {
        return RedColorRange;
    }
    //[FFFF00,00FF00)
    else if(self.greenValue == kMaxColorValue && (self.redValue>0 && self.redValue <= kMaxColorValue) && self.blueValue == 0)
    {
        return  YellowColorRange;
    }
    //[00FF00,00FFFF)
    else if(self.greenValue == kMaxColorValue && self.redValue == 0 && (self.blueValue >= 0 && self.blueValue < kMaxColorValue))
    {
        return  GreenColorRange;
    }
    //[00FFFF,0000FF]
    else if(self.blueValue == kMaxColorValue && self.redValue == 0 && (self.greenValue >0 && self.greenValue <= kMaxColorValue))
    {
        return CyanColorRange;
    }
    //[0000FF,FF00FF]
    else if(self.blueValue == kMaxColorValue && self.greenValue == 0 && (self.redValue >= 0 && self.redValue < kMaxColorValue))
    {
        return BlueColorRange;
    }
    //[FF00FF,FF0000]
    else if(self.redValue == kMaxColorValue && self.greenValue == 0 && (self.blueValue > 0 && self.blueValue <= kMaxColorValue))
    {
        return PurpleColorRange;
    }
    return ErrorColorRange;
}


- (void)changeFromRedRange:(CGFloat)value direction:(AnnulusRotateDirection)direction
{
    if(direction == AnnulusRotateClockwise) {
        if(self.greenValue - value <= 0) {
            self.blueValue = value - self.greenValue;
            self.greenValue = 0;
        } else {
            self.greenValue = self.greenValue - value;
        }
    } else {
        if (self.greenValue + value <= kMaxColorValue) {
            self.greenValue = self.greenValue + value;
        } else {
            self.redValue = kMaxColorValue - (self.greenValue + value - kMaxColorValue);
            self.greenValue = kMaxColorValue;
        }
    }
}

- (void)changeFromYellowRange:(CGFloat)value direction:(AnnulusRotateDirection)direction
{
    if(direction == AnnulusRotateClockwise) {
        if(self.redValue + value >= kMaxColorValue) {
            self.greenValue = kMaxColorValue - (self.redValue + value - kMaxColorValue);
            self.redValue = kMaxColorValue;
        } else {
            self.redValue = self.redValue + value;
        }
    } else {
        if(self.redValue - value >= 0) {
            self.redValue = self.redValue - value;
        } else {
            self.blueValue = value - self.redValue;
            self.redValue = 0;
        }
    }
}

- (void)changeFromGreenRange:(CGFloat)value direction:(AnnulusRotateDirection)direction
{
    if(direction == AnnulusRotateClockwise)  {
        if(self.blueValue - value <= 0) {
            self.redValue = value - self.blueValue;
            self.blueValue = 0;
        } else {
            self.blueValue = self.blueValue - value;
        }
    } else {
        if(self.blueValue + value <= kMaxColorValue) {
            self.blueValue = self.blueValue + value;
        } else {
            self.greenValue = kMaxColorValue - (self.blueValue + value - kMaxColorValue);
            self.blueValue = kMaxColorValue;
        }
    }
}


- (void)changeFromCyanRange:(CGFloat)value direction:(AnnulusRotateDirection)direction
{
    if(direction == AnnulusRotateClockwise) {
        if(self.greenValue + value >= kMaxColorValue)  {
            self.blueValue = kMaxColorValue - (self.greenValue + value - kMaxColorValue);
            self.greenValue = kMaxColorValue;
        } else {
            self.greenValue = self.greenValue + value;
        }
    } else {
        if(self.greenValue - value >= 0) {
            self.greenValue = self.greenValue - value;
        } else {
            self.redValue = value - self.greenValue;
            self.greenValue = 0;
        }
    }
}

- (void)changeFromBlueRange:(CGFloat)value direction:(AnnulusRotateDirection)direction
{
    if(direction == AnnulusRotateClockwise) {
        if(self.redValue - value <= 0)  {
            self.greenValue = value - self.redValue;
            self.redValue = 0;
        }  else {
            self.redValue = self.redValue - value;
        }
    } else {
        if(self.redValue + value <= kMaxColorValue) {
            self.redValue = self.redValue + value;
        } else {
            self.blueValue = kMaxColorValue - (self.redValue + value - kMaxColorValue);
            self.redValue = kMaxColorValue;
        }
    }
}

- (void)changeFromPurpleRange:(CGFloat)value direction:(AnnulusRotateDirection)direction
{
    if(direction == AnnulusRotateClockwise) {
        if(self.blueValue + value >= kMaxColorValue) {
            self.redValue = kMaxColorValue - (self.blueValue + value - kMaxColorValue);
            self.blueValue = kMaxColorValue;
        }  else {
            self.blueValue = self.blueValue + value;
        }
    } else {
        if(self.blueValue - value >= 0) {
            self.blueValue = self.blueValue - value;
        } else {
            self.greenValue = value - self.blueValue;
            self.blueValue = 0;
        }
    }
}

@end
