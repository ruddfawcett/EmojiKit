//
//  EKViewController.m
//  EmojiKit
//
//  Created by Rudd Fawcett on 01/01/2015.
//  Copyright (c) 2014 Rudd Fawcett. All rights reserved.
//

#import "EKViewController.h"

#import "EKTemplateViewController.h"

@interface EKViewController ()

@property (strong, nonatomic) NSArray *examples;

@end

@implementation EKViewController

- (id)init {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        self.examples = @[@{@"prefix":@"Seinfeld", @"columns":@(3)}, @{@"prefix":@"NBA", @"columns":@(4)}];
        self.title = @"EmojiKit Demo";
    }
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.examples.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @"EmojiKit \u00A9 2015 Rudd Fawcett.\n\nEmoji designed by Kevin McCauley.\n\n\nNBA Emoji \u00A9 2014-2015 BleacherReport.com";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.examples[indexPath.row][@"prefix"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *prefix = self.examples[indexPath.row][@"prefix"];
    CGFloat columns = [self.examples[indexPath.row][@"columns"] floatValue];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    EKTemplateViewController *templateController = [[EKTemplateViewController alloc] initWithPrefix:prefix andColumns:columns];
    [self.navigationController pushViewController:templateController animated:YES];
}

@end
