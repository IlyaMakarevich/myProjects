//
//  BKWeatherTableViewCell.h
//  WeatherTestProject
//
//  Created by admin on 11/26/16.
//  Copyright © 2016 Bogdan Kuprenkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKWeatherTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;

@end
