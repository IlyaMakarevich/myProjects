//
//  Weather.m
//  MyWeatherApp
//
//  Created by Ilya Makarevich on 1/29/20.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "Weather.h"
#import "WeekForecast.h"

@implementation Weather

-(id)initWithWeatherDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        _currentForecast = [[CurrentForecast alloc]initWithCurrentlyDictionary:dictionary[@"currently"]];
        _dailyForecasts = [[NSMutableArray alloc] init];
        for (NSDictionary *dailyDictionary in dictionary[@"daily"][@"data"]) {
            WeekForecast *dailyWeather = [[WeekForecast alloc] initWithDailyDictionary:dailyDictionary];
            [self.dailyForecasts addObject:dailyWeather];
        }
    }
    return self;
}

@end
