//
//  CustomTableViewCell.m
//  MyWeatherApp
//
//  Created by Ilya Makarevich on 1/29/20.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "TodayViewCell.h"
#import "CurrentForecast.h"
#import "City.h"


@implementation TodayViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void) configureForTodayForecast:(CurrentForecast*) currentForecast location: (City*) location {
    if (currentForecast.temperature == NULL) {
               self.locationLabel.text = location.city;
               self.tempLabel.text = @"";
               self.conditionsLabel.text = @"";
           } else {
               [UIView animateWithDuration:1.0
                                animations:^{
                   self.tempLabel.alpha = 0.0f;
                   self.conditionsLabel.alpha = 0.0f;
                   self.tempLabel.text = [NSString stringWithFormat:@"%@ ℃", currentForecast.temperatureCelsius];
                   self.conditionsLabel.text = currentForecast.summary;
                   self.tempLabel.alpha = 1.0f;
                   self.conditionsLabel.alpha = 1.0f;
               }];
           }
}

@end
