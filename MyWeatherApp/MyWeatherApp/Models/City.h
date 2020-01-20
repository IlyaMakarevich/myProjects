//
//  NSObject+City.h
//  MyWeatherApp
//
//  Created by MacBook Pro  on 19.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property (strong, nonatomic)NSString *city;
@property (strong, nonatomic)NSString *country;
@property (assign, nonatomic)NSInteger lat;
@property (assign, nonatomic)NSInteger lon;

- (id)initWithCity:(NSString *)aCity
           country:(NSString *)aCountry
               lat:(NSInteger)aLat
               lon:(NSInteger)aLon;


- (id)initWithDictionary:(NSDictionary *)dic;

@end
