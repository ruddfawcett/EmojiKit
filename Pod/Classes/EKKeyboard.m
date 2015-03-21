//
// <EmojiKit/EKKeyboard.m>
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

#import "EKKeyboard.h"

#import "EmojiKit.h"

@interface EKKeyboard () <EKKeyboardToggle, EKCollectionDelegate, UITextViewDelegate>

/**
 *  The rect of the keyboard.
 */
@property (nonatomic) CGRect keyboardFrame;

/**
 *  The page control to show the current page.
 */
@property (strong, nonatomic) UIPageControl *pageControl;

/**
 *  The acessoryView of the UITextView.
 */
@property (strong, nonatomic) EKAccessoryView *accessoryView;

/**
 *  The UIView that acts as the background for the keyboard.
 */
@property (strong, nonatomic) UIView *canvas;

/**
 *  Whether or not the collection view should be reinitialized because of the layout.  HACKY
 */
@property (nonatomic) BOOL reloadCollection;

@end

@implementation EKKeyboard

- (instancetype)initWithCollection:(EKCollection *)collection {
    if (self = [super init]) {
        self.collection = collection;

        self.accessoryView = [EKAccessoryView new];
        self.accessoryView.delegate = self;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardAppeared:)
                                                     name:UIKeyboardDidChangeFrameNotification object:nil];
        [self initializeCollectionView];
    }
    
    return self;
}

#pragma mark - UIKeyboardDidChangeFrameNotification

- (void)keyboardAppeared:(NSNotification *)notification {
    NSValue *value = notification.userInfo[UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardFrame = [self convertRect:[value CGRectValue] fromView:nil];

    keyboardFrame.origin.y += EKAcessoryViewHeight;
    keyboardFrame.size.height -= EKAcessoryViewHeight;
    self.keyboardFrame = keyboardFrame;
    
    CGRect newFrame = self.textView.frame;
    newFrame.size.height -= keyboardFrame.size.height + EKAcessoryViewHeight;
    
    self.textView.frame = newFrame;
    self.reloadCollection = YES;
}

- (void)attachToTextView:(UITextView *)textView {
    textView.inputAccessoryView = self.accessoryView;
    
    self.reloadCollection = YES;
    self.textView = textView;
    self.textView.delegate = self;
}

#pragma mark - EKToggleDelegate

- (void)shouldShowEmojiKeyboard:(BOOL)show {
    if (show) {
        [self showEmojiKeyboard];
    }
    else [self hideEmojiKeyboard];
}

- (void)showEmojiKeyboard {
    [self initializeCanvas];
    [self initializePageControl];

    if (self.reloadCollection) {
        [self initializeCollectionView];
    }
    
    [self.canvas addSubview:self.collectionView];
    [[self mainWindow].rootViewController.view addSubview:self.canvas];
}

- (void)hideEmojiKeyboard {
    [self.canvas performSelectorOnMainThread:@selector(removeFromSuperview) withObject:nil waitUntilDone:NO];
    self.canvas = nil;
}

#pragma mark - Initializers

- (void)initializeCanvas {
    self.canvas = [[UIView alloc] initWithFrame:self.keyboardFrame];
    self.canvas.backgroundColor = [UIColor colorWithRed:0.82 green:0.84 blue:0.86 alpha:1];
}

- (void)initializePageControl {
    if (self.pageControl == nil) {
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 1, self.keyboardFrame.size.width, 20)];
        self.pageControl.userInteractionEnabled = NO;
        self.pageControl.numberOfPages = ceilf(self.collection.emoji.count / (EKCollectionViewColumns * EKCollectionViewRows));
        self.pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
        self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    }
    
    [self.canvas addSubview:self.pageControl];
}

- (void)initializeCollectionView {
    CGFloat padding = 10;
    CGFloat height = self.keyboardFrame.size.height - (6 * padding);
    
    CGRect frame = CGRectMake(0, padding * 2, self.keyboardFrame.size.width, height);
    self.collectionView = [[EKCollectionView alloc] initWithFrame:frame andCollection:self.collection];
    self.collectionView.collectionDelegate = self;
    
    self.reloadCollection = NO;
}

- (UIWindow *)mainWindow {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    for (UIWindow *eachWindow in [[UIApplication sharedApplication] windows]) {
        if (![[eachWindow class] isEqual:[UIWindow class]]) {
            window = eachWindow;
            break;
        }
    }
    
    return window;
}

#pragma mark - Setters

- (void)backSpacePressed {
    // HANDLING + LOGIC FOR PLAIN TEXT STRING
    [self.textView deleteBackward];
}

- (void)spaceBarPressed {
    [self.plaintext insertString:@" " atIndex:self.textView.selectedRange.location];
    [self.textView insertText:@" "];
}

- (void)setEmojiPrefix:(NSString *)emojiPrefix {
    self.accessoryView.emojiPrefix = emojiPrefix;
}

#pragma mark - EKCollectionDelegate

- (void)didSelectEmoji:(EKEmoji *)emoji {
    self.textView.tintColor = [UIColor clearColor];
    NSRange selectedRange = self.textView.selectedRange;
    UIFont *font = self.textView.font;
    
    CGFloat scale = [[UIScreen mainScreen] scale];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];
    
    if (self.plaintext == nil) {
        self.plaintext = [[attributedString string] mutableCopy];
    }
    
    NSTextAttachment *attachment = [NSTextAttachment new];
    attachment.image = [emoji.image scaledToHeight:font.ascender * scale];
    
    CGFloat buffer = (font.ascender * scale) * -0.0590861;
    
    attachment.bounds = CGRectMake(0, buffer, attachment.image.size.width/scale, font.ascender);
    
    NSAttributedString *newString = [NSAttributedString attributedStringWithAttachment:attachment];
    
    [attributedString insertAttributedString:newString atIndex:selectedRange.location];
    NSLog(@"%@",attributedString);
    [self.plaintext appendString:[NSString stringWithFormat:@":%@:",emoji.name]];
    
    self.textView.attributedText = attributedString;
    self.textView.font = font;
    self.textView.selectedRange = NSMakeRange(selectedRange.location+1, selectedRange.length);
    self.textView.tintColor = [UIColor clearColor];
    
    NSLog(@"%@",self.plaintext);
}

- (void)didChangePage:(NSUInteger)page {
    self.pageControl.currentPage = page;
}

- (void)didUpdatePageCount:(NSUInteger)number {
    self.pageControl.numberOfPages = number;
}

- (void)shouldReload:(BOOL)shouldReload {
    self.pageControl.currentPage = 0;
    self.reloadCollection = shouldReload;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidEndEditing:(UITextView *)textView {
    [self.accessoryView resetSelection];
    [self hideEmojiKeyboard];
}

- (void)viewDidAppear:(BOOL)animated {

}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
