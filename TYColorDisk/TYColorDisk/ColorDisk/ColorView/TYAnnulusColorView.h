//
//  TYAnnulusColorView.h
//  TYColorDisk
//
//  Created by Demon_Yao on 7/30/15.
//  Copyright (c) 2015 Tyrone Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TYAnnulusColorViewDelegate <NSObject>

@optional
- (void)colorChangedWithNewColor:(UIColor *)color;
- (void)colorChangedWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

- (void)brightnessChangedWithNumber:(NSInteger)brihtnessNumber;

@end

@interface TYAnnulusColorView : UIView

@property (nonatomic, weak) IBOutlet id<TYAnnulusColorViewDelegate> delegate;

@end
