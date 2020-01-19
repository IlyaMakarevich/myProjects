//
//  BKWeatherData.h
//  WeatherTestProject
//
//  Created by admin on 12/2/16.
//  Copyright © 2016 Bogdan Kuprenkov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BKWeatherCondition) {
    BKWeatherConditionClear = 1,
    BKWeatherConditionFewClouds = 2,
    BKWeatherConditionClouds = 3,
    BKWeatherConditionBrokenClouds = 4,
    BKWeatherConditionRain = 9,
    BKWeatherConditionDrizzle = 10,
    BKWeatherConditionThunderstorm = 12,
    BKWeatherConditionSnow = 13,
    BKWeatherConditionAtmosphere = 50
};

@interface BKWeatherData : NSObject

@property (assign, nonatomic) BKWeatherCondition weatherCondition;
@property (strong, nonatomic) NSString *detailedWeatherCondition;
@property (strong, nonatomic) NSString *cityName;
@property (strong, nonatomic) NSNumber *temperature;
@property (strong, nonatomic) NSNumber *minTemperature;
@property (strong, nonatomic) NSNumber *maxTemperature;
@property (strong, nonatomic) NSNumber *windSpeed;
@property (strong, nonatomic) NSNumber *cloudiness;
@property (strong, nonatomic) NSNumber *humidity;

@end
