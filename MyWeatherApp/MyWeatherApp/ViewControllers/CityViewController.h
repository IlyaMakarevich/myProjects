//
//  CityViewController.h
//  MyWeatherApp
//
//  Created by MacBook Pro  on 19.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"
#import "Weather.h"
#import "CustomTableViewCell.h"



NS_ASSUME_NONNULL_BEGIN

@interface CityViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) City* cityInfo;
@property (strong, nonatomic) Weather* weather;
@property (strong, nonatomic) IBOutlet UITableView *weatherTableView;




@end

NS_ASSUME_NONNULL_END
