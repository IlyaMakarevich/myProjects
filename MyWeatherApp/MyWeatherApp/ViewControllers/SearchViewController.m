//
//  SearchViewController.m
//  MyWeatherApp
//
//  Created by MacBook Pro  on 19.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "SearchViewController.h"
#import "AFNetworking.h"
#import "Constants.h"
#import "City.h"

@interface SearchViewController ()
@property (strong, nonatomic)NSArray* cities;
@property (strong, nonatomic)NSString* searchTextValue;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _citySearchBar.text = @"enter city...";
    self.title = @"Search";
    
    //for test
    self.cities = @[@"Minsk",@"Brest",@"Vitebsk"];
}

#pragma mark - TableView data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.cities[indexPath.row];
    return cell;
}

#pragma mark - Search bar

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    NSLog(@"start editing");
    [searchBar becomeFirstResponder];
    searchBar.text = @"";
}

-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.searchTextValue = searchText;
    NSLog(@"%@", self.searchTextValue);
    [self searchCity];
}

-(void) searchCity {
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager GET: @"https://api.opencagedata.com/geocode/v1/json?q=Minsk&key=df1cec4851fb4f5fbb632a272d56b5b3" parameters:nil progress:nil success:^(NSURLSessionDataTask * task, id responseObject) {
        NSArray* jsonArray = (NSArray *) responseObject;
        NSLog(@"%@",jsonArray);
        NSMutableArray* tempCities = [[NSMutableArray alloc] init];
        
        for(NSDictionary* dic in jsonArray) {
            City* city = [[City alloc] initWithDictionary:dic];
            [tempCities addObject:city];
        }
        
        self.cities = [[NSArray alloc]initWithArray:tempCities];
        tempCities = nil;
        [self.tableView reloadData];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Error Retrieving Cities"
                                                                     message:[error localizedDescription]
                                                              preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok"
                                                       style:UIAlertActionStyleCancel
                                                     handler:nil];
    
    [alertVC addAction:okAction];
    
    [self presentViewController:alertVC animated:YES completion:nil];
    }];
}

@end
