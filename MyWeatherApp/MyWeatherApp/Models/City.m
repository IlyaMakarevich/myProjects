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
- (instancetype)initWithCity:(NSString*)aCity
                     country:(NSString*)aCountry
                         lat:(NSNumber*)aLat
                         lng:(NSNumber*)aLng{
    self = [super init];
    
    if (self) {
        self.city = aCity;
        self.country = aCountry;
        self.lat = aLat;
        self.lng = aLng;
    }
    
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [self initWithCity:dic[@"state"] country:dic[@"country"] lat:dic[@"lat"] lng:dic[@"lng"]];
    return self;
}

-(instancetype) init {
    self = [self initWithCity:@"undefined" country:@"undefined" lat:0 lng:0];
    return self;
}

-(NSString*) description {
    return [NSString stringWithFormat:@"%@, %@ - [%@, %@]", [self city], [self country], [self lat ], [self lng] ];
}



@end
