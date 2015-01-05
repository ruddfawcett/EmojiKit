//
// <EmojiKit/EKToggleButton.m>
//
// Copyright (c) 2015 Rudd Fawcett <http://ruddfawcett.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "EKToggleButton.h"

#import "EmojiKit.h"

@implementation EKToggleButton

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        self.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.800 green:0.800 blue:0.800 alpha:1.00]] forState:UIControlStateHighlighted];
    }
    
    return self;
}

#pragma mark - Setters

- (void)setSelected:(BOOL)selected {
    self.backgroundColor = selected ? [UIColor colorWithRed:0.82 green:0.84 blue:0.86 alpha:1] : [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1];
    
    if (selected) {
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.82 green:0.84 blue:0.86 alpha:1]] forState:UIControlStateHighlighted];
    }
    else {
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.800 green:0.800 blue:0.800 alpha:1.00]] forState:UIControlStateHighlighted];
    }
}

@end
