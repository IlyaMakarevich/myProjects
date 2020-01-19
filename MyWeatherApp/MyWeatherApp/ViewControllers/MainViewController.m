//
//  UIViewController+MainViewController.m
//  MyWeatherApp
//
//  Created by MacBook Pro  on 18.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController()
@property (strong, nonatomic) NSArray* locationsArray;

@end

@implementation MainViewController


-(void) viewDidLoad {
    [super viewDidLoad];
    _locationsArray = [NSArray arrayWithObjects:@"1",@"2",@"3", nil];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString* identifier = @"cityCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    NSString* string = [self.locationsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = string;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _locationsArray.count;
}

@end
