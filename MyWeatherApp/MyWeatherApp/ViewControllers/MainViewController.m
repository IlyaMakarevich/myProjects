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

@end

@implementation MainViewController


-(void) didChooseValue:(City*) city {
    NSLog(@"%@", _fetchedCities);
    [_fetchedCities addObject:city];
    NSLog(@"%@", _fetchedCities);
    [self saveData:city];
    [self updateCitesNumbers];
    [self.table reloadData];
}

- (IBAction)edit:(UIBarButtonItem *)sender {
    if (self.table.isEditing) {
        self.table.editing = NO;
    } else {
        self.table.editing = YES;
    }
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
    self.fetchedCities = [NSMutableArray array];
    _table.allowsMultipleSelectionDuringEditing = false;
    [self fetchWithSort];
    [self updateCitesNumbers];
}

#pragma mark -Core data methods-

-(void) saveData:(City*)city {
   // NSNumber *count = [NSNumber numberWithInteger:self.locationsArray.count];
    NSManagedObject* entityObj = [NSEntityDescription insertNewObjectForEntityForName:@"CityEntity" inManagedObjectContext:context];
    [entityObj setValue:city.city forKey:@"city"];
    [entityObj setValue:city.country forKey:@"country"];
    [entityObj setValue:[NSNumber numberWithDouble:city.lat] forKey:@"lat"];
    [entityObj setValue:[NSNumber numberWithDouble:city.lng] forKey:@"lng"];
    [entityObj setValue:[NSNumber numberWithInt:city.number] forKey:@"number"];

    [appDelegate saveContext];
}


-(void) deleteObject:(int)number {
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    context = appDelegate.persistentContainer.viewContext;
}

-(void) basicFetch {
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
       context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:@"CityEntity"];
    NSArray* results = [context executeFetchRequest:request error:nil];
    [_fetchedCities setArray:results];
    [self printResultsFromArray:_fetchedCities];
}

-(void) fetchWithSort {
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
       context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:@"CityEntity"];
    NSSortDescriptor* cityDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"number" ascending:YES];
    request.sortDescriptors = @[cityDescriptor];
   NSArray* results = [context executeFetchRequest:request error:nil];
   [_fetchedCities setArray:results];
   [self printResultsFromArray:_fetchedCities];
}

-(NSArray <NSManagedObject*>*) fetchArray {
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
       context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:@"CityEntity"];
    NSPredicate* predicate = nil;
    request.predicate = predicate;
    NSArray <NSManagedObject*>* cities = [context executeFetchRequest:request error:nil];
    return cities;
}

-(void) updateCitesNumbers {
    int counter = 0;
    NSLog(@"%@",_fetchedCities);
    for (City* city in _fetchedCities) {
        counter+=1;
        city.number = counter;
    }
    [appDelegate saveContext];
    NSLog(@"%@",_fetchedCities);
}



-(void) printResultsFromArray:(NSArray <City*>*) cities {
    for (City *city in cities) {
        NSLog(@"%@,%@,%f,%f", city.city,city.country,city.lat,city.lng);
    }
}


#pragma mark -Tableview methods-

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString* identifier = @"cityCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    NSLog(@"%@",_fetchedCities);
    
    NSString* cityName = [[_fetchedCities valueForKey:@"city"] objectAtIndex:indexPath.row];
    NSString* countryName = [[_fetchedCities valueForKey:@"country"] objectAtIndex:indexPath.row];
    NSString* countryNumber = [[_fetchedCities valueForKey:@"number"] objectAtIndex:indexPath.row];

    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@, %@", countryNumber, cityName, countryName];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _fetchedCities.count;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
   return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath{
    
 }

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        context = appDelegate.persistentContainer.viewContext;

        City* cityToDelete = [_fetchedCities objectAtIndex:indexPath.row];
        [_fetchedCities removeObject:cityToDelete];
       
        NSManagedObject* object = [self fetchArray][indexPath.row];
        [context deleteObject:object];
        
        [appDelegate saveContext];
        [self updateCitesNumbers];
        [self.table reloadData];
    }
}

@end
