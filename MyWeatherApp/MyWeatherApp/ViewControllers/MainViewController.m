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

-(void) viewDidLoad {
    [super viewDidLoad];
    self.fetchedCities = [NSMutableArray array];
    _table.allowsMultipleSelectionDuringEditing = false;
    [self fetchWithSort2];
    [self updateCitesNumbers];
}

-(void) didChooseValue:(City*) city {
    [self saveData:city];
    [self fetchWithSort2];
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

-(void) fetchWithSort2 {
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
       context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest * fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"CityEntity"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"number" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    self.fetchedResultsController = [[NSFetchedResultsController alloc]
                                              initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    NSLog(@"%@",[self.fetchedResultsController fetchedObjects] );
}


-(void) updateCitesNumbers {
    int counter = 0;
    NSLog(@"%@",[self.fetchedResultsController fetchedObjects]);
    for (City* city in [self.fetchedResultsController fetchedObjects]) {
        counter+=1;
        city.number = counter;
    }
    [appDelegate saveContext];
    NSLog(@"%@",[self.fetchedResultsController fetchedObjects]);
}

-(void) printResultsFromArray:(NSArray <City*>*) cities {
    for (City *city in cities) {
        NSLog(@"%@,%@,%f,%f", city.city,city.country,city.lat,city.lng);
    }
}


#pragma mark -Tableview methods-

- (void)configureCell:(UITableViewCell *)cell withObject:(City *)object {
    cell.textLabel.text = object.city;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString* identifier = @"cityCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    City* city = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    [self configureCell:cell withObject:(City*) city];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
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

        NSManagedObject* object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        [context deleteObject:object];
        
        [appDelegate saveContext];
        [self updateCitesNumbers];
        [self.table reloadData];
    }
}

@end
