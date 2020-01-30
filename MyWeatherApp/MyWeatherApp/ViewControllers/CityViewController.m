//
//  CityViewController.m
//  MyWeatherApp
//
//  Created by MacBook Pro  on 19.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "CityViewController.h"
#import "CustomTableViewCell.h"
#import "WeekViewCell.h"
#import "Constants.h"
#import "AFNetworking.h"
#import "Weather.h"
#import "DailyForecast.h"

@interface CityViewController ()
@end

@implementation CityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _weatherTableView.bounces = NO;
    [self.view bringSubviewToFront:self.weatherTableView];
    [self searchWeather];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *nowCellIdentifier = @"nowCell";
     static NSString *dailyCellIdentifier = @"dailyCell";


    if (indexPath.row == 0) {
        CustomTableViewCell *nowCell = [tableView dequeueReusableCellWithIdentifier:nowCellIdentifier];
        if (nowCell == nil) {
           nowCell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nowCellIdentifier] ;
         }
        NSString* locationCity = _cityInfo.city;
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

        else {
        WeekViewCell *dailyCell = [tableView dequeueReusableCellWithIdentifier:dailyCellIdentifier];
        if (dailyCell == nil) {
            [[NSBundle mainBundle] loadNibNamed:@"WeekViewCell" owner:self options:nil];
            dailyCell = _weekCell;
            _weekCell = nil;
        }
        DailyForecast *daily = [_weather.dailyForecasts objectAtIndex:indexPath.row];
        [[dailyCell summary] setText:[daily summary]];
        [[dailyCell dayLabel] setText:[self unixTimeStampToDate:[daily time]]];
        [[dailyCell minTempLabel] setText:[[NSString alloc] initWithFormat:@"Min: %@˚C",daily.temperatureCelsiusMin]];
        [[dailyCell maxTempLabel] setText:[[NSString alloc] initWithFormat:@"Max: %@˚C",daily.temperatureCelsiusMax]];
        [[dailyCell humidityLabel] setText:[[NSString alloc] initWithFormat:@"Humidity: %@",daily.humidity]];
        [[dailyCell dewPointLabel] setText:[[NSString alloc] initWithFormat:@"Dew point: %@",daily.dewPoint ]];
        [[dailyCell visibilityLabel] setText:[[NSString alloc] initWithFormat:@"Visibility %@ km",daily.visibility]];
        [[dailyCell pressureLabel] setText:[[NSString alloc] initWithFormat:@"Pressure %@mb",daily.pressure]];
        [[dailyCell sunriseLabel] setText:[[NSString alloc] initWithFormat:@"Sunrise at %@",[self unixTimeStampToHHMMDate:daily.sunrise]]];
        [[dailyCell sunsetLabel] setText:[[NSString alloc] initWithFormat:@"Sunrise at %@",[self unixTimeStampToHHMMDate:daily.sunset]]];
        return dailyCell;
    }
    }



//@property (strong, nonatomic) IBOutlet UILabel *sunriseLabel;
//@property (strong, nonatomic) IBOutlet UILabel *sunsetLabel;


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
        return @"Today weather";
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


-(NSString *)unixTimeStampToDate:(NSString *)timeStamp{
    NSTimeInterval interval = [timeStamp doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EE, MMM d"];
    return [formatter stringFromDate:date];
}

-(NSString *)unixTimeStampToHHMMDate:(NSString *)timeStamp{
    if (!timeStamp) {
        return nil;
    }
    NSTimeInterval _interval=[timeStamp doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setDateFormat:@"HH:mm"];
    return [_formatter stringFromDate:date];
}


@end
