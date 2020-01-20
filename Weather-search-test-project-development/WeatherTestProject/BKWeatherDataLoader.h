//
//  BKWeatherDataLoader.h
//  WeatherTestProject
//
//  Created by admin on 11/20/16.
//  Copyright © 2016 Bogdan Kuprenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BKWeatherData.h"

@interface BKWeatherDataLoader : NSObject

- (void)loadWeatherDataWithCity:(NSString * _Nonnull)city completionHandler:(nullable void (^)(BKWeatherData * _Nullable weatherData, NSError * _Nullable error))completionHandler;

@end
