//
//  TYGradientGroup.m
//  TYColorDisk
//
//  Created by Demon_Yao on 8/1/15.
//  Copyright (c) 2015 Tyrone Zhang. All rights reserved.
//

#import "TYGradientGroup.h"

#define DEGREE_TO_ANGLE(X) (M_PI * (X)/180.0)

@interface TYGradientGroup ()

@property (nonatomic, assign) CGPoint  centerPoint;
@property (nonatomic, assign) CGFloat  radius;
@property (nonatomic, strong) NSMutableArray *gradientArray;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGRect colorViewFrame;

@end


@implementation TYGradientGroup

#pragma mark - Initialize Method
#pragma mark -

- (NSArray *)createGradientLayersWithFrame:(CGRect)aFrame centerPoint:(CGPoint)aCenterPoint radius:(CGFloat)aRadius lineWidth:(CGFloat)lineWidth
{
    self.centerPoint = aCenterPoint;
    self.radius = aRadius;
    self.lineWidth = lineWidth;
    self.colorViewFrame = aFrame;
    self.gradientArray = [NSMutableArray array];
    [self configureGradientArray];
    
    return self.gradientArray;
}

#pragma mark - Private Methods
#pragma mark -

- (void)configureGradientArray
{
    [self leftDownColor1];
    [self leftDownColor2];
    [self leftDownColor3];
    [self leftDownColor4];
    [self leftDownColor5];
    [self leftTopColor1];
    [self leftTopColor2];
    [self leftTopColor3];
    [self leftTopColor4];
    [self leftTopColor5];
    [self rightTopColor1];
    [self rightTopColor2];
    [self rightTopColor3];
    [self rightTopColor4];
    [self rightTopColor5];
    [self rightDownColor1];
    [self rightDownColor2];
    [self rightDownColor3];
    [self  rightDownColor4];
    [self rightDownColor5];
}

- (CAShapeLayer *)annulusShapeWithStartDgree:(int)startDgree endDgree:(int)endDgree
{
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.centerPoint
                                           radius:self.radius
                                       startAngle:DEGREE_TO_ANGLE(startDgree)
                                         endAngle:DEGREE_TO_ANGLE(endDgree)
                                        clockwise:YES];
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.fillColor = [[UIColor clearColor] CGColor];
    shape.strokeColor = [[UIColor grayColor] CGColor];
    shape.lineWidth = self.lineWidth;
    shape.lineCap = kCALineCapButt;
    shape.path = [path CGPath];
    shape.strokeEnd = 1;
    
    return shape;
}


#pragma mark - Bottom-left,range of degree is [120°, 140°]
#pragma mark - 

