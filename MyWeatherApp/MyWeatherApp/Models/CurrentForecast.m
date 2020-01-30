//
//  CurrentForecast.m
//  MyWeatherApp
//
//  Created by Ilya Makarevich on 1/30/20.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "CurrentForecast.h"

@implementation CurrentForecast

-(id)initWithCurrentlyDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        _feelsLikeTemp = [self temperatureFormatter: dictionary[@"apparentTemperature"]];
        _pressure = dictionary[@"pressure"];
        _precipIntensity = dictionary[@"precipIntensity"];
        _precipProbability = dictionary[@"precipProbability"];
        _temperature = [self temperatureFormatter:dictionary[@"temperature"]];
        _time = dictionary[@"time"];
        _summary = dictionary[@"summary"];
        _temperatureCelsius = [self fahrenheitToCelsius:dictionary[@"temperature"]];
        _windSpeed = dictionary[@"windSpeed"];
        _windBearing = [self windBearingForCompassSectors:dictionary[@"windBearing"]];
        _visibility = dictionary[@"visibility"];
        _dewPoint = dictionary[@"dewPoint"];
    }
    return self;
}

-(NSNumber *)windBearingForCompassSectors:(id)windBearing{
    if (!windBearing) {
        NSException *exception = [NSException exceptionWithName:@"InvalidInputException" reason:@"Argument was nil." userInfo:nil];
        @throw exception;
    }
    int windBearingValue = [(NSNumber *)windBearing doubleValue];
    int index = (windBearingValue + 11.25)/22.5;
    return [[NSNumber alloc] initWithInt:index % 16];
}

-(NSString *)fahrenheitToCelsius:(NSString *)temperature{
    if (!temperature) {
        NSException *exception = [NSException exceptionWithName:@"InvalidInputException" reason:@"Argument was nil." userInfo:nil];
        @throw exception;
    }

    return [[NSString alloc] initWithFormat:@"%.01f",(([temperature doubleValue] - 32) * 5 / 9)];
}

-(NSString *)temperatureFormatter:(NSString *)temperature{
    if (!temperature) {
        NSException *exception = [NSException exceptionWithName:@"InvalidInputException" reason:@"Argument was nil" userInfo:nil];
        @throw exception;
    }
    return [[NSString alloc] initWithFormat:@"%.0f", [temperature doubleValue]];
}

@end

