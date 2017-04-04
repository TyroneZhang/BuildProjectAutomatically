//
//  TYAnnulusColorView.m
//  TYColorDisk
//
//  Created by Demon_Yao on 7/30/15.
//  Copyright (c) 2015 Tyrone Zhang. All rights reserved.
//

#import "TYAnnulusColorView.h"
#import "TYGradientLayer.h"
#import "TYGradientGroup.h"
#import "BrightnessOperationView.h"

#define DEGREE_TO_ANGLE(X) (M_PI * (X)/180.0)

static const int kAnnulusStartDgree = 120;
static const int kAnnulusEndDgree = 420;
static const int kDefaultAnnulusWidth = 60;
static const CGFloat kValuePerDegree = 2.55;
static const int kBackShapeAddRadius = 4;
extern const float kMaxColorValue;
extern const NSInteger kMaxOfBrightnessNumber;
static const CGFloat kNormalBrightnessNumber = 60.0;


@interface TYAnnulusColorView () <BrightnessOperationViewDelegate>
{
    CGPoint _lastPoint;
    CGPoint _endPoint;
    CGPoint _centerPoint;
}

@property (nonatomic, strong) NSMutableArray *gradientLayerArray;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, assign) int annulusWidth;
@property (nonatomic, strong) TYGradientGroup *gradientGroup;
@property (nonatomic, strong) CAShapeLayer *annulusShapeLayer;
@property (nonatomic, assign) BOOL  hasLoadedAwakeNib;
@property (nonatomic, strong) CAShapeLayer *brightnessLayer;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIButton *switchButton;

@end

@implementation TYAnnulusColorView

#pragma mark - initialize method
#pragma mark -

- (void)awakeFromNib
{
    [super awakeFromNib];
    if (!self.hasLoadedAwakeNib) {
        self.hasLoadedAwakeNib = YES;
        
        _centerPoint = CGPointMake(CGRectGetWidth(self.frame)/2.0, CGRectGetHeight(self.frame)/2.0);
        self.backgroundColor = [UIColor clearColor];
        self.gradientLayerArray = [NSMutableArray arrayWithCapacity:1];
        self.strokeColor = [UIColor grayColor];
        
        [self initializeBasicLayer];
        [self initializeBrightnessLayer];
        
        [self performSelector:@selector(startWithAnimation:) withObject:[NSNumber numberWithBool:YES] afterDelay:0.0];
        [self bringSubviewToFront:self.imageView];
        self.imageView.alpha = 0.;
        [UIView animateWithDuration:0.8 animations:^{
            self.imageView.alpha = 1;
        }];
        
        [self initializeBrightnessOperationView];
        
        [self initializeSwitchButton];
    }
}

- (void)initializeBasicLayer
{
    UIBezierPath *path = [self annulusWithStartDgree:kAnnulusStartDgree endDgree:kAnnulusEndDgree];
    CAShapeLayer *trackLayer = [CAShapeLayer layer];
    trackLayer.frame = self.bounds;
    trackLayer.fillColor = [UIColor clearColor].CGColor;
    trackLayer.strokeColor = [UIColor blackColor].CGColor;
    trackLayer.lineCap = kCALineCapButt;
    trackLayer.opacity = 0.25;
    trackLayer.lineWidth = self.annulusWidth;
    trackLayer.path = [path CGPath];
    trackLayer.strokeEnd = 1;
    [self.layer addSublayer:trackLayer];
    
    [self initializeGradientLayersWithPath:trackLayer.path];
}

- (void)initializeGradientLayersWithPath:(CGPathRef)path
{
    self.annulusShapeLayer = [CAShapeLayer layer];
    self.annulusShapeLayer.frame = self.bounds;
    self.annulusShapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.annulusShapeLayer.strokeColor = [self.strokeColor CGColor];
    self.annulusShapeLayer.lineCap = kCALineCapButt;
    self.annulusShapeLayer.lineWidth = self.annulusWidth;
    self.annulusShapeLayer.path = path;
    self.annulusShapeLayer.strokeEnd = 0.;
    CALayer *annulusGradientLayer = [CALayer layer];
    
    self.gradientGroup = [[TYGradientGroup alloc] init];
    [self.gradientGroup createGradientLayersWithFrame:self.bounds
                                          centerPoint:_centerPoint
                                               radius:[self calculateRadius]
                                            lineWidth:self.annulusWidth];
    for (TYGradientLayer *gradientLayer in self.gradientGroup.gradientArray) {
        [annulusGradientLayer addSublayer:gradientLayer];
    }
    
    [annulusGradientLayer setMask:self.annulusShapeLayer];
    [self.layer addSublayer:annulusGradientLayer];
}

