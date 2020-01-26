//
//  UIViewController+MainViewController.h
//  MyWeatherApp
//
//  Created by MacBook Pro  on 18.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//


#import <UIKit/UIKit.h>
#import "SearchViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainViewController: UIViewController <UITableViewDelegate, UITableViewDataSource, SearchDelegate>

@property (weak, nonatomic) IBOutlet UITableView *table;


- (IBAction)addCity:(id)sender;

@end

NS_ASSUME_NONNULL_END
