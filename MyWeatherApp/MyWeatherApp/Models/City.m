//
//  NSObject+City.m
//  MyWeatherApp
//
//  Created by MacBook Pro  on 19.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "City.h"



@implementation City

//The designated initializer
- (instancetype)initWithCity:(NSString *)aCity
                     country:(NSString *)aCountry
                         lat:(NSInteger)aLat
                         lon:(NSInteger)aLon{
    self = [super init];
    
    if (self) {
        self.city = aCity;
        self.country = aCountry;
        self.lat = aLat;
        self.lon = aLon;
    }
    
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [self initWithCity:dic[@"city"] country:dic[@"country"] lat:dic[@"lat"] lon:dic[@"lon"]];
    return self;
}

-(instancetype) init {
    self = [self initWithCity:@"undefined" country:@"undefined" lat:0 lon:0];
    return self;
}

-(NSString*) description {
    return [NSString stringWithFormat:@"%@: %@", self.city, self.country];
}


@end
