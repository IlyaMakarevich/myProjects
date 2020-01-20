//
//  Constants.h
//  MyWeatherApp
//
//  Created by MacBook Pro  on 19.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import <Foundation/Foundation.h>

#define CITY_URL @"https://api.opencagedata.com/geocode/v1/json?q=Minsk&key=df1cec4851fb4f5fbb632a272d56b5b3";
#define CITY_API_KEY @"df1cec4851fb4f5fbb632a272d56b5b3";
#define WEATHER_URL @"https://api.darksky.net/forecast/01c2b10d7bc3a9012d5bcbb055ade7c8/53.9,27.5";
#define WEATHER_API_KEY @"01c2b10d7bc3a9012d5bcbb055ade7c8";


@interface Constants : NSObject

@end
