//
//  Weather.h
//  MyWeatherApp
//
//  Created by Ilya Makarevich on 1/29/20.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CurrentForecast.h"

NS_ASSUME_NONNULL_BEGIN

@interface Weather : NSObject

@property(strong, nonatomic) CurrentForecast *currentForecast;
@property(strong, nonatomic) NSMutableArray *dailyForecasts;


-(id)initWithWeatherDictionary:(NSDictionary *)dictionary;



@end

NS_ASSUME_NONNULL_END
