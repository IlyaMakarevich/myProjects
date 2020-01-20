//
//  BKFullCityWeatherInfoViewController
//  WeatherTestProject
//
//  Created by Bogdan Kuprenkov on 25/09/2016.
//  Copyright © 2016 Bogdan Kuprenkov. All rights reserved.
//

#import "BKFullCityWeatherInfoViewController.h"
#import "BKWeatherListTableViewController.h"
#import "BKWeatherData.h"

@interface BKFullCityWeatherInfoViewController ()

@end

@implementation BKFullCityWeatherInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(showPreviousView)];
    
    [self.view addGestureRecognizer:tap];
    
    [self updateUIWithWeatherData:self.weatherInfo];
}

#pragma mark - MyMethods

- (void) showPreviousView {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) updateUIWithWeatherData:(BKWeatherData *)data {
    self.cityNameLabel.text = data.cityName;
    self.weatherImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld", data.weatherCondition]];
    
    NSString *weatherStr = data.detailedWeatherCondition;
    weatherStr = [weatherStr capitalizedString];
    self.weatherLabel.text = [NSMutableString stringWithFormat:@"%@: %ld%% cloudiness",
                                                            weatherStr, [data.cloudiness integerValue]];
    
    self.tempLabel.text = [NSString stringWithFormat:@"%.f°", [data.temperature floatValue]];
    
    self.minMaxTempLabel.text = [NSString stringWithFormat:@"%.1f° / %.1f°",
                                                [data.minTemperature floatValue],
                                                [data.maxTemperature floatValue]];
    
    self.otherInfoLabel.text = [NSString stringWithFormat: @"Humidity: %ld%% | Wind: %.2f m/s",
                                                                    [data.humidity integerValue],
                                                                        [data.windSpeed floatValue]];
}

#pragma mark - Memory

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
