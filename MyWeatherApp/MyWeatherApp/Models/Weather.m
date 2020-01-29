//
//  Weather.m
//  MyWeatherApp
//
//  Created by Ilya Makarevich on 1/29/20.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "Weather.h"

@implementation Weather

- (id)initWithTemp:(NSString *)temp
              wind:(NSString *)wind
            summary:(NSString *)summary {
    self = [super init];
    if (self) {
        _temp = temp;
        _wind = wind;
        _summary = summary;
    }
    return self;

}

-(id)initWithDictionary:(NSDictionary *)dic {
    self = [self initWithTemp:dic[@"temperature"] wind:dic[@"windSpeed"] summary:dic[@"summary"]];
    return self;
}


@end
