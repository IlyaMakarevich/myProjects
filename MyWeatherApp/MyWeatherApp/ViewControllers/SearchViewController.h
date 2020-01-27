//
//  SearchViewController.h
//  MyWeatherApp
//
//  Created by MacBook Pro  on 19.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import <UIKit/UIKit.h>


#import "City.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SearchDelegate;

@interface SearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>


@property (weak, nonatomic) IBOutlet UISearchBar *citySearchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)closeBtn:(id)sender;



@property (weak, nonatomic) id <SearchDelegate> delegate;
@property (strong, nonatomic) NSArray* cities;
@end

@protocol SearchDelegate <NSObject>
@required
-(void) didChooseValue:(NSObject*) city;
@end
NS_ASSUME_NONNULL_END
