//
// <EmojiKit/EKAccessoryView.m>
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

#import "EKAccessoryView.h"

#import "EKToggleButton.h"

/**
 *  The height of the accessory view.
 */
const CGFloat EKAcessoryViewHeight = 30;

@interface EKAccessoryView ()

/**
 *  The array of buttons.
 */
@property (strong, nonatomic) NSMutableArray *toggleButtons;

/**
 *  The current selected button.
 */
@property (nonatomic) EKToggleButtons selectedButton;

@end

@implementation EKAccessoryView

- (id)init {
    if (self = [super initWithFrame:CGRectMake(0, 0, self.superview.bounds.size.width, EKAcessoryViewHeight)]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addButtons:@[@"Keyboard", @"Emoji"]]; // Localize these
    }
    
    return self;
}

- (void)addButtons:(NSArray *)buttons {
    CGFloat width = [[UIScreen mainScreen] bounds].size.width/buttons.count;
    
    self.toggleButtons = [NSMutableArray array];
    self.selectedButton = EKButtonKeyboard;
    
    for (int i = 0; i < buttons.count; i++) {
        CGFloat x = i == EKButtonKeyboard ? 0 : EKButtonEmoji * width;
        CGRect frame = CGRectMake(x, 0, width, EKAcessoryViewHeight);
        
        EKToggleButton *titleButton = [[EKToggleButton alloc] initWithFrame:frame andTitle:buttons[i]];
        titleButton.selected = i == EKButtonKeyboard ? YES : NO;
        titleButton.tag = i;
        
        [titleButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.toggleButtons addObject:titleButton];
        [self addSubview:titleButton];
    }
}

- (void)buttonPressed:(id)sender {
    EKToggleButton *button = (EKToggleButton *)sender;
    if (button.tag == self.selectedButton) {
        return;
    }
    
    self.selectedButton = button.tag;
    button.selected = YES;
    
    BOOL showKeyboard = button.tag == EKButtonKeyboard ? NO : YES;
    NSUInteger index = showKeyboard ? EKButtonKeyboard : EKButtonEmoji;
    
    [(EKToggleButton *)self.toggleButtons[index] setSelected:NO];
    
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        if (_delegate && [_delegate respondsToSelector:@selector(shouldShowEmojiKeyboard:)]) {
            [_delegate shouldShowEmojiKeyboard:showKeyboard];
        }
    });
}

- (void)setEmojiPrefix:(NSString *)emojiPrefix {
    EKToggleButton *button = (EKToggleButton *)self.toggleButtons[EKButtonEmoji];
    [button setTitle:[NSString stringWithFormat:@"%@ Emoji", emojiPrefix] forState:UIControlStateNormal];
}

- (void)resetSelection {
    self.selectedButton = EKButtonKeyboard;
    [(EKToggleButton *)self.toggleButtons[EKButtonKeyboard] setSelected:YES];
    [(EKToggleButton *)self.toggleButtons[EKButtonEmoji] setSelected:NO];
}

@end
