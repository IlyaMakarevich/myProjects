//
//  UIViewController+MainViewController.m
//  MyWeatherApp
//
//  Created by MacBook Pro  on 18.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "MainViewController.h"
#import "SearchViewController.h"


@interface MainViewController()
@property (strong, nonatomic) NSMutableArray* locationsArray;
@end

@implementation MainViewController


-(void) didChooseValue:(NSObject*) city {
    [self.locationsArray addObject:city];
    [self.table reloadData];
}

-(void)addCity:(id)sender {
    
    SearchViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
    vc.delegate = self;
    UINavigationController *objNav = [[UINavigationController alloc] initWithRootViewController:vc];
    [objNav setModalPresentationStyle:UIModalPresentationFullScreen];
    [self.navigationController pushViewController:vc animated:YES];
   // [self presentViewController:objNav animated:YES completion:nil];
    NSLog(@"+ tapped");
}

-(void) viewDidLoad {
    [super viewDidLoad];
    _locationsArray = [[NSMutableArray alloc] init];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString* identifier = @"cityCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    NSString* string = [self.locationsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [string description];

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _locationsArray.count;
}

@end
