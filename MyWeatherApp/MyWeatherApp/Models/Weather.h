//
//  Weather.h
//  MyWeatherApp
//
//  Created by Ilya Makarevich on 1/29/20.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Weather : NSObject


@property (strong, nonatomic) NSString *temp;
@property (strong, nonatomic) NSString *wind;
@property (strong, nonatomic) NSString *summary;


- (id)initWithTemp: (NSString*) temp
                wind:(NSString*) wind
                     summary:(NSString*) summary;

- (id)initWithDictionary:(NSDictionary *)dic;


@end

NS_ASSUME_NONNULL_END
