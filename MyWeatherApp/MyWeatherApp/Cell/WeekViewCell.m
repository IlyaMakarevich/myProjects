//
//  WeekViewCell.m
//  MyWeatherApp
//
//  Created by Ilya Makarevich on 1/30/20.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "WeekViewCell.h"
#import "WeekForecast.h"

@implementation WeekViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) configureForWeekForecast:(WeekForecast *)weekForecast {
    [[self summary] setText:[weekForecast summary]];
    [[self dayLabel] setText:[self unixTimeStampToDate:[weekForecast time]]];
    [[self minTempLabel] setText:[[NSString alloc] initWithFormat:@"Min: %@˚C",weekForecast.temperatureCelsiusMin]];
    [[self maxTempLabel] setText:[[NSString alloc] initWithFormat:@"Max: %@˚C",weekForecast.temperatureCelsiusMax]];
    [[self humidityLabel] setText:[[NSString alloc] initWithFormat:@"Humidity: %@%%",weekForecast.humidity]];
    [[self dewPointLabel] setText:[[NSString alloc] initWithFormat:@"Dew point: %@ F",weekForecast.dewPoint ]];
    [[self visibilityLabel] setText:[[NSString alloc] initWithFormat:@"Visibility %@ km",weekForecast.visibility]];
    [[self pressureLabel] setText:[[NSString alloc] initWithFormat:@"Pressure %@mb",weekForecast.pressure]];
    [[self sunriseLabel] setText:[[NSString alloc] initWithFormat:@"Sunrise at %@",[self unixTimeStampToHHMMDate:weekForecast.sunrise]]];
    [[self sunsetLabel] setText:[[NSString alloc] initWithFormat:@"Sunrise at %@",[self unixTimeStampToHHMMDate:weekForecast.sunset]]];

}

-(NSString *)unixTimeStampToDate:(NSString *)timeStamp{
    NSTimeInterval interval = [timeStamp doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EE, MMM d"];
    return [formatter stringFromDate:date];
}

-(NSString *)unixTimeStampToHHMMDate:(NSString *)timeStamp{
    if (!timeStamp) {
        return nil;
    }
    NSTimeInterval _interval=[timeStamp doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setDateFormat:@"HH:mm"];
    return [_formatter stringFromDate:date];
}

@end