- (void)leftDownColor1
{
    CAShapeLayer *shape = [self annulusShapeWithStartDgree:120 endDgree:130];
    
    NSArray *startColorNumberArray = @[@255, @0, @0];
    NSArray *endColorNumberArray = @[@255, @128, @0];
    NSArray *colors = @[startColorNumberArray, endColorNumberArray];
    
    NSArray *locations = @[@0.44, @0.46];
    
    NSValue *startPointValue = [NSValue valueWithCGPoint:CGPointMake(1, 0.8)];
    NSValue *endPointValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    NSArray *drawPoints = @[startPointValue, endPointValue];
    
    TYGradientLayer *gradientLayer = [[TYGradientLayer alloc] initGradientLayerWithFrame:self.colorViewFrame
                                                                                   shape:shape
                                                                                  colors:colors
                                                                               locations:locations
                                                                              drawPoints:drawPoints];
    [self.gradientArray addObject:gradientLayer];
}
- (void)leftDownColor2
{
    
    CAShapeLayer *shape = [self annulusShapeWithStartDgree:130 endDgree:140];
    
    NSArray *startColorNumberArray = @[@255, @128, @0];
    NSArray *endColorNumberArray = @[@255, @255, @0];
    NSArray *colors = @[startColorNumberArray, endColorNumberArray];
    
    NSArray *locations = @[@0.465, @0.485];
    
    NSValue *startPointValue = [NSValue valueWithCGPoint:CGPointMake(0.9, 1)];
    NSValue *endPointValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    NSArray *drawPoints = @[startPointValue, endPointValue];
    
    TYGradientLayer *gradientLayer = [[TYGradientLayer alloc] initGradientLayerWithFrame:self.colorViewFrame
                                                                                   shape:shape
                                                                                  colors:colors
                                                                               locations:locations
                                                                              drawPoints:drawPoints];
    [self.gradientArray addObject:gradientLayer];
    
}
- (void)leftDownColor3
{
    CAShapeLayer *shape = [self annulusShapeWithStartDgree:140 endDgree:150];
    
    NSArray *startColorNumberArray = @[@255, @255, @0];
    NSArray *endColorNumberArray = @[@170, @255, @0];
    NSArray *colors = @[startColorNumberArray, endColorNumberArray];
    
    NSArray *locations = @[@0.40, @0.44];
    
    NSValue *startPointValue = [NSValue valueWithCGPoint:CGPointMake(0.65, 1)];
    NSValue *endPointValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    NSArray *drawPoints = @[startPointValue, endPointValue];
    
    TYGradientLayer *gradientLayer = [[TYGradientLayer alloc] initGradientLayerWithFrame:self.colorViewFrame
                                                                                   shape:shape
                                                                                  colors:colors
                                                                               locations:locations
                                                                              drawPoints:drawPoints];
    [self.gradientArray addObject:gradientLayer];
}
- (void)leftDownColor4
{
    CAShapeLayer *shape = [self annulusShapeWithStartDgree:150 endDgree:160];
    
    NSArray *startColorNumberArray = @[@170, @255, @0];
    NSArray *endColorNumberArray = @[@85, @255, @0];
    NSArray *colors = @[startColorNumberArray, endColorNumberArray];
    
    NSArray *locations = @[@0.38, @0.40];
    
    NSValue *startPointValue = [NSValue valueWithCGPoint:CGPointMake(0.45, 1)];
    NSValue *endPointValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    NSArray *drawPoints = @[startPointValue, endPointValue];
    
    TYGradientLayer *gradientLayer = [[TYGradientLayer alloc] initGradientLayerWithFrame:self.colorViewFrame
                                                                                   shape:shape
                                                                                  colors:colors
                                                                               locations:locations
                                                                              drawPoints:drawPoints];
    [self.gradientArray addObject:gradientLayer];
}
- (void)leftDownColor5
{
    CAShapeLayer *shape = [self annulusShapeWithStartDgree:160 endDgree:170];
    
    NSArray *startColorNumberArray = @[@85, @255, @0];
    NSArray *endColorNumberArray = @[@0, @255, @0];
    NSArray *colors = @[startColorNumberArray, endColorNumberArray];
    
    NSArray *locations = @[@0.39, @0.42];
    
    NSValue *startPointValue = [NSValue valueWithCGPoint:CGPointMake(0.3, 1)];
    NSValue *endPointValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    NSArray *drawPoints = @[startPointValue, endPointValue];
    
    TYGradientLayer *gradientLayer = [[TYGradientLayer alloc] initGradientLayerWithFrame:self.colorViewFrame
                                                                                   shape:shape
                                                                                  colors:colors
                                                                               locations:locations
                                                                              drawPoints:drawPoints];
    [self.gradientArray addObject:gradientLayer];
}


#pragma mark - Top-left,range of degree is [170°, 270°]
#pragma mark -

