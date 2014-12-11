//
//  UIBuyGoldVIew.m
//  SpriteDemo
//
//  Created by Le Cong on 12/11/14.
//  Copyright (c) 2014 Lê Công. All rights reserved.
//

#import "UIBuyGoldVIew.h"

@implementation UIBuyGoldVIew 

- (UIView *)viewForContentView {
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(54, 30, 460, 243)];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(190, 19, 83, 30)];
    lbl.text = @"BUY GOLD";
    lbl.font = [UIFont boldSystemFontOfSize:18];
    lbl.textColor = [UIColor whiteColor];
    [lbl sizeToFit];
    
    UITableView *tbl = [[UITableView alloc] initWithFrame:CGRectMake(24, 51, 412, 160)];
    tbl.backgroundColor = [UIColor clearColor];
    tbl.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbl.showsVerticalScrollIndicator = NO;
    tbl.delegate = self;
    tbl.dataSource = self;
    
    [contentView addSubview:tbl];
    [contentView addSubview:lbl];
    return contentView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = @"Test";
    return cell;
}
@end
