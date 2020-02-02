//
//  CityViewController.m
//  MyWeatherApp
//
//  Created by MacBook Pro  on 19.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "CityViewController.h"
#import "TodayViewCell.h"
#import "WeekViewCell.h"
#import "Constants.h"
#import "AFNetworking.h"
#import "Weather.h"
#import "WeekForecast.h"

@interface CityViewController ()
@end

@implementation CityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.activityIndicator.hidden = false;
    self.weatherTableView.hidden = true;
    [_activityIndicator startAnimating];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self searchWeather];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *nowCellIdentifier = @"currentCell";
    static NSString *dailyCellIdentifier = @"weekCell";

    if (indexPath.row == 0 && indexPath.section == 0) {
        TodayViewCell *nowCell = [tableView dequeueReusableCellWithIdentifier:nowCellIdentifier];
        if (nowCell == nil) {
            nowCell = [[TodayViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nowCellIdentifier] ;
        }
        [nowCell configureForTodayForecast:_weather.currentForecast location:_cityInfo];
        return nowCell;
    }

    else {
        WeekViewCell *dailyCell = [tableView dequeueReusableCellWithIdentifier:dailyCellIdentifier];
        if (dailyCell == nil) {
            [[NSBundle mainBundle] loadNibNamed:@"WeekViewCell" owner:self options:nil];
            dailyCell = _weekCell;
            _weekCell = nil;
        }
        WeekForecast *weekForecast = [_weather.dailyForecasts objectAtIndex:indexPath.row];
        [dailyCell configureForWeekForecast:weekForecast];
        return dailyCell;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section)
    {    case 0: return 1;
            break;
        case 1: return 7;
            break;
        default:
            return 0;
            break;
    }

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section)
    {    case 0: return @"Today";
            break;
        case 1: return @"Week";
            break;
        default:
            return nil;
            break;
    }
}


-(void) searchWeather {
    NSString *lat = [[NSString alloc] initWithFormat:@"%f", _cityInfo.lat];
    NSString *lng = [[NSString alloc] initWithFormat:@"%f", _cityInfo.lng];

    NSString* URL = [NSString stringWithFormat:@"%@/%@/%@,%@", WEATHER_URL, WEATHER_API_KEY, lat,lng];

    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager GET: URL
      parameters: nil
        progress:nil success:^(NSURLSessionDataTask * task, id responseObject) {
        NSDictionary* responseDict = responseObject;
        self.weather = [[Weather alloc] initWithWeatherDictionary:responseDict];
        NSLog(@"%@", [self.weather description]);
        NSLog(@"%@", [self.weather.dailyForecasts description]);
        self.activityIndicator.hidden = true;
        self.weatherTableView.hidden = false;
        [self.activityIndicator stopAnimating];
        [self.weatherTableView reloadData];



    } failure:^(NSURLSessionTask *operation, NSError *error) {

        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Error Retrieving Cities"
                                                                         message:[error localizedDescription]
                                                                  preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];

        [alertVC addAction:okAction];

        [self presentViewController:alertVC animated:YES completion:nil];
    }];
}


@end
