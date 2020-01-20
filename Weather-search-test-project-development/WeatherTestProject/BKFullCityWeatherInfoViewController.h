//
//  BKFullCityWeatherInfoViewController
//  WeatherTestProject
//
//  Created by Bogdan Kuprenkov on 25/09/2016.
//  Copyright © 2016 Bogdan Kuprenkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BKWeatherData.h"

@interface BKFullCityWeatherInfoViewController : UIViewController

@property (strong, nonatomic) BKWeatherData *weatherInfo;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *minMaxTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *otherInfoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;

@end
