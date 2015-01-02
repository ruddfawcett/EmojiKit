//
// <EmojiKit/EKAccessoryView.h>
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

#import <UIKit/UIKit.h>

@class EKAccessoryView, EKToggleButton;

@protocol EKKeyboardToggle <NSObject>

@required

/**
 *  Callback whether the emoji keyboard should be shown.
 *
 *  @param show BOOL - YES or NO.
 */
- (void)shouldShowEmojiKeyboard:(BOOL)show;

@end

/**
 *  The type of toggle buttons, mainly just used for indexes.
 */
typedef NS_ENUM(NSUInteger, EKToggleButtons) {
    /**
     *  The index of the keyboard button in the array.
     */
    EKButtonKeyboard,
    /**
     *  The index of the emoji button in the array.
     */
    EKButtonEmoji
};

/**
 *  The height of the accessory view.
 */
extern const CGFloat EKAcessoryViewHeight;

@interface EKAccessoryView : UIView

/**
 *  The delegate of the accessory view.
 */
@property (strong, nonatomic) id<EKKeyboardToggle> delegate;

/**
 *  The prefix for the emoji - e.g. 'Emoji' -> 'Seinfeld Emoji'
 */
@property (strong, nonatomic) NSString *emojiPrefix;

/**
 *  Reset the buttons.
 */
- (void)resetSelection;

@end
