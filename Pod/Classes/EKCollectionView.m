//
// <EmojiKit/EKCollectionView.m>
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

#import "EKCollectionView.h"

#import "EKCollection.h"
#import "EKCollectionViewCell.h"

CGFloat EKCollectionViewPadding = 20;
CGFloat EKCollectionViewColumns = 4;
CGFloat EKCollectionViewRows = 2;

static NSString * const reuseIdentifier = @"EmojiCell";

@interface EKCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate>

/**
 *  The EKCollection for the collection view.
 */
@property (strong, nonatomic) EKCollection *collection;

@end

@implementation EKCollectionView

- (id)initWithFrame:(CGRect)frame andCollection:(EKCollection *)collection {
    if (self = [super initWithFrame:frame collectionViewLayout:[self flowLayout:frame]]) {
        self.collection = collection;
        
        self.pagingEnabled = YES;
        self.backgroundColor = UIColor.clearColor;
        self.showsHorizontalScrollIndicator = NO;
        self.dataSource = self;
        self.delegate = self;
        
        [self registerClass:[EKCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    }
    
    return self;
}

- (UICollectionViewFlowLayout *)flowLayout:(CGRect)frame {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    
    CGSize itemSize = CGSizeMake(frame.size.width/EKCollectionViewColumns, frame.size.height/EKCollectionViewRows);
    
    if (itemSize.height <= 0 || itemSize.width <= 0) {
        itemSize = CGSizeMake(0.01f, 0.01f);
    }
    
    layout.itemSize = itemSize;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    return layout;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collection.emoji.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EKCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.emoji = self.collection.emoji[indexPath.row];
    
    if (self.hideTitles) {
        cell.titleLabel.textColor = [UIColor clearColor];
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_collectionDelegate && [_collectionDelegate respondsToSelector:@selector(didSelectEmoji:)]) {
            [_collectionDelegate didSelectEmoji:self.collection.emoji[indexPath.row]];
        }
    });
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.frame.size.width;
    NSUInteger currentPage = self.contentOffset.x / pageWidth;

    dispatch_async(dispatch_get_main_queue(), ^(void) {
        if (_collectionDelegate && [_collectionDelegate respondsToSelector:@selector(didChangePage:)]) {
            [_collectionDelegate didChangePage:currentPage];
        }
    });
}

#pragma mark - Setters

- (void)setNumberOfColumns:(CGFloat)numberOfColumns {
    EKCollectionViewColumns = numberOfColumns;
    [self updatePageCount];
}

- (void)setNumberOfRows:(CGFloat)numberOfRows {
    EKCollectionViewRows = numberOfRows;
    [self updatePageCount];
}

- (void)setHideTitles:(BOOL)hideTitles {
    [self reloadData];
}

- (void)updatePageCount {
    self.collectionViewLayout = [self flowLayout:self.frame];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_collectionDelegate && [_collectionDelegate respondsToSelector:@selector(didUpdatePageCount:)]) {
            [_collectionDelegate didUpdatePageCount:ceilf(self.collection.emoji.count / (EKCollectionViewColumns * EKCollectionViewRows))];
        }
        
        if (_collectionDelegate && [_collectionDelegate respondsToSelector:@selector(shouldReload:)]) {
            [_collectionDelegate shouldReload:YES];
        }
    });
}

@end
