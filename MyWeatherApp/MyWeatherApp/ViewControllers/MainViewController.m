//
//  UIViewController+MainViewController.m
//  MyWeatherApp
//
//  Created by MacBook Pro  on 18.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "MainViewController.h"
#import "SearchViewController.h"
#import "AppDelegate.h"


@interface MainViewController() {
    AppDelegate* appDelegate;
    NSManagedObjectContext* context;
    NSArray* dictionaries;
}
@property (strong, nonatomic) NSMutableArray* locationsArray;
@end

@implementation MainViewController


-(void) didChooseValue:(City*) city {
    [self.locationsArray addObject:city];
    [self saveData:city];
    [self.table reloadData];
}

-(void)addCity:(id)sender {
    
    SearchViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
    vc.delegate = self;
    UINavigationController *objNav = [[UINavigationController alloc] initWithRootViewController:vc];
    [objNav setModalPresentationStyle:UIModalPresentationFullScreen];
    [self.navigationController pushViewController:vc animated:YES];
   // [self presentViewController:objNav animated:YES completion:nil];
    NSLog(@"+ tapped");
}

-(void) viewDidLoad {
    [super viewDidLoad];
    _locationsArray = [[NSMutableArray alloc] init];
    _table.allowsMultipleSelectionDuringEditing = false;
    
    //Get Context
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    context = appDelegate.persistentContainer.viewContext;
    
    //Load data
    NSFetchRequest* requestCity = [NSFetchRequest fetchRequestWithEntityName:@"CityEntity"];
    NSArray* results = [context executeFetchRequest:requestCity error:nil];
    NSLog(@"%@", results);
    //Log data
    NSLog(@"City is %@", [results valueForKey:@"city"]);
    NSLog(@"Country is %@", [results valueForKey:@"country"]);
    NSLog(@"lat is %@", [results valueForKey:@"lat"]);
    NSLog(@"lng is %@", [results valueForKey:@"lng"]);

    [_locationsArray addObjectsFromArray:results];

}

#pragma mark -Core data methods-

-(void) saveData:(City*)city {
    NSManagedObject* entityObj = [NSEntityDescription insertNewObjectForEntityForName:@"CityEntity" inManagedObjectContext:context];
    [entityObj setValue:city.city forKey:@"city"];
    [entityObj setValue:city.country forKey:@"country"];
    [entityObj setValue:[NSNumber numberWithDouble:city.lat] forKey:@"lat"];
    [entityObj setValue:[NSNumber numberWithDouble:city.lat] forKey:@"lng"];
    [appDelegate saveContext];
}


-(void) deleteObject:(int)number {
    
}

#pragma mark -Tableview methods-

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString* identifier = @"cityCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    NSLog(@"%@",_locationsArray);
    
    NSString* cityName = [[self.locationsArray valueForKey:@"city"] objectAtIndex:indexPath.row];
    NSString* countryName = [[self.locationsArray valueForKey:@"country"] objectAtIndex:indexPath.row];

    cell.textLabel.text = [NSString stringWithFormat:@"%@, %@", cityName, countryName];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _locationsArray.count;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        [self.locationsArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

@end