- (void)initializeBrightnessLayer
{
    UIBezierPath *path = [self annulusWithStartDgree:kAnnulusStartDgree endDgree:kAnnulusEndDgree];
    self.brightnessLayer = [CAShapeLayer layer];
    self.brightnessLayer.frame = self.bounds;
    self.brightnessLayer.fillColor = [[UIColor clearColor] CGColor];
    self.brightnessLayer.strokeColor = [[UIColor blackColor] CGColor];
    self.brightnessLayer.opacity = 0.0;
    self.brightnessLayer.lineCap = kCALineCapButt;
    self.brightnessLayer.lineWidth = self.annulusWidth;
    self.brightnessLayer.path = [path CGPath];
    
    [self.layer addSublayer:self.brightnessLayer];
}

- (void)initializeBrightnessOperationView
{
    CGFloat width = CGRectGetWidth(self.frame) - 2 * self.annulusWidth - 40;
    BrightnessOperationView *brightnessOperationView = [[[NSBundle mainBundle] loadNibNamed:@"BrightnessOperation" owner:nil options:nil] firstObject];
    brightnessOperationView.frame = CGRectMake(0, 0, width, width);
    brightnessOperationView.center = _centerPoint;
    brightnessOperationView.delegate = self;
    [self addSubview:brightnessOperationView];
}

- (void)initializeSwitchButton
{
    CGFloat R = CGRectGetWidth(self.frame) / 2.0 - kBackShapeAddRadius;
    CGFloat r = R - self.annulusWidth;
    
    CGFloat tempHeight = (sqrtf(3)/2.0 * r);
    CGFloat height = R - tempHeight - kBackShapeAddRadius;
    CGFloat width = R;
    
    self.switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.switchButton.frame = CGRectMake(0, 0, width, height);
    self.switchButton.center = CGPointMake(_centerPoint.x, _centerPoint.y + tempHeight + height/2.0);
    [self.switchButton setImage:[UIImage imageNamed:@"cdOff.png"] forState:UIControlStateSelected];
    [self.switchButton setImage:[UIImage imageNamed:@"cdOn.png"] forState:UIControlStateNormal];
    [self.switchButton addTarget:self action:@selector(switchButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.switchButton];
}

#pragma mark - Private Method
#pragma mark -

- (CGFloat)calculateRadius
{
    CGFloat minRadius = MIN(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) / 2.0 - kBackShapeAddRadius;
    self.annulusWidth = kDefaultAnnulusWidth >= minRadius ? minRadius : kDefaultAnnulusWidth;
    return minRadius - self.annulusWidth/2.0;
}

- (UIBezierPath *)annulusWithStartDgree:(int)startDgree endDgree:(int)endDgree
{
    return  [UIBezierPath bezierPathWithArcCenter:_centerPoint
                                           radius:[self calculateRadius]
                                       startAngle:DEGREE_TO_ANGLE(startDgree)
                                         endAngle:DEGREE_TO_ANGLE(endDgree)
                                        clockwise:YES];
}

- (void)startWithAnimation:(NSNumber *)animated
{
    [CATransaction begin];
    [CATransaction setDisableActions:![animated boolValue]];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:0.5];
    self.annulusShapeLayer.strokeEnd = 1;
    [CATransaction commit];
}

/**
 *  Judge the quadrant firstly,then judge the direction by _lastPoint and _endPoint.
 *
 *  @return the direction that value should change to.
 */
- (AnnulusRotateDirection)toJudgeDirection
{
    if (_endPoint.x >= _centerPoint.x && _endPoint.y <= _centerPoint.y) { // first quadrant
        if (_lastPoint.x < _endPoint.x || _lastPoint.y < _endPoint.y) {
            return AnnulusRotateClockwise;
        } else {
            return AnnulusRotateAnticlockwise;
        }
    } else if (_endPoint.x < _centerPoint.x && _endPoint.y <= _centerPoint.y) { // second quadrant
        if (_lastPoint.x < _endPoint.x || _lastPoint.y > _endPoint.y) {
            return AnnulusRotateClockwise;
        } else {
            return AnnulusRotateAnticlockwise;
        }
    } else if(_endPoint.x < _centerPoint.x && _endPoint.y > _centerPoint.y) { // third quadrant
        if(_lastPoint.x > _endPoint.x || _lastPoint.y > _endPoint.y) {
            return AnnulusRotateClockwise;
        } else {
            return AnnulusRotateAnticlockwise;
        }
    }  else if(_endPoint.x > _centerPoint.x && _endPoint.y > _centerPoint.y) { // forth quadrant
        if(_lastPoint.x > _endPoint.x || _lastPoint.y < _endPoint.y) {
            return AnnulusRotateClockwise;
        } else {
            return AnnulusRotateAnticlockwise;
        }
    }
    return AnnulusRotateClockwise;
}

/**
 *  calculate the dgree by trigonometric function.
 *
 *  @return the dgree should changed.
 */
