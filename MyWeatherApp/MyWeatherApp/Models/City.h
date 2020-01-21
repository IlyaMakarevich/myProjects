//
//  NSObject+City.h
//  MyWeatherApp
//
//  Created by MacBook Pro  on 19.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface City : NSObject

@property (strong, nonatomic)NSString* city;
@property (strong, nonatomic)NSString* country;
@property (assign, nonatomic)CLLocationDegrees lat;
@property (assign, nonatomic)CLLocationDegrees lng;
@property (assign, nonatomic)CLLocationCoordinate2D location;


- (id)initWithCity:(NSString *)aCity
           country:(NSString *)aCountry
               lat:(CLLocationDegrees)aLat
               lng:(CLLocationDegrees )aLng;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
