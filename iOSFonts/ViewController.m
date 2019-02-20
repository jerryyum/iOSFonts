//
//  ViewController.m
//  iOSFonts
//
//  Created by yumiao on 16/05/2017.
//  Copyright © 2017 chianyu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"iOS系统字体库";
    
    [self printAllFonts];
    
    [self addFontTableView];
}

// 输出所有字体名称
- (void)printAllFonts {
    NSMutableString *mutableString = [[NSMutableString alloc] init];
    NSArray<NSString *> *familyNames = [UIFont familyNames];
    for (NSString *familyName in familyNames) {
        [mutableString appendFormat:@"%@\n", familyName];
        
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for(NSString *fontName in fontNames) {
            [mutableString appendFormat:@"    %@\n", fontName];
        }
    }
    NSLog(@"\n============>>>>>\n%@<<<<<============\n", mutableString);
}

- (void)addFontTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.sectionHeaderHeight = 30.f;
    tableView.sectionFooterHeight = 0.f;
    tableView.rowHeight = 60.f;
    [self.view addSubview:tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [UIFont familyNames].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *familyName = [[UIFont familyNames] objectAtIndex:section];
    NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
    return fontNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellRID = @"cellRID";
    static NSString *cellContent = @"12345, abcd ABCD, iOS系统字体库 ~!@#$%^&*()";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellRID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellRID];
    }
    
    NSString *familyName = [[UIFont familyNames] objectAtIndex:indexPath.section];
    NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
    NSString *fontName = [fontNames objectAtIndex:indexPath.row];
    
    cell.textLabel.text = fontName;
    cell.detailTextLabel.text = cellContent;
    cell.detailTextLabel.font = [UIFont fontWithName:fontName size:15.f];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *familyName = [[UIFont familyNames] objectAtIndex:section];
    return familyName;
}

@end
