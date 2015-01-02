//
// <EmojiKit/EKCollectionView.h>
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

@class EKEmoji, EKCollection, EKCollectionViewCell;

@protocol EKCollectionDelegate <NSObject>

@optional

/**
 *  The delegate called when an emoji is selected.
 *
 *  @param emoji The EKEmoji object.
 */
- (void)didSelectEmoji:(EKEmoji *)emoji;

/**
 *  The delegate called if the number of pages in teh page controller should change.
 *
 *  @param number The number of pages.
 */
- (void)didUpdatePageCount:(NSUInteger)number;

/**
 *  The delegate called when the collection view scrolls to a new page.
 *
 *  @param page The page number.
 */
- (void)didChangePage:(NSUInteger)page;

/**
 *  The delegate called when the collection view should reload.  HACK
 *
 *  @param shouldReload Whether it should reload.
 */
- (void)shouldReload:(BOOL)shouldReload;

@end

/**
 *  The padding of the collection view.
 */
extern CGFloat EKCollectionViewPadding;
/**
 *  The number of columns in the collection view.
 */
extern CGFloat EKCollectionViewColumns;
/**
 *  The number of rows in the collection view.
 */
extern CGFloat EKCollectionViewRows;

@interface EKCollectionView : UICollectionView

/**
 *  Designated initializer for EKCollectionView, returns collection view.
 *
 *  @param frame      The frame of the collection view.
 *  @param collection The EKCollection object.
 *
 *  @return A new EKCollectionView.
 */
- (id)initWithFrame:(CGRect)frame andCollection:(EKCollection *)collection NS_DESIGNATED_INITIALIZER;

@property (nonatomic) id<EKCollectionDelegate> collectionDelegate;

/**
 *  Setter for the number of columns in the collection view.
 */
@property (nonatomic) CGFloat numberOfColumns; // Needs to be worked on - current system is hacky.
/**
 *  Setter for the number of rows in the collection view.
 */
@property (nonatomic) CGFloat numberOfRows; // Needs to be worked on - current system is hacky.

/**
 *  Whether the collection view should hide the titles of the items;
 */
@property (nonatomic) BOOL hideTitles;

@end
