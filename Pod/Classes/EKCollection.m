//
// <EmojiKit/EKCollection.m>
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

#import "EKCollection.h"

#import "EKEmoji.h"

@implementation EKCollection

- (instancetype)initWithEmoji:(NSArray *)emoji {
    if (self = [super init]) {
        [self loadEmoji:emoji];
    }
    
    return self;
}

- (void)loadEmoji:(NSArray *)emoji {
    NSMutableArray *collection = [NSMutableArray array];
    
    for (id eachItem in emoji) {
        EKEmoji *anEmoji = [EKEmoji new];
        if ([eachItem isKindOfClass:[NSDictionary class]]) {
            anEmoji.image = [UIImage imageNamed:eachItem[EKEmojiImageNameKey]];
            anEmoji.title = eachItem[EKEmojiTitleNameKey];
            anEmoji.name = eachItem[EKEmojiImageNameKey];
        }
        else if ([eachItem isKindOfClass:[NSString class]]) {
            anEmoji.image = [UIImage imageNamed:eachItem];
            anEmoji.name = eachItem;
        }
        else continue;
        
        [collection addObject:anEmoji];
    }
    
    self.emoji = collection;
}

@end