- (void)leftTopColor1
{
    CAShapeLayer *shape = [self annulusShapeWithStartDgree:170 endDgree:190];
    
    NSArray *startColorNumberArray = @[@0, @255, @0];
    NSArray *endColorNumberArray = @[@0, @255, @25.5];
    NSArray *colors = @[startColorNumberArray, endColorNumberArray];
    
    NSArray *locations = @[@0.46, @0.55];
    
    NSValue *startPointValue = [NSValue valueWithCGPoint:CGPointMake(0, 1)];
    NSValue *endPointValue = [NSValue valueWithCGPoint:CGPointMake(0.1, 0)];
    NSArray *drawPoints = @[startPointValue, endPointValue];
    
    TYGradientLayer *gradientLayer = [[TYGradientLayer alloc] initGradientLayerWithFrame:self.colorViewFrame
                                                                                   shape:shape
                                                                                  colors:colors
                                                                               locations:locations
                                                                              drawPoints:drawPoints];
    [self.gradientArray addObject:gradientLayer];
}
- (void)leftTopColor2
{
    CAShapeLayer *shape = [self annulusShapeWithStartDgree:190 endDgree:210];
    
    NSArray *startColorNumberArray = @[@0, @255, @25.5];
    NSArray *endColorNumberArray = @[@0, @255, @51];
    NSArray *colors = @[startColorNumberArray, endColorNumberArray];
    
    NSArray *locations = @[@0.5, @0.65];
    
    NSValue *startPointValue = [NSValue valueWithCGPoint:CGPointMake(0, 1)];
    NSValue *endPointValue = [NSValue valueWithCGPoint:CGPointMake(0.2, 0)];
    NSArray *drawPoints = @[startPointValue, endPointValue];
    
    TYGradientLayer *gradientLayer = [[TYGradientLayer alloc] initGradientLayerWithFrame:self.colorViewFrame
                                                                                   shape:shape
                                                                                  colors:colors
                                                                               locations:locations
                                                                              drawPoints:drawPoints];
    [self.gradientArray addObject:gradientLayer];
}

- (void)leftTopColor3
{
    CAShapeLayer *shape = [self annulusShapeWithStartDgree:210 endDgree:230];
    
    NSArray *startColorNumberArray = @[@0, @255, @76.5];
    NSArray *endColorNumberArray = @[@0, @255, @102];
    NSArray *colors = @[startColorNumberArray, endColorNumberArray];
    
    NSArray *locations = @[@0.6, @0.7];
    
    NSValue *startPointValue = [NSValue valueWithCGPoint:CGPointMake(0, 1)];
    NSValue *endPointValue = [NSValue valueWithCGPoint:CGPointMake(0.45, 0)];
    NSArray *drawPoints = @[startPointValue, endPointValue];
    
    TYGradientLayer *gradientLayer = [[TYGradientLayer alloc] initGradientLayerWithFrame:self.colorViewFrame
                                                                                   shape:shape
                                                                                  colors:colors
                                                                               locations:locations
                                                                              drawPoints:drawPoints];
    [self.gradientArray addObject:gradientLayer];
}

- (void)leftTopColor4
{
    CAShapeLayer *shape = [self annulusShapeWithStartDgree:230 endDgree:250];
    
    NSArray *startColorNumberArray = @[@0, @255, @102];
    NSArray *endColorNumberArray = @[@0, @255, @127.5];
    NSArray *colors = @[startColorNumberArray, endColorNumberArray];
    
    NSArray *locations = @[@0.4, @0.6];
    
    NSValue *startPointValue = [NSValue valueWithCGPoint:CGPointMake(0, 0.5)];
    NSValue *endPointValue = [NSValue valueWithCGPoint:CGPointMake(0.7, 0)];
    NSArray *drawPoints = @[startPointValue, endPointValue];
    
    TYGradientLayer *gradientLayer = [[TYGradientLayer alloc] initGradientLayerWithFrame:self.colorViewFrame
                                                                                   shape:shape
                                                                                  colors:colors
                                                                               locations:locations
                                                                              drawPoints:drawPoints];
    [self.gradientArray addObject:gradientLayer];
}

