//
//  ViewController.m
//  TYColorDisk
//
//  Created by Demon_Yao on 7/30/15.
//  Copyright (c) 2015 Tyrone Zhang. All rights reserved.
//

#import "ViewController.h"
#import "TYAnnulusColorView.h"

@interface ViewController () <TYAnnulusColorViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *lightImageView;
@property (weak, nonatomic) IBOutlet UILabel *brightLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"halo"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.lightImageView.image = image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - TYAnnulusColorViewDelegate
#pragma mark -

- (void)colorChangedWithNewColor:(UIColor *)color
{
    self.view.tintColor = color;
}

- (void)colorChangedWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue
{

}

- (void)brightnessChangedWithNumber:(NSInteger)brihtnessNumber
{
    self.brightLabel.text = [NSString stringWithFormat:@"%ld%%",brihtnessNumber];
}

@end