- (CGFloat)calculateDegree
{
    //  a: lenth between lastPoint and centerPoint
    double x = _lastPoint.x - _centerPoint.x;
    double y = _lastPoint.y - _centerPoint.y;
    double a = sqrtf(pow(x, 2) + pow(y, 2));
    
    //  b
    x = _endPoint.x - _centerPoint.x;
    y = _endPoint.y - _centerPoint.y;
    double b = sqrtf(pow(x, 2) + pow(y, 2));
    
    //  c
    x = _lastPoint.x - _endPoint.x;
    y = _lastPoint.y - _endPoint.y;
    double c = sqrtf(pow(x, 2) + pow(y, 2));
    
    //  angle between a and b.
    double temp = 2.0 * a * b;
    if(temp < 0)
    {
        temp = - temp;
    }
    double cosC = (pow(a, 2) + pow(b, 2) - pow(c, 2)) / temp;
    //  cosc
    double angle = acos(cosC);
    //  degree
    double degree = angle * 180.0/3.14;
    return degree;
}

- (void)changeBrightnessLayerWithBrightnessNumber:(NSInteger)brightnessNumber
{
    if (brightnessNumber == kNormalBrightnessNumber) {
        self.brightnessLayer.strokeColor = [[UIColor blackColor] CGColor];
        self.brightnessLayer.opacity = 0.0;
    } else if (brightnessNumber < kNormalBrightnessNumber) {
        self.brightnessLayer.strokeColor = [[UIColor blackColor] CGColor];
        float value = 1 - brightnessNumber / (CGFloat)kNormalBrightnessNumber;
        if (value > 0.8) {
            value = 0.8;
        } self.brightnessLayer.opacity = value;
    } else if (brightnessNumber > kNormalBrightnessNumber) {
        self.brightnessLayer.strokeColor = [[UIColor whiteColor] CGColor];
        float value = 1 - (kMaxOfBrightnessNumber -  brightnessNumber) / (kMaxOfBrightnessNumber - kNormalBrightnessNumber);
        if (value > 0.5) {
            value = 0.5;
        }
        self.brightnessLayer.opacity = value;
    }
}

- (void)switchButtonClicked:(UIButton *)button
{
    button.selected = !button.selected;
}

#pragma mark - Gesture recognizer
#pragma mark - 

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _lastPoint = [[touches anyObject] locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    _endPoint = [[touches anyObject] locationInView:self];
    AnnulusRotateDirection direction = [self toJudgeDirection];
    CGFloat degree = [self calculateDegree];
    if (degree > 0 && degree <= 100) {
        float value = kValuePerDegree * degree;
        _lastPoint = _endPoint;
        
        __weak typeof(self) weakSelf = self;
        [self.gradientGroup changeValueWithDegreeValue:value direction:direction animatable:NO Block:^(CGFloat red, CGFloat green, CGFloat blue) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(colorChangedWithNewColor:)]) {
                [weakSelf.delegate colorChangedWithNewColor:[UIColor colorWithRed:red/kMaxColorValue green:green/kMaxColorValue blue:blue/kMaxColorValue alpha:1.0]];
            }
            
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(colorChangedWithRed:green:blue:)]) {
                [weakSelf.delegate colorChangedWithRed:red green:green blue:blue];
            }
        }];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (CGPointEqualToPoint(_endPoint, CGPointZero)) { // auto rotate
        _endPoint = _lastPoint;
        _lastPoint = CGPointMake(_centerPoint.x, 0);
        CGFloat value = [self calculateDegree] * 2.55;
        AnnulusRotateDirection direction = AnnulusRotateAnticlockwise;
        if (_endPoint.x < _centerPoint.x) {
            direction = AnnulusRotateClockwise;
        }
        
        __weak typeof(self) weakSelf = self;
        for (NSInteger i = 0; i <= ((int)value / kMaxColorValue); i++) {
            CGFloat perValue = kMaxColorValue * (i+1) < value ? kMaxColorValue : (int)value % (int)kMaxColorValue ;
            [self.gradientGroup changeValueWithDegreeValue:perValue direction:direction animatable:YES Block:^(CGFloat red, CGFloat green, CGFloat blue) {
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(colorChangedWithNewColor:)]) {
                    [weakSelf.delegate colorChangedWithNewColor:[UIColor colorWithRed:red/kMaxColorValue green:green/kMaxColorValue blue:blue/kMaxColorValue alpha:1.0]];
                }
                
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(colorChangedWithRed:green:blue:)]) {
                    [weakSelf.delegate colorChangedWithRed:red green:green blue:blue];
                }
            }];
        }
    }
    
    _endPoint = CGPointZero;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    _endPoint = CGPointZero;
}

#pragma mark - Delegate
#pragma mark -

#pragma mark - BrightnessOperationViewDelegate

- (void)brightnessDidChanged:(NSInteger)brightNumber
{
    [self changeBrightnessLayerWithBrightnessNumber:brightNumber];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(brightnessChangedWithNumber:)]) {
        [self.delegate brightnessChangedWithNumber:brightNumber];
    }
}


@end