- (void)leftTopColor5
{
    CAShapeLayer *shape = [self annulusShapeWithStartDgree:250 endDgree:270];
    
    NSArray *startColorNumberArray = @[@0, @255, @127.5];
    NSArray *endColorNumberArray = @[@0, @255, @153];
    NSArray *colors = @[startColorNumberArray, endColorNumberArray];
    
    NSArray *locations = @[@0.35, @0.45];
    
    NSValue *startPointValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    NSValue *endPointValue = [NSValue valueWithCGPoint:CGPointMake(1, 0)];
    NSArray *drawPoints = @[startPointValue, endPointValue];
    
    TYGradientLayer *gradientLayer = [[TYGradientLayer alloc] initGradientLayerWithFrame:self.colorViewFrame
                                                                                   shape:shape
                                                                                  colors:colors
                                                                               locations:locations
                                                                              drawPoints:drawPoints];
    [self.gradientArray addObject:gradientLayer];
}


#pragma mark - Bottom-right,range of degree is [370°, 420°]
#pragma mark -

- (void)rightDownColor1
{
    CAShapeLayer *shape = [self annulusShapeWithStartDgree:370 endDgree:380];
    
    NSArray *startColorNumberArray = @[@0, @170, @255];
    NSArray *endColorNumberArray = @[@0, @85, @255];
    NSArray *colors = @[startColorNumberArray, endColorNumberArray];
    
    NSArray *locations = @[@0.59, @0.61];
    
    NSValue *startPointValue = [NSValue valueWithCGPoint:CGPointMake(1, 0)];
    NSValue *endPointValue = [NSValue valueWithCGPoint:CGPointMake(0.7, 1)];
    NSArray *drawPoints = @[startPointValue, endPointValue];
    
    TYGradientLayer *gradientLayer = [[TYGradientLayer alloc] initGradientLayerWithFrame:self.colorViewFrame
                                                                                   shape:shape
                                                                                  colors:colors
                                                                               locations:locations
                                                                              drawPoints:drawPoints];
    [self.gradientArray addObject:gradientLayer];
}
- (void)rightDownColor2
{
    CAShapeLayer *shape = [self annulusShapeWithStartDgree:380 endDgree:390];
    
    NSArray *startColorNumberArray = @[@0, @85, @255];
    NSArray *endColorNumberArray = @[@0, @0, @255];
    NSArray *colors = @[startColorNumberArray, endColorNumberArray];
    
    NSArray *locations = @[@0.6, @0.62];
    
    NSValue *startPointValue = [NSValue valueWithCGPoint:CGPointMake(1, 0)];
    NSValue *endPointValue = [NSValue valueWithCGPoint:CGPointMake(0.5, 1)];
    NSArray *drawPoints = @[startPointValue, endPointValue];
    
    TYGradientLayer *gradientLayer = [[TYGradientLayer alloc] initGradientLayerWithFrame:self.colorViewFrame
                                                                                   shape:shape
                                                                                  colors:colors
                                                                               locations:locations
                                                                              drawPoints:drawPoints];
    [self.gradientArray addObject:gradientLayer];
}
- (void)rightDownColor3
{
    CAShapeLayer *shape = [self annulusShapeWithStartDgree:390 endDgree:400];
    
    NSArray *startColorNumberArray = @[@0, @0, @255];
    NSArray *endColorNumberArray = @[@128, @0, @255];
    NSArray *colors = @[startColorNumberArray, endColorNumberArray];
    
    NSArray *locations = @[@0.545, @0.565];
    
    NSValue *startPointValue = [NSValue valueWithCGPoint:CGPointMake(1, 0.25)];
    NSValue *endPointValue = [NSValue valueWithCGPoint:CGPointMake(0.45, 1)];
    NSArray *drawPoints = @[startPointValue, endPointValue];
    
    TYGradientLayer *gradientLayer = [[TYGradientLayer alloc] initGradientLayerWithFrame:self.colorViewFrame
                                                                                   shape:shape
                                                                                  colors:colors
                                                                               locations:locations
                                                                              drawPoints:drawPoints];
    [self.gradientArray addObject:gradientLayer];
}
- (void)rightDownColor4
{
    CAShapeLayer *shape = [self annulusShapeWithStartDgree:400 endDgree:410];
    
    NSArray *startColorNumberArray = @[@128, @0, @255];
    NSArray *endColorNumberArray = @[@255, @0, @255];
    NSArray *colors = @[startColorNumberArray, endColorNumberArray];
    
    NSArray *locations = @[@0.48,@0.5];
    
    NSValue *startPointValue = [NSValue valueWithCGPoint:CGPointMake(1, 0.5)];
    NSValue *endPointValue = [NSValue valueWithCGPoint:CGPointMake(0.4, 1)];
    NSArray *drawPoints = @[startPointValue, endPointValue];
    
    TYGradientLayer *gradientLayer = [[TYGradientLayer alloc] initGradientLayerWithFrame:self.colorViewFrame
                                                                                   shape:shape
                                                                                  colors:colors
                                                                               locations:locations
                                                                              drawPoints:drawPoints];
    [self.gradientArray addObject:gradientLayer];
}
- (void)rightDownColor5
{
    CAShapeLayer *shape = [self annulusShapeWithStartDgree:410 endDgree:420];
    
    NSArray *startColorNumberArray = @[@255, @0, @255];
    NSArray *endColorNumberArray = @[@255, @0, @0];
    NSArray *colors = @[startColorNumberArray, endColorNumberArray];
    
    NSArray *locations = @[@0.44,@0.46];
    
    NSValue *startPointValue = [NSValue valueWithCGPoint:CGPointMake(1, 0.5)];
    NSValue *endPointValue = [NSValue valueWithCGPoint:CGPointMake(0.2, 1)];
    NSArray *drawPoints = @[startPointValue, endPointValue];
    
    TYGradientLayer *gradientLayer = [[TYGradientLayer alloc] initGradientLayerWithFrame:self.colorViewFrame
                                                                                   shape:shape
                                                                                  colors:colors
                                                                               locations:locations
                                                                              drawPoints:drawPoints];
    [self.gradientArray addObject:gradientLayer];
}

