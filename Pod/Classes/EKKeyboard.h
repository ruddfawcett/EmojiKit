//
// <EmojiKit/EKKeyboard.h>
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "UIImage+EmojiKit.h"

@class EKEmoji, EKCollection, EKAccessoryView, EKCollectionView;

@interface EKKeyboard : UIView


- (instancetype)initWithCollection:(EKCollection *)collection NS_DESIGNATED_INITIALIZER;

- (void)attachToTextView:(UITextView *)textView;

/**
 *  The collection loaded to show the emoji.
 */
@property (strong, nonatomic, readwrite) EKCollection *collection;

/**
 *  The EKCollectionView for the keyboard.
 */
@property (strong, nonatomic) EKCollectionView *collectionView;

/**
 *  The text view that the keyboard is attached to.
 */
@property (strong, nonatomic, readwrite) UITextView *textView;

/**
 *  The prefix for the emoji - e.g. 'Emoji' -> 'Seinfeld Emoji'
 */
@property (strong, nonatomic) NSString *emojiPrefix;
/**
 *  The plaintext of emoji converted to a string (e.g. test :emojiname:).
 */
@property (strong, nonatomic) NSMutableString *plaintext;

@end
