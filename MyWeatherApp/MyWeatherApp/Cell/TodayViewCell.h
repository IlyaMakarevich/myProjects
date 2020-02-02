//
//  CustomTableViewCell.h
//  MyWeatherApp
//
//  Created by Ilya Makarevich on 1/29/20.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurrentForecast.h"
#import "City.h"

NS_ASSUME_NONNULL_BEGIN

@interface TodayViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *tempLabel;
@property (strong, nonatomic) IBOutlet UILabel *conditionsLabel;

-(void) configureForTodayForecast:(CurrentForecast*) currentForecast location: (City*) location;

@end

NS_ASSUME_NONNULL_END
