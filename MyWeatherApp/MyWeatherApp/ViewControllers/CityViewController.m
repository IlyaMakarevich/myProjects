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
    return 200;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"cell1";
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
       cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier] ;
     }
    NSString* locationCity = _cityInfo.city;
//    NSString* locationCountry = _cityInfo.country;
//    NSString *lat = [[NSString alloc] initWithFormat:@"%f", _cityInfo.lat];
//    NSString *lng = [[NSString alloc] initWithFormat:@"%f", _cityInfo.lng];

    NSLog(@"%@ %@ %@", _weather.summary, _weather.temp, _weather.wind);
    cell.locationLabel.text = locationCity;
    cell.tempLabel.text = [NSString stringWithFormat:@"%@ ℃", _weather.temp];
    cell.conditionsLabel.text = _weather.summary;
    return cell;
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
        NSLog(@"JSON: %@",responseDict[@"currently"]);
        self.weather = [[Weather alloc]initWithTemp:
                        [[responseDict valueForKey:@"currently"] objectForKey:@"temperature"]
                        wind:[[responseDict valueForKey:@"currently"] objectForKey:@"windSpeed"]
                                             summary:[[responseDict valueForKey:@"currently"] objectForKey:@"summary"]];
        double tempF = [self.weather.temp doubleValue];
        double tempC = (tempF - 32) / 1.8;
        self.weather.temp = [NSString stringWithFormat:@"%.1f", tempC];
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
