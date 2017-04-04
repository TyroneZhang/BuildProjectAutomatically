# TYColorDisk
Copyright (c) 2015 Tyrone Zhang. All rights reserved.
[git access to ](https://github.com/TyroneZhang).

## License

Created by Demon_Yao on 7/30/15.
Copyright (c) 2015 Tyrone Zhang. All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


## What is this?
The project is mainly used for providing a comfortable UE(user experience) about color selecting.
In my oroject,it was used for smart home industry(such as smart light,to dimming the light color).
TYColorDisk has a wide range of color.

Here is an gif file which can show you what it exactly does.("ColorDisk.gif" file in the project.)

## How to use this project?

The color disk provides red[0, 255],green[0, 255],blue[0,255] and white[0, N(default : 100)] number. If you want to get RGB or white number,you should implement `TYAnnulusColorViewDelegate`.
To get UIColor value,you should implement SEL of `- (void)colorChangedWithNewColor:(UIColor *)color`.
To get RGB value,you should implement SEL of `- (void)colorChangedWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue`.
To get white value,you should implement SEL of `- (void)brightnessChangedWithNumber:(NSInteger)brihtnessNumber`.
