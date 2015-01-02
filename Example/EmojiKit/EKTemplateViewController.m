//
//  EKTemplateViewController.m
//  EmojiKit
//
//  Created by Rudd Fawcett on 1/1/15.
//  Copyright (c) 2015 Rudd Fawcett. All rights reserved.
//

#import "EKTemplateViewController.h"

@interface EKTemplateViewController ()

@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) EKKeyboard *emojiKeyboard;

@end

@implementation EKTemplateViewController

- (id)initWithPrefix:(NSString *)prefix andColumns:(CGFloat)columns {
    if (self = [super init]) {
        self.textView = [[UITextView alloc] initWithFrame:self.view.bounds];
        self.textView.font = [UIFont systemFontOfSize:30];
        [self.view addSubview:self.textView];
        
        NSString *json = [[NSBundle mainBundle] pathForResource:[prefix lowercaseString] ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:json];
        
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        NSMutableArray *combined = [NSMutableArray array];
        
        for (NSDictionary *dict in array) {
            NSDictionary *each = @{EKEmojiTitleNameKey : dict[@"title"], EKEmojiImageNameKey : dict[@"image"]};
            [combined addObject:each];
        }
        
        EKCollection *collection = [[EKCollection alloc] initWithEmoji:combined];
        
        self.emojiKeyboard = [[EKKeyboard alloc] initWithCollection:collection];
        self.emojiKeyboard.emojiPrefix = prefix;
        
        self.title = prefix;
        if ([prefix isEqualToString:@"NBA"]) {
            self.navigationItem.prompt = @"Emoji \u00A9 2014-2015 BleacherReport.com";
        }
        
        self.emojiKeyboard.collectionView.numberOfColumns = columns;
        [self.emojiKeyboard attachToTextView:self.textView];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
