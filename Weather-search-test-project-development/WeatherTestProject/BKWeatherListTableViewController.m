//
//  BKWeatherListTableViewController.h
//  WeatherTestProject
//
//  Created by Bogdan Kuprenkov on 23/09/2016.
//  Copyright © 2016 Bogdan Kuprenkov. All rights reserved.
//

#import "BKEnterCityViewController.h"
#import "BKWeatherListTableViewController.h"
#import "BKFullCityWeatherInfoViewController.h"
#import "BKWeatherTableViewCell.h"
#import "BKWeatherData.h"

@interface BKWeatherListTableViewController () <UITableViewDataSource, UITableViewDelegate, BKWeatherDataDelegate>

@property (strong, nonatomic) NSMutableArray *weatherList;
@property (assign, nonatomic) NSInteger tableViewRowCount;

@end

@implementation BKWeatherListTableViewController

#pragma mark - ViewMethods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:NO];
}

#pragma mark - Initialization

- (NSMutableArray *)weatherList {
    if (!_weatherList) {
        _weatherList = [NSMutableArray array];
    }
    
    return _weatherList;
}

- (NSInteger)tableViewRowCount {
    if (!_tableViewRowCount) {
        _tableViewRowCount = 0;
    }
    
    return _tableViewRowCount;
}

#pragma mark - MyMethods

- (void)clearDataUsedForTableView {
    self.weatherList = nil;
    self.tableViewRowCount = 0;
}

#pragma mark - BKWeatherDataDelegate

- (void)viewController:(UIViewController *)controller didReceiveWeatherData:(NSMutableArray *)data {
    [self.weatherList addObject:data];
    self.tableViewRowCount = self.weatherList.count;
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BKFullCityWeatherInfoViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FullCityInfo"];
    
    // Show next screen if selected cell is not deleting last row; otherwise clear data and update table view
    if (indexPath.row != self.tableViewRowCount) {
        viewController.weatherInfo = [self.weatherList objectAtIndex:indexPath.row];
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.navigationController pushViewController:viewController animated:YES];
    } else {
        [self clearDataUsedForTableView];
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Hide deleting last row when there's nothing to delete
    if (self.tableViewRowCount == 0) {
        return self.tableViewRowCount;
    } else return self.tableViewRowCount + 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ((indexPath.row == self.tableViewRowCount) && (self.tableViewRowCount != 0)) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DeleteCell"];
        return cell;
    } else {
        BKWeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityWeatherCell"];
        
        BKWeatherData *weatherData = [self.weatherList objectAtIndex:indexPath.row];
        
        cell.weatherIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld", weatherData.weatherCondition]];
        cell.temperatureLabel.text = [NSString stringWithFormat:@"%.f°", [weatherData.temperature floatValue]];
        cell.cityNameLabel.text = weatherData.cityName;
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableViewRowCount == 1) {
        [self clearDataUsedForTableView];
        [self.tableView reloadData];
    } else {
        [tableView beginUpdates];
        
        if ((editingStyle == UITableViewCellEditingStyleDelete) && (indexPath.row != self.tableViewRowCount)) {
            self.tableViewRowCount--;
            
            [self.weatherList removeObjectAtIndex:indexPath.row];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        }
        
        [tableView endUpdates];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Navigation to enter city view controller"]) {
        BKEnterCityViewController *viewController = [segue destinationViewController];
        
        viewController.delegate = self;
    }
}

#pragma mark - Memory

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
