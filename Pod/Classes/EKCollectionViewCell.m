//
// <EmojiKit/EKCollectionViewCell.m>
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

#import "EKCollectionViewCell.h"

#import "EKEmoji.h"

@interface EKCollectionViewCell ()

/**
 *  The image view for the cell.
 */
@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation EKCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*.6)];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.center = self.contentView.center;
        
        [self.contentView addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-12, self.frame.size.width, 12)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = UIColor.darkGrayColor;
        _titleLabel.font = [UIFont systemFontOfSize:8];
        _titleLabel.numberOfLines = 1;
        
        [self.contentView addSubview:_titleLabel];
    }
    
    return self;
}

- (void)setEmoji:(EKEmoji *)emoji {
    _imageView.image = emoji.image;
    _titleLabel.text = emoji.title;
}

@end