#pragma mark - Top-right,range of degree is [270°, 370°]
#pragma mark -

- (void)rightTopColor1
{
    CAShapeLayer *shape = [self annulusShapeWithStartDgree:270 endDgree:290];
    
    NSArray *startColorNumberArray = @[@0, @255, @153];
    NSArray *endColorNumberArray = @[@0, @255, @178.5];
    NSArray *colors = @[startColorNumberArray, endColorNumberArray];
    
    NSArray *locations = @[@0.55,@0.65];
    
    NSValue *startPointValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    NSValue *endPointValue = [NSValue valueWithCGPoint:CGPointMake(1, 0.2)];
    NSArray *drawPoints = @[startPointValue, endPointValue];
    
    TYGradientLayer *gradientLayer = [[TYGradientLayer alloc] initGradientLayerWithFrame:self.colorViewFrame
                                                                                   shape:shape
                                                                                  colors:colors
                                                                               locations:locations
                                                                              drawPoints:drawPoints];
    [self.gradientArray addObject:gradientLayer];
}
- (void)rightTopColor2
{
    CAShapeLayer *shape = [self annulusShapeWithStartDgree:290 endDgree:310];
    
    NSArray *startColorNumberArray = @[@0, @255, @178];
    NSArray *endColorNumberArray = @[@0, @255, @204];
    NSArray *colors = @[startColorNumberArray, endColorNumberArray];
    
    NSArray *locations = @[@0.55,@0.65];
    
    NSValue *startPointValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    NSValue *endPointValue = [NSValue valueWithCGPoint:CGPointMake(1, 0.6)];
    NSArray *drawPoints = @[startPointValue, endPointValue];
    
    TYGradientLayer *gradientLayer = [[TYGradientLayer alloc] initGradientLayerWithFrame:self.colorViewFrame
                                                                                   shape:shape
                                                                                  colors:colors
                                                                               locations:locations
                                                                              drawPoints:drawPoints];
    [self.gradientArray addObject:gradientLayer];
}
- (void)rightTopColor3
{
    CAShapeLayer *shape = [self annulusShapeWithStartDgree:310 endDgree:330];
    
    NSArray *startColorNumberArray = @[@0, @255, @204];
    NSArray *endColorNumberArray = @[@0, @255, @229.5];
    NSArray *colors = @[startColorNumberArray, endColorNumberArray];
    
    NSArray *locations = @[@0.4,@0.5];
    
    NSValue *startPointValue = [NSValue valueWithCGPoint:CGPointMake(0.2, 0)];
    NSValue *endPointValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    NSArray *drawPoints = @[startPointValue, endPointValue];
    
    TYGradientLayer *gradientLayer = [[TYGradientLayer alloc] initGradientLayerWithFrame:self.colorViewFrame
                                                                                   shape:shape
                                                                                  colors:colors
                                                                               locations:locations
                                                                              drawPoints:drawPoints];
    [self.gradientArray addObject:gradientLayer];
}
- (void)rightTopColor4
{
    CAShapeLayer *shape = [self annulusShapeWithStartDgree:330 endDgree:350];
    
    NSArray *startColorNumberArray = @[@0, @255, @229.5];
    NSArray *endColorNumberArray = @[@0, @255, @255];
    NSArray *colors = @[startColorNumberArray, endColorNumberArray];
    
    NSArray *locations = @[@0.58,@0.68];
    
    NSValue *startPointValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    NSValue *endPointValue = [NSValue valueWithCGPoint:CGPointMake(0.35, 1)];
    NSArray *drawPoints = @[startPointValue, endPointValue];
    
    TYGradientLayer *gradientLayer = [[TYGradientLayer alloc] initGradientLayerWithFrame:self.colorViewFrame
                                                                                   shape:shape
                                                                                  colors:colors
                                                                               locations:locations
                                                                              drawPoints:drawPoints];
    
    [self.gradientArray addObject:gradientLayer];
}
- (void)rightTopColor5
{
    CAShapeLayer *shape = [self annulusShapeWithStartDgree:350 endDgree:370];
    
    NSArray *startColorNumberArray = @[@0, @255, @255];
    NSArray *endColorNumberArray = @[@0, @170, @255];
    NSArray *colors = @[startColorNumberArray, endColorNumberArray];
    
    NSArray *locations = @[@0.49,@0.59];
    
    NSValue *startPointValue = [NSValue valueWithCGPoint:CGPointMake(1, 0)];
    NSValue *endPointValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    NSArray *drawPoints = @[startPointValue, endPointValue];
    
    TYGradientLayer *gradientLayer = [[TYGradientLayer alloc] initGradientLayerWithFrame:self.colorViewFrame
                                                                                   shape:shape
                                                                                  colors:colors
                                                                               locations:locations
                                                                              drawPoints:drawPoints];
    [self.gradientArray addObject:gradientLayer];
}

#pragma mark - Public Methods
#pragma mark -

- (void)changeValueWithDegreeValue:(CGFloat)value direction:(AnnulusRotateDirection)direction animatable:(BOOL)animatable Block:(void (^)(CGFloat, CGFloat, CGFloat))completed
{
    for (TYGradientLayer *gradientLayer in self.gradientArray) {
        [gradientLayer changeColorWithDegreeValue:value direction:direction animatable:animatable];
    }
    
    TYGradientLayer *selectedGradientLayer = self.gradientArray[10];
    
    completed(selectedGradientLayer.colorSpace.startColorValue.redValue,
              selectedGradientLayer.colorSpace.startColorValue.greenValue,
              selectedGradientLayer.colorSpace.startColorValue.blueValue);
}

@end
