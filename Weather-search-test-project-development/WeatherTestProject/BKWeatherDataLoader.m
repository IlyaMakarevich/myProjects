//
//  DataRetrive.m
//  WeatherTestProject
//
//  Created by admin on 11/20/16.
//  Copyright © 2016 Bogdan Kuprenkov. All rights reserved.
//

#import "BKWeatherDataLoader.h"
#import "AFNetworking.h"

@implementation BKWeatherDataLoader

- (void)loadWeatherDataWithCity:(NSString * _Nonnull)city completionHandler:(nullable void (^)(BKWeatherData * _Nullable weatherData, NSError * _Nullable error))completionHandler {
    city = [city stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSMutableString *URLString = [NSMutableString string];
    
    [URLString appendFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@&units=metric&appid=661e5bd10c0d253805b46565dfedc2e4", city];
    
    AFURLSessionManager *manager = [AFURLSessionManager new];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request
                                                completionHandler:^(NSURLResponse * _Nonnull response,
                                                                    id  _Nullable responseObject,
                                                                    NSError * _Nullable error) {
                                                    
        BKWeatherData *weatherData = [self weatherDataWithDictionary:responseObject];
        
        completionHandler(weatherData, error);
    }];
    
    [dataTask resume];
}

- (BKWeatherData *)weatherDataWithDictionary:(NSDictionary *)dictionary {
    BKWeatherData *weatherData = [[BKWeatherData alloc] init];
    
    weatherData.weatherCondition = [self weatherConditionWithDictionary:dictionary];
    
    weatherData.detailedWeatherCondition = dictionary[@"weather"][0][@"description"];
    weatherData.cityName = [NSString stringWithFormat:@"%@, %@", dictionary[@"name"], dictionary[@"sys"][@"country"]];
    weatherData.temperature = dictionary[@"main"][@"temp"];
    weatherData.minTemperature = dictionary[@"main"][@"temp_min"];
    weatherData.maxTemperature = dictionary[@"main"][@"temp_max"];
    weatherData.windSpeed = dictionary[@"wind"][@"speed"];
    weatherData.cloudiness = dictionary[@"clouds"][@"all"];
    weatherData.humidity = dictionary[@"main"][@"humidity"];
    
    return weatherData;
}

- (BKWeatherCondition)weatherConditionWithDictionary:(NSDictionary *)dictionary {
    NSInteger weatherID =  [dictionary[@"weather"][0][@"id"] integerValue];
    
    if (weatherID == 800) {
        return BKWeatherConditionClear;
    } else if (weatherID == 801) {
        return BKWeatherConditionFewClouds;
    } else if (weatherID == 802) {
        return BKWeatherConditionClouds;
    } else if ((weatherID / 100) == 2) {
        return BKWeatherConditionThunderstorm;
    } else if ((weatherID / 100) == 7) {
        return BKWeatherConditionAtmosphere;
    } else if ((weatherID / 100) == 8) {
        return BKWeatherConditionBrokenClouds;
    } else if (((weatherID / 100) == 6) || (weatherID == 511)) {
        return BKWeatherConditionSnow;
    } else if ((weatherID / 10) == 50) {
        return BKWeatherConditionRain;
    } else return BKWeatherConditionDrizzle;
}

@end
