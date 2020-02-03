//
//  WeekForecast.m
//  MyWeatherApp
//
//  Created by Ilya Makarevich on 1/30/20.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "WeekForecast.h"

@implementation WeekForecast


-(id)initWithDailyDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        _temperatureMax = [self temperatureFormatter:dictionary[@"apparentTemperatureMax"]];
        _temperatureMin = [self temperatureFormatter:dictionary[@"apparentTemperatureMin"]];
        _pressure = dictionary[@"pressure"];
        _dewPoint = [self dewPointFormatter:dictionary[@"dewPoint"]];
        _visibility = [self visibilityFormatter: dictionary[@"visibility"]];
        _windBearing = dictionary[@"windBearing"];
        _humidity = [self humidityFormatter:dictionary[@"humidity"]];
        _summary = dictionary[@"summary"];
        _time = dictionary[@"time"];
        _temperatureCelsiusMax = [self fahrenheitToCelsius:dictionary[@"apparentTemperatureMax"]];
        _temperatureCelsiusMin = [self fahrenheitToCelsius:dictionary[@"apparentTemperatureMin"]];
        _sunrise = dictionary[@"sunriseTime"];
        _sunset = dictionary[@"sunsetTime"];
    }
    return self;
}

-(NSString *)fahrenheitToCelsius:(NSString *)temperature{
    return [[NSString alloc] initWithFormat:@"%.01f",(([temperature doubleValue] - 32) * 5 / 9)];
}
-(NSString *)temperatureFormatter:(NSString *)temperature{
    return [[NSString alloc] initWithFormat:@"%.0f", [temperature doubleValue]];
}
-(NSString *)humidityFormatter:(NSString *)humidity{
    return [[NSString alloc] initWithFormat:@"%.0f", [humidity doubleValue] * 100];
}

-(NSString *)dewPointFormatter:(NSString *)dewPoint{
    return [[NSString alloc] initWithFormat:@"%.0f", [dewPoint doubleValue]];
}

-(NSString *)visibilityFormatter:(NSString *)visibility{
    return [[NSString alloc] initWithFormat:@"%.0f", [visibility doubleValue]];
}

@end
