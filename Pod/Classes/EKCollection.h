//
// <EmojiKit/EKCollection.h>
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

@class EKEmoji;

/**
 *  The key for an image of an emoji.
 */
#define EKEmojiImageNameKey @"EKEmojiImageNameKey"
/**
 *  The key for a title of an emoji.
 */
#define EKEmojiTitleNameKey @"EKEmojiTitleNameKey"

@interface EKCollection : NSObject

/**
 *  Initializes a collection with a array of potential emoji.
 *
 *  @param emoji The potential emoji.
 *
 *  @return An EKCollection.
 */
- (instancetype)initWithEmoji:(NSArray *)emoji NS_DESIGNATED_INITIALIZER;

/**
 *  The array of emoji in a collection.
 */
@property (strong, nonatomic) NSArray *emoji;

@end
