//
//  WeekForecast.h
//  MyWeatherApp
//
//  Created by Ilya Makarevich on 1/30/20.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeekForecast : NSObject

@property(strong, nonatomic) NSString *temperatureMax;
@property(strong, nonatomic) NSString *temperatureMin;
@property(strong, nonatomic) NSString *humidity;
@property(strong, nonatomic) NSString *dewPoint;
@property(strong, nonatomic) NSString *visibility;
@property(strong, nonatomic) NSString *pressure;
@property(strong, nonatomic) NSString *windBearing;
@property(strong, nonatomic) NSString *time;
@property(strong, nonatomic) NSString *summary;
@property(strong, nonatomic) NSString *temperatureCelsiusMax;
@property(strong, nonatomic) NSString *temperatureCelsiusMin;
@property(strong, nonatomic) NSString *sunrise;
@property(strong, nonatomic) NSString *sunset;

-(id)initWithDailyDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
