//
//  TYColorValue.h
//  TYColorDisk
//
//  Created by Demon_Yao on 7/30/15.
//  Copyright (c) 2015 Tyrone Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AnnulusRotateDirection) {
    AnnulusRotateClockwise,
    AnnulusRotateAnticlockwise,
};

extern const float kMaxColorValue;

@interface TYColorValue : NSObject

@property (nonatomic, assign) float redValue;
@property (nonatomic, assign) float greenValue;
@property (nonatomic, assign) float blueValue;

/**
 *  Initialize the object with RGB,and the range of them is  0 to 255.
 */
- initWithRedValue:(float)red greenValue:(float)green blueValue:(float)blue;

/**
 *  To reset the color to the value that was initialized.
 */
- (void)resetColorValue;

/**
 *  Change current RGB value, to add or decrease.
 *
 *  @param degree    The value should be changed.
 *  @param direction Clockwise or anticlockwise.
 *
 *  @return New color.
 */
- (CGColorRef)changeColorWithDegreeValue:(CGFloat)degree direction:(AnnulusRotateDirection)direction;

@end
