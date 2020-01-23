//
//  SearchViewController.m
//  MyWeatherApp
//
//  Created by MacBook Pro  on 19.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "SearchViewController.h"
#import "Constants.h"
#import "AFNetworking.h"



@interface SearchViewController ()

@property (strong, nonatomic)NSString* searchTextValue;
@end

@implementation SearchViewController
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    _citySearchBar.text = @"enter city...";
    self.title = @"Search";
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
    cell.textLabel.text = [self.cities[indexPath.row] description];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected section>> %ld",(long)indexPath.section);
    NSLog(@"Selected row of section >> %ld",(long)indexPath.row);
    
    if ([self.delegate respondsToSelector:@selector(didChooseValue:)]) {
        [self.delegate didChooseValue:self.cities[indexPath.row]];
    }
    

    [self.navigationController popViewControllerAnimated:YES];

    //NSString* info = [self.cities[indexPath.row] description];
    /*IAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"INFO"
                                                                     message:((void)(@"%@"),info)
                                                              preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok"
                                                       style:UIAlertActionStyleCancel
                                                     handler:nil];

    [alertVC addAction:okAction];

    [self presentViewController:alertVC animated:YES completion:nil];*/

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
    if (self.searchTextValue.length > 1 ) {
         [self searchCity];
    }

}

-(void) searchCity {
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager GET: @"https://api.opencagedata.com/geocode/v1/json"
        parameters:@{@"q" : self.searchTextValue,
                   @"key" : CITY_API_KEY }
        progress:nil success:^(NSURLSessionDataTask * task, id responseObject) {
        NSDictionary* responseDict = responseObject;
        NSLog(@"JSON: %@",responseDict);

        NSMutableArray* tempCities = [[NSMutableArray alloc] init];
        
        for(NSDictionary* dic in responseDict[@"results"]) {
            City* city = [[City alloc]
                          initWithCity:[[dic valueForKey:@"components"] objectForKey:@"state"]
                          country:[[dic valueForKey:@"components"] objectForKey:@"country"]
                          lat:[[[dic valueForKey:@"geometry"] objectForKey:@"lat"] doubleValue]
                          lng:[[[dic valueForKey:@"geometry"] objectForKey:@"lng"] doubleValue]];
            [tempCities addObject:city];
            [tempCities description];
        }
        
        self.cities = [[NSArray alloc]initWithArray:tempCities];
        tempCities = nil;
        for (City* city in self.cities) {
            NSLog(@"%@", city);
        }
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

- (IBAction)closeBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
