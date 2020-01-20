//
//  NSObject+City.h
//  MyWeatherApp
//
//  Created by MacBook Pro  on 19.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property (strong, nonatomic)NSString* city;
@property (strong, nonatomic)NSString* country;
@property (assign, nonatomic)NSNumber* lat;
@property (assign, nonatomic)NSNumber* lng;

- (id)initWithCity:(NSString *)aCity
           country:(NSString *)aCountry
               lat:(NSNumber *)aLat
               lng:(NSNumber *)aLng;


- (id)initWithDictionary:(NSDictionary *)dic;

@end
