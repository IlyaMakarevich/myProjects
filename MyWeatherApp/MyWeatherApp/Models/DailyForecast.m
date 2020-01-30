//
//  DailyForecast.m
//  MyWeatherApp
//
//  Created by Ilya Makarevich on 1/30/20.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "DailyForecast.h"

@implementation DailyForecast


-(id)initWithDailyDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        _temperatureMax = [self temperatureFormatter:dictionary[@"apparentTemperatureMax"]];
        _temperatureMin = [self temperatureFormatter:dictionary[@"apparentTemperatureMin"]];
        _pressure = dictionary[@"pressure"];
        _dewPoint = dictionary[@"dewPoint"];
        _visibility = dictionary[@"visibility"];
        _windBearing = dictionary[@"windBearing"];
        _humidity = dictionary[@"humidity"];
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

@end
