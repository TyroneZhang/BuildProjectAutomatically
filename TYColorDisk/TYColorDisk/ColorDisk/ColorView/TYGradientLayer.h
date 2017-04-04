//
//  TYGradientLayer.h
//  TYColorDisk
//
//  Created by Demon_Yao on 7/30/15.
//  Copyright (c) 2015 Tyrone Zhang. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "TYColorSpace.h"

@interface TYGradientLayer : CAGradientLayer

@property (nonatomic, strong) TYColorSpace *colorSpace;

- (instancetype)initGradientLayerWithFrame:(CGRect)aFrame
                                    shape:(CAShapeLayer *)aShape
                                     colors:(NSArray *)aColors
                                  locations:(NSArray *)aLocations
                                 drawPoints:(NSArray *)aPoints;

- (void)changeColorWithDegreeValue:(CGFloat)value direction:(AnnulusRotateDirection)direction animatable:(BOOL)animatable;


@end
