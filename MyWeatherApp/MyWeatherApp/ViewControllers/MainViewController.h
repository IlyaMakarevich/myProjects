//
//  UIViewController+MainViewController.h
//  MyWeatherApp
//
//  Created by MacBook Pro  on 18.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//


#import <UIKit/UIKit.h>
#import "SearchViewController.h"
#import "CityViewController.h"
#import <CoreData/CoreData.h>


NS_ASSUME_NONNULL_BEGIN
@protocol CoreDataTableViewDelegate;

@interface MainViewController: UIViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, SearchDelegate>

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) NSMutableArray* fetchedCities;
@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

- (IBAction)addCity:(id)sender;

@end


NS_ASSUME_NONNULL_END
