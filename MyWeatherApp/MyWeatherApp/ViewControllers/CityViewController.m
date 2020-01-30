//
//  CityViewController.m
//  MyWeatherApp
//
//  Created by MacBook Pro  on 19.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "CityViewController.h"
#import "CustomTableViewCell.h"
#import "Constants.h"
#import "AFNetworking.h"
#import "Weather.h"

@interface CityViewController ()
@end

@implementation CityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self searchWeather];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *nowCellIdentifier = @"nowCell";
    CustomTableViewCell *nowCell = [tableView dequeueReusableCellWithIdentifier:nowCellIdentifier];
    if (nowCell == nil) {
       nowCell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nowCellIdentifier] ;
     }
    NSString* locationCity = _cityInfo.city;
//    NSString* locationCountry = _cityInfo.country;
//    NSString *lat = [[NSString alloc] initWithFormat:@"%f", _cityInfo.lat];
//    NSString *lng = [[NSString alloc] initWithFormat:@"%f", _cityInfo.lng];

    NSLog(@"%@ %@ %@", _weather.currentForecast.summary, _weather.currentForecast.temperatureCelsius, _weather.currentForecast.windSpeed);

    if (_weather.currentForecast.temperature == NULL) {
        nowCell.locationLabel.text = locationCity;
        nowCell.tempLabel.text = @"";
        nowCell.conditionsLabel.text = @"";
    } else {
        [UIView animateWithDuration:1.0
        animations:^{
            nowCell.tempLabel.alpha = 0.0f;
            nowCell.conditionsLabel.alpha = 0.0f;
            nowCell.tempLabel.text = [NSString stringWithFormat:@"%@ ℃", self.weather.currentForecast.temperatureCelsius];
            nowCell.conditionsLabel.text = self.weather.currentForecast.summary;
            nowCell.tempLabel.alpha = 1.0f;
            nowCell.conditionsLabel.alpha = 1.0f;
        }];
    }
    return nowCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
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
