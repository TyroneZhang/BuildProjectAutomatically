//
//  BrightnessOperationView.h
//  TYColorDisk
//
//  Created by Demon_Yao on 8/3/15.
//  Copyright (c) 2015 Tyrone Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const NSInteger kMaxOfBrightnessNumber;

@protocol BrightnessOperationViewDelegate <NSObject>

- (void)brightnessDidChanged:(NSInteger)brightNumber;

@end

@interface BrightnessOperationView : UIView

@property (nonatomic, weak) id<BrightnessOperationViewDelegate> delegate;

@end
